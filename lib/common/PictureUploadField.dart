import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart'; // ✅ add this

class PictureUploadField extends GetView {
  final double width;
  final double height;
  final bool isUploaded;
  final String image;              // fallback asset path
  final File? file;                // newly picked file
  final ValueChanged<File?>? onImageSelected; // callback

  const PictureUploadField({
    this.width = 398,
    this.height = 220,
    this.isUploaded = false,
    this.image = 'assets/images/DealPerformance/Shakes.jpg',
    this.file,
    this.onImageSelected,
    super.key,
  });

  Future<void> _pickFromGallery(BuildContext context) async {
    try {
      final picker = ImagePicker();
      final XFile? picked = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,     // compress a bit
        maxWidth: 2048,       // keep reasonable size
      );
      if (picked != null) {
        onImageSelected?.call(File(picked.path));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickFromGallery(context), // ✅ open gallery
      child: Container(
        width: width.w,
        height: height.h,
        padding: !(isUploaded || file != null)
            ? EdgeInsets.only(top: 20.h, bottom: 20.h, left: 70.w, right: 70.w)
            : EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: const Color(0xFFF4F6F7),
          border: Border.all(color: const Color(0xFFEAECED)),
        ),
        child: !(isUploaded || file != null)
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/SupportFAQ/UploadImage.png'),
            Text(
              'Click to upload images here',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF6F7E8D),
              ),
            ),
          ],
        )
            : ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: file != null
              ? Image.file(file!, fit: BoxFit.cover)
              : Image.asset(image, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
