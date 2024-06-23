import 'package:get/get.dart';

import '../modules/add_money/bindings/add_money_binding.dart';
import '../modules/add_money/views/add_money_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_landing_view.dart';
import '../modules/bike/bindings/bike_binding.dart';
import '../modules/bike/views/bike_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/scan_qr/bindings/scan_qr_binding.dart';
import '../modules/scan_qr/views/scan_qr_view.dart';
import '../modules/station/bindings/station_binding.dart';
import '../modules/station/views/station_view.dart';
import '../modules/trip_details/bindings/trip_details_binding.dart';
import '../modules/trip_details/views/trip_details_view.dart';
import '../modules/wallet/bindings/wallet_binding.dart';
import '../modules/wallet/views/wallet_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.AUTH_LANDING;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_LANDING,
      page: () => const AuthLandingView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.TRIP_DETAILS,
      page: () => const TripDetailsView(),
      binding: TripDetailsBinding(),
    ),
    GetPage(
      name: _Paths.WALLET,
      page: () => const WalletView(),
      binding: WalletBinding(),
    ),
    GetPage(
      name: _Paths.ADD_MONEY,
      page: () => const AddMoneyView(),
      binding: AddMoneyBinding(),
    ),
    GetPage(
      name: _Paths.SCAN_QR,
      page: () => const ScanQrView(),
      binding: ScanQrBinding(),
    ),
    GetPage(
      name: _Paths.STATION,
      page: () => const StationView(),
      binding: StationBinding(),
    ),
    GetPage(
      name: _Paths.BIKE,
      page: () => const BikeView(),
      binding: BikeBinding(),
    ),
  ];
}
