import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'app/constants/app_constants.dart';
import 'app/data/local_data_source/sqlite_database.dart';
import 'app/routes/app_pages.dart';
import 'core/localization/local_keys.dart';
import 'core/localization/messages.dart';
import 'core/theme/theme.dart';
import 'core/tray/traymenu.dart';
import 'core/window/windowmanage.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AppDataBase());

  //开机自启
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  launchAtStartup.setup(
    appName: packageInfo.appName,
    appPath: Platform.resolvedExecutable,
  );
  await launchAtStartup.enable();
  bool isEnabled = await launchAtStartup.isEnabled();
  Get.log("开机自启是否成功：$isEnabled");

  //窗口初始化
  AppWindow.init();
  //状态栏菜单初始化
  TrayMenu.init();
  //常量初始化：项目文件路径等
  AppConstants.init();
  runApp(const MyApp());}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: LocalKeys.appName.tr,
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.dartTheme,
      getPages: AppPages.routes,
      translations: Messages(),
      locale: const Locale('zh', 'CN'),
      fallbackLocale: const Locale("zh", "CN"),
      initialRoute: AppPages.INITIAL,
      builder: EasyLoading.init(),
    );
  }
}
