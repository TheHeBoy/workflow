import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:path_provider/path_provider.dart';
import 'package:workflow/app/constants/app_constants.dart';
import 'package:workflow/app/data/local_data_source/sqlite_database.dart';

class AppHttp{
  static var client = http.Client();
  static Future<Map?> _fetchFavicon(String url) async {
    EasyLoading.show(status: 'loading...');
    var response;
    try {
      response = await client.get(Uri.parse(url)).timeout(const Duration(seconds: 3)); // 设置5秒超时
    }catch(e,s) {
      Get.log(e.toString());
      Get.log(s.toString());
      EasyLoading.dismiss();
      EasyLoading.showInfo("获取图标失败",duration: const Duration(seconds: 1));
      return null;
    }finally {
      EasyLoading.dismiss();
    }
    var document = parse(response.body);

    // 获取网站名称
    var titleElement = document.querySelector('title');
    String name = titleElement?.text ?? '';

    var faviconElement = document.querySelector('link[rel="shortcut icon"]');
    var faviconUrl = faviconElement != null ? faviconElement.attributes['href'] : '/favicon.ico';
    if (!faviconUrl!.startsWith('http')) {
      var uri = Uri.parse(url);
      faviconUrl = '${uri.scheme}://${uri.host}$faviconUrl';
    }
    return {"url":faviconUrl,"name":name};
  }

  static Future<Map?> downloadAndSaveIcon(String url) async {
    final info = await _fetchFavicon(url);
    if(info == null){
      return null;
    }
    var name = info["name"];
    var faviconUrl = info["url"];
    var response = await http.get(Uri.parse(faviconUrl));

    var filePath = AppConstants.getFileIconPath() + "${name}.png";

    File iconFile = File(filePath);
    iconFile.writeAsBytesSync(response.bodyBytes);

    return {"name":name,"iconPath":filePath};
  }
}


