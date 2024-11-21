import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

Future<String> pickImage(Permission permission, String content, context, {ImageSource? source} ) async {
  final picker = ImagePicker();

  String path = '';

  try {
    final getImage = await picker.pickImage(source: source!);

    if (getImage != null) {
      path = getImage.path;
    } else {
      path = '';
    }
  } catch (e) {
    var status = await permission.status;
    if (status.isDenied){
      showAlertDialog(context, content);


    }


  }

  return path;
}


showAlertDialog(context, content) => showCupertinoDialog<void>(
  context: context,
  barrierDismissible: false,
  builder: (BuildContext context) => CupertinoAlertDialog(
    title: const Text('Permission Denied'),
    content: Text(content),
    actions: <CupertinoDialogAction>[
      CupertinoDialogAction(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('Cancel', style: TextStyle(color: Colors.red),),
      ),
      CupertinoDialogAction(
        isDefaultAction: true,
        onPressed: () => openAppSettings(),
        child: const Text('Settings',  style: TextStyle(color: Colors.blue)),
      ),
    ],
  ),
);
