import 'dart:async';

import 'package:bike_rental/app/models/user_model.dart';
import 'package:bike_rental/app/services/remote_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController extends GetxController {
  late SharedPreferences sharedPrefs;

  final Rx<UserModel?> me = Rx<UserModel?>(null);
  bool isFirstLaunch = true;
  String? accessToken; // token for API requests

  late final StreamSubscription<UserModel?> meSubscription;

  @override
  void onInit() async {
    await initFromStorage();
    meSubscription =
        getMeStream().listen((newMe) => me.value = newMe, cancelOnError: false);
    super.onInit();
  }

  @override
  void onClose() {
    meSubscription.cancel();
  }

  initFromStorage() async {
    sharedPrefs = await SharedPreferences.getInstance();
    isFirstLaunch = sharedPrefs.getBool('isFirstLaunch') ?? true;
    accessToken = sharedPrefs.getString('token');
    // Todo:
    // if accessToken not null try refresh token
    if (accessToken != null && accessToken!.isNotEmpty) {
      accessToken = await RemoteServices.getFreshToken(accessToken!);
    }
  }

  Stream<UserModel?> getMeStream() async* {
    try {
      while (true) {
        if (accessToken != null && accessToken!.isNotEmpty) {
          yield await getMe();
        }
        await Future.delayed(const Duration(seconds: 30)); // Adjust as needed
      }
    } catch (e) {
      e.printError(info: 'APP_getMeStream:');
      yield* Stream<UserModel?>.error(e);
    }
  }

  Future<UserModel?> getMe() async {
    try {
      return await RemoteServices.meApi(token: accessToken!);
    } catch (e) {
      e.printError();
    }
    return null;
  }
}
