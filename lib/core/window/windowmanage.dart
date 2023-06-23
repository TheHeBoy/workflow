import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';
import 'package:workflow/features/home/logic.dart';

class AppWindow{
  AppWindow._();

  static void init() async{
    // Must add this line.
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(350, 350),
      backgroundColor: Colors.transparent,
      skipTaskbar: true,
      titleBarStyle: TitleBarStyle.hidden,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      // await windowManager.maximize();
      await windowManager.setAlignment(Alignment.topRight);
      await windowManager.setAlwaysOnBottom(true);
      await windowManager.show();
      await windowManager.focus();
    });

    windowManager.addListener(_Listener());
  }

  static void closeWindow(){
    windowManager.close();
  }

  static void hideWindow(){
    windowManager.hide();
  }

  static void showWindow(){
    windowManager.show();
  }
}

class _Listener with WindowListener {

  HomeController homeCtr = Get.find<HomeController>();

  @override
  void onWindowEvent(String eventName) {
  }

  @override
  void onWindowClose() {
    homeCtr.savaOrder();
  }

  @override
  void onWindowFocus() {
    // do something
  }

  @override
  void onWindowBlur() {
    // do something
  }

  @override
  void onWindowMaximize() {
    // do something
  }

  @override
  void onWindowUnmaximize() {
    // do something
  }

  @override
  void onWindowMinimize() {
    // do something
  }

  @override
  void onWindowRestore() {
    // do something
  }

  @override
  void onWindowResize() {
    // do something
  }

  @override
  void onWindowMove() {
    // do something
  }

  @override
  void onWindowEnterFullScreen() {
    // do something
  }

  @override
  void onWindowLeaveFullScreen() {
    // do something
  }
}