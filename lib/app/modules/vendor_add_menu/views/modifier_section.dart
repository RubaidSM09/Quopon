import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ModifierOption {
  final TextEditingController nameController;
  final TextEditingController priceController;

  ModifierOption({String? name, String? price})
      : nameController = TextEditingController(text: name ?? ''),
        priceController = TextEditingController(text: price ?? '');
}

class ModifierGroup {
  final TextEditingController nameController;
  final RxBool isRequired;
  final RxList<ModifierOption> options;

  ModifierGroup({
    String? name,
    bool required = false,
    List<ModifierOption>? opts,
  })  : nameController = TextEditingController(text: name ?? ''),
        isRequired = required.obs,
        options = (opts ?? [ModifierOption()]).obs;
}

class ModifierSection extends StatelessWidget {
  final RxList<ModifierGroup> modifiers;

  const ModifierSection({super.key, required this.modifiers});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Modifier*',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            color: const Color(0xFF020711),
          ),
        ),
        SizedBox(height: 10.h),

        // List of modifier groups
        for (int i = 0; i < modifiers.length; i++)
          _buildModifierGroup(context, modifiers[i], i),

        SizedBox(height: 10.h),

        // Add Modifier Button
        GestureDetector(
          onTap: () {
            modifiers.add(ModifierGroup());
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, size: 20.sp),
                SizedBox(width: 6.w),
                Text(
                  'Add Modifiers',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  Widget _buildModifierGroup(
      BuildContext context, ModifierGroup group, int groupIndex) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8FA),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          // Modifier name + required checkbox
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: group.nameController,
                  decoration: InputDecoration(
                    hintText: 'Modifier Name',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Row(
                children: [
                  Obx(() => Checkbox(
                    value: group.isRequired.value,
                    onChanged: (v) => group.isRequired.value = v ?? false,
                  )),
                  Text('Required', style: TextStyle(fontSize: 13.sp)),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),

          // Option fields
          Obx(() => Column(
            children: [
              for (int j = 0; j < group.options.length; j++)
                _buildOptionField(group, group.options[j], j),
              SizedBox(height: 10.h),

              // Add Option button
              GestureDetector(
                onTap: () {
                  group.options.add(ModifierOption());
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, size: 20.sp),
                      SizedBox(width: 6.w),
                      Text(
                        'Add Options',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildOptionField(
      ModifierGroup group, ModifierOption option, int optionIndex) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          // Option name field
          Expanded(
            flex: 3,
            child: TextField(
              controller: option.nameController,
              decoration: InputDecoration(
                hintText: 'Option Name',
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
          ),

          SizedBox(width: 8.w),

          // Price field with $
          Expanded(
            flex: 2,
            child: TextField(
              controller: option.priceController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                prefixText: '\$ ',
                hintText: '0.00',
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
