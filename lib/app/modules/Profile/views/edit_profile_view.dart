// lib/app/modules/Profile/views/edit_profile_view.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quopon/app/modules/Profile/views/profile_view.dart';
import 'package:quopon/common/EditProfileField.dart';
import 'package:quopon/common/customTextButton.dart';

import '../controllers/edit_profile_controller.dart';
import '../controllers/country_city_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EditProfileController());
    // Use the controller provided by GetView
    final c = controller;
    // CountryCityController is created in EditProfileController.onInit()
    final cc = Get.find<CountryCityController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFC),
      body: SafeArea(
        child: Obx(() {
          if (c.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return Form(
            key: c.formKey,
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Header
                  Column(
                    children: [
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: Get.back,
                            child: const Icon(Icons.arrow_back),
                          ),
                          Text(
                            "Edit Profile",
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
                          ),
                          const SizedBox(width: 24), // spacer
                        ],
                      ),
                    ],
                  ),

                  // Avatar
                  Column(
                    children: [
                      // in EditProfileView build()
                      GestureDetector(
                        onTap: controller.pickProfileImage,
                        child: Obx(() {
                          final picked = controller.profileImage.value;
                          final existingUrl = controller.profilePictureUrl.value;

                          Widget img;
                          if (picked != null) {
                            // freshly picked local file
                            img = Image.file(File(picked.path), fit: BoxFit.cover);
                          } else if (existingUrl.isNotEmpty) {
                            // show existing backend image
                            img = Image.network(existingUrl, fit: BoxFit.cover);
                          } else {
                            // placeholder
                            img = Image.asset(
                              'assets/images/CompleteProfile/Cloud.png',
                              color: const Color(0xFF6F7E8D),
                              height: 30.h,
                              width: 30.w,
                            );
                          }

                          return Container(
                            width: 80.w,
                            height: 80.h,
                            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                            clipBehavior: Clip.antiAlias,
                            child: img,
                          );
                        }),
                      ),
                      SizedBox(height: 10.h),
                      Text("Upload Profile Picture",
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp)
                      ),
                    ],
                  ),

                  // Fields
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          EditProfileField(
                            label: 'Full Name',
                            defaultText: c.fullNameCtrl.text,
                            hintText: 'Enter Full Name',
                            editProfileController: c.fullNameCtrl,
                            validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                          ),
                          EditProfileField(
                            label: 'Email Address',
                            defaultText: c.emailCtrl.text,
                            hintText: 'Enter Email',
                            editProfileController: c.emailCtrl,
                            validator: (v) {
                              final s = (v ?? '').trim();
                              if (s.isEmpty) return 'Required';
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(s)) return 'Invalid email';
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                          EditProfileField(
                            label: 'Phone Number',
                            defaultText: c.phoneCtrl.text,
                            hintText: 'Enter Phone Number',
                            editProfileController: c.phoneCtrl,
                            keyboardType: TextInputType.phone,
                          ),

                          // Country
                          _CountryDropdown(cc: cc),

                          // City (depends on country)
                          _CityDropdown(cc: cc),

                          EditProfileField(
                            label: 'Address',
                            defaultText: c.addressCtrl.text,
                            hintText: 'Enter Address',
                            editProfileController: c.addressCtrl,
                            keyboardType: TextInputType.streetAddress,
                            maxLines: 2,
                          ),
                          SizedBox(height: 12.h),
                        ],
                      ),
                    ),
                  ),

                  // Save button
                  GradientButton(
                    text: 'Save Changes',
                    onPressed: () async {
                      await c.save();
                      if (c.error.value == null) {
                        Get.to(() => const ProfileView());
                      }
                    },
                    colors: const [Color(0xFFD62828), Color(0xFFC21414)],
                    boxShadow: const [BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
                    child: Obx(() {
                      return c.isSaving.value
                          ? SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                          : Text(
                        'Save Changes',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: 8.h),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _CountryDropdown extends StatelessWidget {
  const _CountryDropdown({required this.cc});
  final CountryCityController cc;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final countries = cc.countryCities.keys.toList()..sort();
      if (!countries.contains(cc.selectedCountry.value) && cc.selectedCountry.value.isNotEmpty) {
        countries.insert(0, cc.selectedCountry.value);
      }
      return _DropdownShell<String>(
        label: 'Country',
        value: cc.selectedCountry.value.isEmpty ? null : cc.selectedCountry.value,
        items: countries,
        onChanged: (v) {
          if (v != null) cc.setCountry(v);
        },
      );
    });
  }
}

class _CityDropdown extends StatelessWidget {
  const _CityDropdown({required this.cc});
  final CountryCityController cc;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final items = cc.cities.toList();
      if (!items.contains(cc.selectedCity.value) && cc.selectedCity.value.isNotEmpty) {
        items.insert(0, cc.selectedCity.value);
      }
      return _DropdownShell<String>(
        label: 'City',
        value: cc.selectedCity.value.isEmpty ? null : cc.selectedCity.value,
        items: items,
        onChanged: (v) {
          if (v != null) cc.setCity(v);
        },
      );
    });
  }
}

class _DropdownShell<T> extends StatelessWidget {
  const _DropdownShell({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final T? value;
  final List<T> items;
  final void Function(T?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp)),
          const SizedBox(),
        ]),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.shade200),
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: DropdownButtonFormField<T>(
            value: value,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
            decoration: const InputDecoration(border: InputBorder.none),
            style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
            items: items
                .map((e) => DropdownMenuItem<T>(
              value: e,
              child: Text(e.toString()),
            ))
                .toList(),
            onChanged: onChanged,
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
