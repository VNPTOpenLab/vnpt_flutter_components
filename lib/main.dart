import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:vnpt_flutter_components/demo/pakn_attachment_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Storybook(stories:
    [
      Story(name: 'IO/PAKN Attachments', builder: (_) => PAKNAttachmentDemo())
    ]
    );
  }
}
