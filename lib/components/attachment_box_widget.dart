import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:vnpt_flutter_components/shared/file_utils.dart';

class AttachmentBoxController {
  List<String> files = [];

  appendSelectedFiles(List<PlatformFile> selectedFiles) {
    List<String> newFiles = [];
    for(var f in selectedFiles) {
      String? old = files.firstWhereOrNull((e) => e == f.path!);
      if (old == null) {
        newFiles.add(f.path!);
      }
    }
    files.addAll(newFiles);
  }
}

class AttachmentBoxWidget extends StatefulWidget {
  const AttachmentBoxWidget({super.key, required this.controller});
  final AttachmentBoxController controller;

  @override
  State<AttachmentBoxWidget> createState() => _AttachmentBoxWidgetState();
}

class _AttachmentBoxWidgetState extends State<AttachmentBoxWidget> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> ls = [];
    for(var f in widget.controller.files) {
      ls.add(buildFileCard(f));
    }
    ls.add(ElevatedButton(
        onPressed: () {
          if (kIsWeb) {
            showFilePickerForWebAsync();
          } else {
            showFilePickerForMobileAsync();
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.add), Text("Thêm tập tin")],
        )));
    return Card(
        child: Container(
      width: double.maxFinite,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
            children: ls)));
  }

  Future showFilePickerForWebAsync() async {
    var picked = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (picked != null) {
      setState(() {
        widget.controller.appendSelectedFiles(picked.files);
      });
    }
  }

  String get filePathDelimiter {
    if (Platform.isWindows) {
      return "\\";
    }
    return "/";
  }

  Widget buildFileCard(String filePath) {

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(onPressed: () {
          setState(() {
            widget.controller.files.remove(filePath);
          });
        }, icon: Icon(Icons.highlight_remove, color: Colors.red)),
        Expanded(child: Text("${FileUtils.getFileNameFromPath(filePath, delimiter: filePathDelimiter)}")),
      ],
    );
  }

  Future showFilePickerForMobileAsync() async {
    var picked = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (picked != null) {
      setState(() {
        widget.controller.appendSelectedFiles(picked.files);
      });
    }
  }
}
