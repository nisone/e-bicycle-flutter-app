import 'package:bike_rental/global.dart';
import 'package:get/get.dart';

import '../stations_model.dart';

class StationsProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      // if (map is Map<String, dynamic>) return Station.fromJson(map);
      // if (map is List)
      //   return map.map((item) => Station.fromJson(item)).toList();
    };
    httpClient.baseUrl = Global.baseUrl;
  }

  Future<Station?> getStations(int id) async {
    final response = await get('stations/$id');
    return response.body;
  }

  Future<Response<Station>> postStations(Station stations) async =>
      await post('stations', stations);
  Future<Response> deleteStations(int id) async => await delete('stations/$id');
}
