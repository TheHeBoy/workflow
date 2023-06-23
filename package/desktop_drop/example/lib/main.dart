import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:cross_file/cross_file.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const Wrap(
          direction: Axis.horizontal,
          runSpacing: 8,
          spacing: 8,
          children: [
            ExampleDragTarget(1),
            ExampleDragTarget(2),
            ExampleDragTarget(3),
            ExampleDragTarget(4),
            ExampleDragTarget(5),
            ExampleDragTarget(6),
          ],
        ),
      ),
    );
  }
}

class ExampleDragTarget extends StatefulWidget {
  final int i;
  const ExampleDragTarget(this.i, {Key? key}) : super(key: key);

  @override
  _ExampleDragTargetState createState() => _ExampleDragTargetState();
}



class _ExampleDragTargetState extends State<ExampleDragTarget> {
  final List<XFile> _list = [];

  bool _dragging = false;

  Offset? offset;

  late String path;

  @override
  Widget build(BuildContext context) {
    path = "C:\\Users\\hehong\\Desktop\\Icons\\${widget.i}.png";
    var image = Image.file(File(path));
    return DropTarget(
      onDragDone: (detail){
        print(path);
        setState(() {
          getPngByPath(detail.files[0].path, path);
          _list.addAll(detail.files);
        });
      },
      onDragUpdated: (details) {
        setState(() {
          offset = details.localPosition;
        });
      },
      onDragEntered: (detail) {
        setState(() {
          _dragging = true;
          offset = detail.localPosition;
        });
      },
      onDragExited: (detail) {
        setState(() {
          _dragging = false;
          offset = null;
        });
      },
      child: Container(
        height: 200,
        width: 200,
        color: _dragging ? Colors.blue.withOpacity(0.4) : Colors.black26,
        child: Stack(
          children: [
            if (_list.isEmpty)
              const Center(child: Text("Drop here"))
            else
              image,
            if (offset != null)
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  '$offset',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              )
          ],
        ),
      ),
    );
  }
}
