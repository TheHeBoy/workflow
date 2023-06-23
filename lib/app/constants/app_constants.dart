//Network global data
import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class AppConstants {
  AppConstants._();
  static late Directory directory;
  //存放文件图标的路径
  static const String _fileIconPath = "\\fileIcon\\";

  static void init() async{
    directory = await getApplicationDocumentsDirectory();
    Directory iconDir = Directory(getFileIconPath());
    if (!await iconDir.exists()) {
      // 如果文件夹不存在，则创建文件夹及其所有上级目录
      await iconDir.create(recursive: true);
    }
    Get.log("项目路径为：${getFileIconPath()}");
  }

  static String getFileIconPath(){
    return directory.path + _fileIconPath;
  }
}
