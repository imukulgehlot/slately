import 'dart:io';
import 'dart:math';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:slately/core/model/response_model/get_images_response_model.dart';
import 'package:slately/core/utils/enum.dart';

import '../../../core/network/api_helper.dart';
import '../../../core/network/api_response_handler.dart';
import '../../../core/network/api_result.dart';
import '../../../core/utils/logger_util.dart';
import 'dart:convert';

final String cloudName = dotenv.env['CLOUD_NAME'] ?? '';
final String apiKey = dotenv.env['API_KEY'] ?? '';
final String apiSecret = dotenv.env['API_SECRET'] ?? '';
final String folder = dotenv.env['FOLDER'] ?? '';

class ImageUploadController extends GetxController {
  Rx<APIResult<GetImagesResponseModel?>?> getImagesResult =
      Rx(APIResult<GetImagesResponseModel>.loading());
  RxList<Resource> images = RxList();

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
    apiKey: apiKey,
    apiSecret: apiSecret,
    cloudName: cloudName,
  );

  Future<void> callGetListImagesAPI() async {
    String url = 'https://api.cloudinary.com/v1_1/$cloudName/resources/image';
    final params = {
      'type': 'upload',
      'prefix': '$folder/',
    };
    final headers = {
      'Authorization':
          'Basic ${base64Encode(utf8.encode("$apiKey:$apiSecret"))}',
    };
    var networkResult = await APIHelper.instance
        .callGetApi(url, params, true, customHeader: headers);

    var apiResultFromNetwork =
        getAPIResultFromNetworkWithoutBase<GetImagesResponseModel>(
            networkResult, (json) => GetImagesResponseModel.fromJson(json));
    if (apiResultFromNetwork.apiResultType == APIResultType.success) {
      images.value = apiResultFromNetwork.result!.resources!;
    }

    getImagesResult.value = apiResultFromNetwork;
  }

  Future<String> uploadImage(File file) async {
    EasyLoading.show();
    try {
      String fileName = file.path.split('/').last;
      String fileNameWithoutExtension =
          fileName.substring(0, fileName.lastIndexOf('.'));
      final response = await cloudinary.upload(
          file: file.path,
          fileBytes: file.readAsBytesSync(),
          resourceType: CloudinaryResourceType.image,
          folder: folder,
          fileName: fileNameWithoutExtension,
          progressCallback: (count, total) {
            logger.i('Uploading image from file with progress: $count/$total');
          });

      if (response.isSuccessful) {
        logger.i('Get your image from with ${response.secureUrl}');
        EasyLoading.dismiss();

        return response.secureUrl.toString();
      }
      EasyLoading.dismiss();

      return '';
    } catch (e) {
      EasyLoading.dismiss();
      return e.toString();
    }
  }

  Future<void> deleteImage({required Resource url}) async {
    EasyLoading.show();

    try {
      final response = await cloudinary.destroy(
        url.publicId,
        url: url.url,
        resourceType: CloudinaryResourceType.image,
        invalidate: false,
      );
      if (response.isSuccessful) {
        logger.i("Image Deleted");
      }
      logger.e(response.error);
    } catch (e) {
      logger.e(e);
    }
    EasyLoading.dismiss();
  }
}
