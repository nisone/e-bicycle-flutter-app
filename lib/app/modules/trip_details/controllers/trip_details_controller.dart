import 'package:bike_rental/app/controllers/app_controller.dart';
import 'package:bike_rental/app/models/rental_model.dart';
import 'package:bike_rental/app/services/remote_services.dart';
import 'package:get/get.dart';

class TripDetailsController extends GetxController {
  final AppController app = Get.find<AppController>();
  final Rx<RentalModel?> rental = Rx<RentalModel?>(null);

  @override
  void onInit() {
    if (Get.arguments is RentalModel) {
      rental.value = Get.arguments;
    }
    super.onInit();
  }

  createRent(int bikeId) async {
    await RemoteServices.createRental(bikeId, app.accessToken!);
  }

  startRent(int rentId) async {
    try {
      RentalModel? rent =
          await RemoteServices.updateRental(rentId, 'start', app.accessToken!);
      if (rent != null) {}
    } catch (e) {
      e.printError(info: 'Rent start action exception:');
    }
  }

  endRent(int i) {}

  payRent(int i) {}
}
