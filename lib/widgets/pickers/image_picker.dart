import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper extends StatefulWidget {
  final void Function(File? image) imageForwader;

  const ImagePickerHelper(this.imageForwader);

  @override
  State<ImagePickerHelper> createState() => _ImagePickerHelperState();
}

class _ImagePickerHelperState extends State<ImagePickerHelper> {
  File? _pickedImage;

  void _pickAnImage() async {
    final ImagePicker picker = ImagePicker();

    final pickedImage = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxHeight: 150,
      maxWidth: 150,
    );
    final pickedImageFile = File(pickedImage.path);

    setState(() {
      _pickedImage = pickedImageFile;
    });

    widget.imageForwader(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 40,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage as File) : null,
        ),
        ElevatedButton.icon(
          onPressed: _pickAnImage,
          icon: const Icon(Icons.image),
          label: const Text('Pick an image'),
        ),
      ],
    );
  }
}
