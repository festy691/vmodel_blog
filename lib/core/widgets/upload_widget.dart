import 'dart:io';

import 'package:blog/core/utils/blink_dialog.dart';
import 'package:blog/core/utils/pallet.dart';
import 'package:blog/core/widgets/edit_form_widget.dart';
import 'package:blog/models/image_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;
import 'dart:math' as Math;


typedef OnUpload = Function(String);

class UploadWidget extends StatefulWidget {
  OnUpload onUpload;
  bool isCamera;
  String title;
  TextEditingController controller;
  UploadWidget({Key? key, required this.onUpload, required this.controller, this.isCamera = false, this.title = "Select Photo"}) : super(key: key);

  @override
  State<UploadWidget> createState() => _UploadWidgetState();
}

class _UploadWidgetState extends State<UploadWidget> {

  AppState state = AppState.free;
  File? myFile;
  ImageModel imageModel = ImageModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    state = AppState.free;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: EditFormField(
            label: widget.title,
            hint: "https://file.com/file",
            controller: widget.controller,
            keyboardType: TextInputType.text,
            suffixIcon: Icons.upload,
            iconColor: Pallet.hintColor,
            onPasswordToggle: () async {
              myFile = null;
              myFile = await _pickImage(isCamera: widget.isCamera);
              if(myFile == null) return;
              final file = await compressImage(myFile);
              /*var result = await _provider.uploadImage(context: context, file: file);
                if(!result.error){
                  imageModel = ImageModel.fromJson(result.data);
                  state = AppState.uploaded;
                  widget.onUpload(imageModel.image);
                  widget.controller.text = imageModel.image;
                  if (mounted){
                    setState(() {

                    });
                  }
                }*/
            },
            readOnly: true,
            onChanged: (string) {
              if (mounted) {
                setState(() {});
              }
            },
          ),
        ),

        if (widget.controller.text.isNotEmpty) IconButton(
          onPressed: (){
            state = AppState.free;
            widget.onUpload("");
            widget.controller.text = "";
            if (mounted){
              setState(() {

              });
            }
          },
          icon: Icon(Icons.close, color: Pallet.hintColor, size: 24.w,),
        ),
      ],
    );
  }

  Future<File> compressImage(File? file) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    int rand = Math.Random().nextInt(10000);
    Im.Image? image = Im.decodeImage(file!.readAsBytesSync());
    Im.Image size = Im.copyResize(image!,
        width: 600); // choose the size here, it will maintain aspect ratio
    return File('$path/img_$rand.jpg')
      ..writeAsBytesSync(Im.encodeJpg(size, quality: 85));
  }

  Future<File?> _pickImage({bool isCamera = false}) async {
    try {
      final picker = ImagePicker();
      final pickedFile  = await picker.getImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
      if (pickedFile != null) {
        int sizeInBytes = File(pickedFile.path).lengthSync();
        double sizeInMb = sizeInBytes / (1024 * 1024);
        if (sizeInMb > 9){
          LoadingDialog.showSnackBar(context, "You cannot upload files larger than 10mb", error: true);
          return null;
        }
        setState(() {
          state = AppState.picked;
        });
        return File(pickedFile.path);
      }
      return null;
    } catch (e) {
      state = AppState.picked;
      return null;
    }
  }
}


enum AppState {
  free,
  picked,
  cropped,
  uploaded
}
