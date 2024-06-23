import 'package:bike_rental/app/models/rental_model.dart';
import 'package:bike_rental/app/models/user_model.dart';
import 'package:bike_rental/global.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as Getx;

class RemoteServices {
  static Dio dio = Dio(BaseOptions(baseUrl: '${Global.baseUrl}/api'));

  static Future<UserModel?> meApi({required String token}) async {
    final headers = {
      // 'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      Response res =
          await dio.post('/auth/me', options: Options(headers: headers));
      // print(res.data['data']);
      return UserModel.fromMap(res.data['data']);
    } on DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        Getx.Get.snackbar('Exception', e.response!.data['message']);
      }
      debugPrint(e.message);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<dynamic> registerApi({
    required String admissionNumber,
    required String name,
    required String email,
    required String phoneNumber,
    required String nin,
    required String password,
    required String passwordConfirmation,
    required MultipartFile profilePhoto,
    required MultipartFile documentImage,
    required String documentType,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'admission_number': admissionNumber,
        'name': name,
        'email': email,
        'phone_number': phoneNumber,
        'nin': nin,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'profile_photo': profilePhoto,
        'document_image': documentImage,
        'document_type': documentType,
      });

      Response res = await dio.post('/auth/register',
          data: formData,
          options: Options(headers: {
            'Content-Type': 'multipart/form-data',
            'Accept': 'application/json',
            'Authorization':
                'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4wLjEzMTo4MDAwL2FwaS9hdXRoL3JlZ2lzdGVyIiwiaWF0IjoxNzE4MDM3OTk1LCJleHAiOjE3MTgwNDE1OTUsIm5iZiI6MTcxODAzNzk5NSwianRpIjoiQXZ2Nk5neU9yOU5WeExwYyIsInN1YiI6IjExIiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.e6iYh1X25YRwtPLPc8xzNYrfjA-RxzjjKthK999Z3MU'
          }));

      return res.data;
    } on DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        Getx.Get.snackbar(
            'Exception',
            e.response!.data['message'] +
                '\nErrors:\n${(e.response!.data! as Map<String, dynamic>).keys.join('\n')}');
      }
      print(e.response);
      debugPrint(e.message);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<dynamic> loginApi(
      {required String identifier, required String password}) async {
    try {
      Map<String, dynamic> data = {
        "identifier": identifier,
        "password": password
      };

      Response res = await dio.post('/auth/login', data: data);
      return res.data;
    } on DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        Getx.Get.snackbar('Exception',
            e.response!.data['message'] ?? 'Something  went wrong');
      }
      debugPrint(e.message);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<dynamic> logout({required String token}) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      Response res =
          await dio.post('/auth/logout', options: Options(headers: headers));
      return res.data;
    } on DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        Getx.Get.snackbar(
            'Exception',
            e.response!.data['message'] +
                '\nErrors:\n${(e.response!.data! as Map<String, dynamic>).keys.join('\n')}');
      }
      debugPrint(e.message);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<dynamic> getStations() async {
    try {
      Response res = await dio.get('/station');
      return res.data;
    } on DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        Getx.Get.snackbar('Exception',
            e.response!.data['message'] ?? 'Something  went wrong');
      }
      debugPrint(e.message);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<bool> createRental(int bikeId, String token) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      Response res = await dio.post('/rental',
          data: {'bike_id': bikeId}, options: Options(headers: headers));
      print(res.data);
      return true;
    } on DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        Getx.Get.snackbar(
            'Exception',
            e.response!.data['message'] +
                '\nErrors:\n${(e.response!.data! as Map<String, dynamic>).keys.join('\n')}');
      }
      debugPrint(e.message);
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  static Future<RentalModel?> updateRental(
      int rentalId, String action, String token) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      Response res = await dio.patch('/rental/$rentalId',
          data: {'action': action}, options: Options(headers: headers));
      Getx.Get.snackbar('Success', res.data['message']);
      return RentalModel.fromMap(res.data['rental']);
    } on DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        Getx.Get.snackbar('Exception', e.response!.data['message']);
      }
      debugPrint(e.message);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  static Future<String?> getFreshToken(String token) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      Response res =
          await dio.get('/auth/refresh', options: Options(headers: headers));
      print(res.data);
      return res.data['access_token'];
    } on DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        Getx.Get.snackbar(
            'Exception',
            e.response!.data['message'] +
                '\nErrors:\n${(e.response!.data! as Map<String, dynamic>).keys.join('\n')}');
      }
      debugPrint(e.message);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
