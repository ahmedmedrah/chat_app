import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImaeg) uploadImage;


  UserImagePicker(this.uploadImage);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImageFile;

  void _pickImage() async {
    final picker = ImagePicker();
    bool fromCamera = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Select a source'),
          content: Text('Pick an image from?'),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.image_rounded),
              label: Text('Gallery'),
              onPressed: () {
                Navigator.of(dialogContext).pop(false); // Dismiss alert dialog
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.camera),
              label: Text('Camera'),
              onPressed: () {
                Navigator.of(dialogContext).pop(true); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
    final pickedImage = await picker.getImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,imageQuality: 50,maxWidth: 250);
    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });
    widget.uploadImage(_pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(20),
          child: CircleAvatar(
            backgroundColor:Colors.grey[200],
            backgroundImage:
                _pickedImageFile != null ? FileImage(_pickedImageFile) : null,
            child: _pickedImageFile == null
                ? Icon(
                    Icons.image,
                    size: 35,
              color: Theme.of(context).primaryColor,
                  )
                : null,
            radius: 40,
          ),
          onTap: _pickImage,
        ),
        SizedBox(height: 10),
        Text('Tap to select picture'),
      ],
    );
  }
}
