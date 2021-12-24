import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whats_app_clone/future/camera/presentation/pages/gallery/gallery_view.dart';

class PreviewView extends StatelessWidget {
  final File imageFile;
  final List<File> fileList;

  const PreviewView({
    required this.imageFile,
    required this.fileList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => GalleryView(fileList,),
                  ),
                );
              },
              child: Text('Go to all captures'),
              style: TextButton.styleFrom(
                primary: Colors.black,
                backgroundColor: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Image.file(imageFile),
          ),
        ],
      ),
    );
  }
}
