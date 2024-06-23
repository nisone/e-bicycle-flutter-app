
import 'package:bike_rental/app/controllers/app_controller.dart';
import 'package:bike_rental/app/models/user_model.dart';
import 'package:bike_rental/app/services/remote_services.dart';
import 'package:dio/dio.dart' as dio;
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  AppController app = Get.find<AppController>();

  @override
  onReady() {
    if (app.accessToken != null) {
      // try to refresh token if success get me & goto home
    }
    super.onReady();
  }

  login({required String identifier, required String password}) async {
    var response = await RemoteServices()
        .loginApi(identifier: identifier, password: password);

    app.me.value = UserModel.fromMap(response['user']);
    app.accessToken = response['access_token'];

    app.sharedPrefs.setString('token', response['access_token']);
  }

  register(
      {required String admissionNo,
      required String name,
      required String email,
      required String phone,
      required String nin,
      required String password,
      required String password2,
      required XFile photo,
      required XFile document,
      required String docType}) async {
    // final storageRef = FirebaseStorage.instance.ref();

    // final profileImageRef = await storageRef
    //     .child('profileImages/${DateTime.now().millisecondsSinceEpoch}.png');

    // final documentImageRef = storageRef
    //     .child('documentImages/${DateTime.now().millisecondsSinceEpoch}.png');

    // await profileImageRef.putData(
    //     photo,
    //     SettableMetadata(
    //       contentType: 'image/*',
    //     ));

    // await documentImageRef.putData(
    //     document,
    //     SettableMetadata(
    //       contentType: 'image/*',
    //     ));

    dio.MultipartFile profile = dio.MultipartFile.fromBytes(
        await photo.readAsBytes(),
        filename: photo.name);
    dio.MultipartFile doc = dio.MultipartFile.fromBytes(
        await photo.readAsBytes(),
        filename: document.name);

    var response = await RemoteServices().registerApi(
      admissionNumber: admissionNo,
      name: name,
      email: email,
      phoneNumber: phone,
      nin: nin,
      password: password,
      passwordConfirmation: password2,
      profilePhoto: profile,
      documentImage: doc,
      documentType: docType,
    );

    app.me.value = UserModel.fromMap(response['user']);
    app.accessToken = response['access_token'];

    app.sharedPrefs.setString('token', response['access_token']);
  }
}
