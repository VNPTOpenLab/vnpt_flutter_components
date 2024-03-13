import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vnpt_flutter_components/components/attachment_box_widget.dart';
import 'package:vnpt_flutter_components/services/minio_service.dart';

class PAKNAttachmentDemo extends StatefulWidget {
  const PAKNAttachmentDemo({super.key});

  @override
  State<PAKNAttachmentDemo> createState() => _PAKNAttachmentDemoState();
}

class _PAKNAttachmentDemoState extends State<PAKNAttachmentDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PAKN Attachment Demo"),),
      body: SafeArea(child: _buildBody()),
    );
  }

  AttachmentBoxController controller = AttachmentBoxController();
  Widget _buildBody() {
    return Column(
      children: [
        Text("Noi dung phan anh: xxxxxxx"),
        Expanded(child: SingleChildScrollView(child: AttachmentBoxWidget(controller: controller))),
        ElevatedButton(onPressed: () {
          showDialog(
            barrierDismissible: false,
              context: context, builder: (_) {
            return AlertDialog(title: Text("Please wait"), content: Column(
              mainAxisSize: MainAxisSize.min,
                children: [
              Text("Uploading ${controller.files.length} files..."),
              CircularProgressIndicator()
            ]));
          });

          doUpload();
        }, child: Text("Save"))
      ],
    );
  }
  doUpload() {
    minIOService.uploadMultipleFiles(controller.files)
    .then((resp) {
      if (resp.errorMessage != null) {
        Navigator.pop(context);
        showMessageBox("Lỗi hệ thống", resp.errorMessage!);
      }
      else {
        Navigator.pop(context);
        showMessageBox("Thành công", resp.uploadedFiles.join("\n"));
      }
    });
  }

  void showMessageBox(String title, String message) {
    showDialog(context: context, builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        ElevatedButton(onPressed: () => Navigator.pop(context), child: Text("OK"))
      ],
    ));
  }
}

