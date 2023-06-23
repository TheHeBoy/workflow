import 'dart:io';
import 'package:get/get.dart';
import 'package:shell/shell.dart';
import 'package:workflow/features/home/logic.dart';

class AppWin32 {
  static final Shell shell = Shell();

  static Future<void> openFiles(List<String> filePaths) async {
    for (var filePath in filePaths) {
      shell.run('start', arguments: ['',filePath]);
    }
  }
}
