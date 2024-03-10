import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:get/get.dart';

import '../../../core/utils/logger_util.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ImageUploadController extends GetxController {
  RxList<String> images = RxList();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getImages();
  }

  void getImages() async {
    await callGetListImagesAPI();
  }

  final cloudinary = Cloudinary.signedConfig(
    apiKey: "338454188622499",
    apiSecret: "wKe-8X7oN8-hJKW7ue8zPLo-zgg",
    cloudName: "djj6yah7c",
  );

  Future<void> callGetListImagesAPI() async {
    const cloudName = 'djj6yah7c';
    const apiKey = '338454188622499';
    const apiSecret = 'wKe-8X7oN8-hJKW7ue8zPLo-zgg';
    const folder = 'slately';
    try {
      final url = Uri.parse(
          'https://api.cloudinary.com/v1_1/$cloudName/resources/image');
      logger.i("URL : $url");
      final response = await http.get(
        url.replace(queryParameters: {
          'type': 'upload',
          'prefix': '$folder/',
        }),
        headers: {
          'Authorization':
              'Basic ${base64Encode(utf8.encode("$apiKey:$apiSecret"))}',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> resources = json.decode(response.body)['resources'];
        images.clear();
        for (var resource in resources) {
          logger.i(resource['url']);
          images.add(resource['url']);
        }
      } else {
        logger.e('Failed to load resources: ${response.statusCode}');
        logger.e('Failed to load resources: ${response.body}');
      }
    } catch (e) {
      logger.e(e);
    }
  }

  Future<String> uploadImage(File file) async {
    try {
      String fileName = file.path.split('/').last;
      String fileNameWithoutExtension =
          fileName.substring(0, fileName.lastIndexOf('.'));
      final response = await cloudinary.upload(
          file: file.path,
          fileBytes: file.readAsBytesSync(),
          resourceType: CloudinaryResourceType.image,
          folder: 'slately',
          fileName: fileNameWithoutExtension,
          progressCallback: (count, total) {
            logger.i('Uploading image from file with progress: $count/$total');
          });

      if (response.isSuccessful) {
        logger.i('Get your image from with ${response.secureUrl}');
        return response.secureUrl.toString();
      }
      return '';
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> deleteImage(
      {required String publicId, required String url}) async {
    try {
      final response = await cloudinary.destroy(
        publicId,
        url: url,
        resourceType: CloudinaryResourceType.image,
        invalidate: false,
      );
      if (response.isSuccessful ?? false) {
        logger.i("Image Deleted");
      }
      logger.e(response.error);
    } catch (e) {
      logger.e(e);
    }
  }
}
