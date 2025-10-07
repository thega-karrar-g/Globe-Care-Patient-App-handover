import 'dart:io';

import 'package:flutter/material.dart';

class UploadingToDataBaseImagePicker extends StatefulWidget {
  const UploadingToDataBaseImagePicker({
    Key? key,
    required this.imageUrl,
    required this.onImageChange,
  }) : super(key: key);

  final String? imageUrl;
  final Future<String> Function(File) onImageChange;

  @override
  _UploadingToDataBaseImagePickerState createState() =>
      _UploadingToDataBaseImagePickerState();
}

class _UploadingToDataBaseImagePickerState
    extends State<UploadingToDataBaseImagePicker> {
  String? url;

  @override
  void didUpdateWidget(covariant UploadingToDataBaseImagePicker oldWidget) {
    if (oldWidget.imageUrl != widget.imageUrl) {
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    url = widget.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Container();

    // if (_isUploading) {
    //   return CircleAvatar(
    //     backgroundColor: Get.theme.cardColor,
    //     radius: 5.5.r,
    //     child: UiHelper.spinKitProgressIndicator(),
    //   );
    // } else {
    //   return ImagePickerWidget(
    //     diameter: ScreenUtil().screenWidth / 3,
    //     isEditable: true,
    //     editIcon: CircleAvatar(
    //       backgroundColor: Get.theme.primaryColor,
    //       child: Icon(
    //         Icons.edit,
    //         size: 18,
    //         color: Get.theme.cardColor,
    //       ),
    //       radius: 13,
    //     ),
    //     shape: ImagePickerWidgetShape.circle,
    //     initialImage:
    //         url ?? const AssetImage(AppImages.profilePlaceholderImage),
    //     onChange: onChange,
    //   );
    // }
  }

  void onChange(File file) async {
    setState(() {
    });
    var result = await widget.onImageChange(file);
      url = result;

    setState(() {
    });
  }
}
