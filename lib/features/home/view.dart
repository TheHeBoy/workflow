// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:io';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:workflow/app/data/local_data_source/sqlite_database.dart';
import 'package:workflow/core/win32/win32.dart';
import 'logic.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        DropTarget(
          onDragDone: (detail) {
            controller.dragFile(detail);
          },
          onDragUpdated: (details) {},
          onDragEntered: (detail) {
            controller.dragging.value = true;
          },
          onDragExited: (detail) {
            controller.dragging.value = false;
          },
          child: Obx(() {
            return Container(
              color: controller.dragging.value
                  ? Colors.blue.withOpacity(0.4)
                  : Colors.transparent,
              child: Column(
                children: [
                  Expanded(
                      flex: 8,
                      child: Obx(() {
                        return Padding(padding: const EdgeInsets.all(12),child: _icons());
                      })),
                  Expanded(flex: 1, child: _footer())
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  DraggableGridItem _addIcon() {
    return DraggableGridItem(
        child: GestureDetector(
          onTap: () => {
            showDialog(
              context: Get.context!,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("添加网址"),
                  content: _addWebsiteDialog(),
                  actions: [
                    TextButton(
                      child: const Text("取消"),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    TextButton(
                      child: const Text("添加"),
                      onPressed: () {
                        controller.addWebsite(controller.websiteCtr.text);
                      },
                    ),
                  ],
                );
              },
            )
          },
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 45, color: Colors.white),
              Text(
                "",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    decoration: TextDecoration.none),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        ),
        isDraggable: false);
  }

  _addWebsiteDialog() {
    return Column(
      children: [
        TextFormField(
          autofocus: true,
          controller: controller.webNameCtr,
          decoration: const InputDecoration(
            labelText: "网址名",
          ),
        ),
        TextFormField(
          autofocus: true,
          controller: controller.websiteCtr,
          decoration: const InputDecoration(
            labelText: "网址",
          ),
        )
      ],
    );
  }

  _icons() {
    final items = [];
    if (controller.fileList.value.isEmpty) {
      items.add(_addIcon());
    }
    return DraggableGridViewBuilder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.8,
      ),
      children: controller.fileList.value.map((e) => _item(e)).toList()
        ..add(_addIcon()),
      isOnlyLongPress: false,
      dragPlaceHolder: (List<DraggableGridItem> list, int index) {
        return PlaceHolderWidget(
          child: Container(
            color: Colors.transparent,
          ),
        );
      },
      dragCompletion:
          (List<DraggableGridItem> list, int beforeIndex, int afterIndex) {},
    );
  }

  _footer() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Navigator.of(Get.context!).push(MaterialPageRoute(builder: (context) => DriftDbViewer(Get.find<AppDataBase>())));
          List<String> files =
              controller.fileList.value.map((e) => e.path).toList();
          AppWin32.openFiles(files);
        },
        child: const Text('run'),
      ),
    );
  }

  DraggableGridItem _item(AppShortcut appShortcut) {
    // return DraggableGridItem(child:
    // Container(width: 100,height: 100,color: Colors.red,),
    //     isDraggable:true);
    return DraggableGridItem(
      child: GestureDetector(
        onSecondaryTapDown: (TapDownDetails details) {
          showMenu(
            context: Get.context!,
            position: RelativeRect.fromLTRB(
              details.globalPosition.dx,
              details.globalPosition.dy,
              details.globalPosition.dx,
              details.globalPosition.dy,
            ),
            items: [
              const PopupMenuItem(
                height: 20,
                value: 1,
                child: Text('删除'),
              ),
            ],
          ).then((value) {
            if (value == 1) {
              controller.deleteIcon(appShortcut);
            }
          });
        },
        child: CustomIcon(
          path: appShortcut.iconPath,
          filename: appShortcut.shortcutName,
        ),
      ),
      isDraggable: true,
    );
  }
}

class CustomIcon extends StatefulWidget {
  final String path;
  final String filename;

  const CustomIcon({
    Key? key,
    required this.path, // providing a default value
    required this.filename, // providing a default value
  }) : super(key: key);

  @override
  _CustomIconState createState() => _CustomIconState();
}

class _CustomIconState extends State<CustomIcon> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => _isHovering = true),
      onExit: (event) => setState(() => _isHovering = false),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            transform: Matrix4.translationValues(0, _isHovering ? -5 : 0, 0),
            child: SizedBox(
              width: 45,
              height: 45,
              child: widget.path.startsWith('assets/')
                  ? Image.asset(
                      widget.path,
                      fit: BoxFit.contain,
                    )
                  : Image.file(
                      File(widget.path),
                      fit: BoxFit.contain,
                    ),
            ),
          ),
          const SizedBox(height: 5,),
          Text(
            textAlign: TextAlign.center,
            basenameWithoutExtension(widget.filename),
            style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                decoration: TextDecoration.none),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          )
        ],
      ),
    );
  }
}
