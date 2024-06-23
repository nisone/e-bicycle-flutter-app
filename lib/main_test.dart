import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test',
      theme:
          ThemeData(colorSchemeSeed: const Color.fromRGBO(120, 130, 240, 1.0)),
      home: const MainTest(),
    );
  }
}

class MainTest extends StatelessWidget {
  const MainTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              Dio dio =
                  Dio(BaseOptions(baseUrl: 'http://192.168.0.131:8000/api'));

              XFile? xfile =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              Uint8List fileBytes = Uint8List.fromList(List<int>.empty());
              if (xfile != null) {
                fileBytes = await xfile.readAsBytes();
              }

              FormData formData = FormData.fromMap({
                'profile':
                    MultipartFile.fromBytes(fileBytes, filename: xfile!.name)
              });

              Response res = await dio.post('/testFileUpload',
                  data: formData,
                  options: Options(contentType: 'multipart/form-data'));
              print('POST TEST RESPONSE: $res');
            } on DioException catch (e) {
              print('DIO POST TEST ERROR: ${e.message}');
              if (e.response != null) {
                print('DIO POST TEST ERROR: ${e.response}');
              }
            } on Exception catch (e) {
              print('POST TEST ERROR: $e');
            }
          },
          child: const Text('Test'),
        ),
      ),
    );
  }
}
