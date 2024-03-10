import 'dart:ffi';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:slately/core/basic_features.dart';
import 'package:slately/core/constants/dimensions.dart';
import 'package:slately/core/utils/logger_util.dart';
import 'package:slately/core/widgets/custom_image.dart';
import 'package:slately/features/admin/controllers/image_upload_controller.dart';

class ImageUploadScreen extends StatelessWidget {
  ImageUploadScreen({super.key});

  final ImageUploadController imageUploadController =
      Get.put(ImageUploadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.commonPaddingForScreen),
          child: Obx(
            () => GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: imageUploadController.images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: Dimensions.w10,
                  mainAxisSpacing: Dimensions.w10,
                  childAspectRatio: 0.7,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) => Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(Dimensions.r10),
                          child: CustomNetworkImage(
                            height: double.infinity,
                            image: imageUploadController.images[index],
                          ),
                        ),
                        Positioned(
                            right: Dimensions.h5,
                            top: Dimensions.h5,
                            child: Container(
                              height: Dimensions.w35,
                              width: Dimensions.w35,
                              decoration: BoxDecoration(
                                color: ColorConst.blackColor.withOpacity(0.5),
                                borderRadius:
                                    BorderRadius.circular(Dimensions.r5),
                              ),
                              child: Center(
                                child: IconButton(
                                    onPressed: () {
                                      logger.i(imageUploadController.images[index]);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      size: Dimensions.w20,
                                    )),
                              ),
                            )),
                      ],
                    )),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var permission = await Permission.storage.request();
          if (permission.isGranted) {
            XFile? file =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            if (file != null) {
              imageUploadController.uploadImage(File(file.path));
              imageUploadController.getImages();
            }
          }
        },
        child: Icon(
          Icons.add,
          size: Dimensions.w30,
        ),
      ),
    );
  }
}
