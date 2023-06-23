import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:workflow/app/constants/app_constants.dart';
import 'package:workflow/app/data/local_data_source/sqlite_database.dart';
import 'package:workflow/core/api/apphttp.dart';
import 'package:drift/drift.dart' as drift;
import 'package:workflow/core/resourses/assets.dart';

class HomeController extends GetxController {
  final dragging = false.obs;
  final fileList = <AppShortcut>[].obs;
  final uuid = const Uuid();
  final websiteCtr = TextEditingController();
  final webNameCtr = TextEditingController();
  final db = Get.find<AppDataBase>();

  @override
  void onInit() {
    // TODO: implement onInit
    fileList.bindStream(db.watchAllAppShortcuts());
    // websiteCtr.text =
    //     "https://www.google.com.hk/webhp?hl=zh-CN&sourceid=cnhp&gws_rd=ssl";
    super.onInit();
  }

  void addWebsite(String url) async {
    var info = await AppHttp.downloadAndSaveIcon(url) ??
        {
          "iconPath": Assets.website,
          "name": webNameCtr.text.isEmpty ? "网站" : webNameCtr.text
        };
    AppShortcutsCompanion appShortcutsCompanion = AppShortcutsCompanion(
        path: drift.Value(url),
        iconPath: drift.Value(info["iconPath"]),
        shortcutName: drift.Value(info["name"]));
    fileList.value.add(await db.insertAppShortcut(appShortcutsCompanion));
    fileList.refresh();
    Get.back();
  }

  void dragFile(DropDoneDetails detail) {
    detail.files.forEach((e) async {
      String iconPath = AppConstants.getFileIconPath() + uuid.v4() + ".png";
      getPngByPath(e.path, iconPath);
      AppShortcutsCompanion appShortcutsCompanion = AppShortcutsCompanion(
          shortcutName: drift.Value(e.name),
          path: drift.Value(e.path),
          iconPath: drift.Value(iconPath));
      fileList.value.add(await db.insertAppShortcut(appShortcutsCompanion));
    });

    fileList.refresh();
  }

  void deleteIcon(AppShortcut appShortcuts) {
    fileList.value.remove(appShortcuts);
    db.deleteAppShortcut(
        AppShortcutsCompanion(id: drift.Value(appShortcuts.id)));
    fileList.refresh();
  }

  void savaOrder(){
    for(int i=0;i<fileList.value.length;i++){
      AppShortcut appShortcut = fileList.value[i];
      appShortcut.copyWith(order: drift.Value(i));
      db.updateAppShortcut(appShortcut);
    }
  }
}
