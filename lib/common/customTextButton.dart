import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:quopon/app/modules/VendorProfile/controllers/vendor_profile_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil

// Custom Gradient Button Widget
class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final List<Color> colors;
  final double width;
  final double height;
  final double borderRadius;
  final TextStyle? textStyle;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final EdgeInsetsGeometry padding;
  final Widget? child;
  final bool isEnabled;
  final double elevation;
  final List<BoxShadow>? boxShadow;
  final double borderWidth;
  final List<Color> borderColor;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.colors,
    this.width = double.infinity,
    this.height = 50,
    this.borderRadius = 8,
    this.textStyle,
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.child,
    this.isEnabled = true,
    this.elevation = 4,
    this.boxShadow,
    this.borderWidth = 1,
    this.borderColor = const [Color(0xFFF44646), Color(0xFFC21414)],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w, // Apply ScreenUtil to width
      height: height.h, // Apply ScreenUtil to height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius.sp), // Apply ScreenUtil to borderRadius
        boxShadow: boxShadow ?? [
          BoxShadow(
            color: colors.first.withOpacity(0.3),
            offset: Offset(0, elevation),
            blurRadius: elevation * 2,
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(borderRadius.sp),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isEnabled
                  ? colors
                  : [Colors.grey.shade300, Colors.grey.shade400],
              begin: begin,
              end: end,
            ),
            borderRadius: BorderRadius.circular(borderRadius.sp),
          ),
          child: InkWell(
            onTap: isEnabled ? onPressed : null,
            borderRadius: BorderRadius.circular(borderRadius.sp),
            child: Stack(
              children: [
                // Apply gradient border effect using ShaderMask
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(borderRadius.sp),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: borderWidth.sp, // Apply ScreenUtil to borderWidth
                            color: Colors.transparent, // Transparent to show gradient
                          ),
                        ),
                        child: ShaderMask(
                          shaderCallback: (bounds) {
                            return LinearGradient(
                              colors: borderColor,
                              begin: begin,
                              end: end,
                            ).createShader(bounds);
                          },
                          child: Container(),
                        ),
                      ),
                    ),
                  ),
                ),
                // Center content
                Container(
                  padding: padding,
                  child: Center(
                    child: child ?? Text(
                      text,
                      style: textStyle ?? TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp, // Apply ScreenUtil to font size
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const CustomTextButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.h, // Apply ScreenUtil to height
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFDC143C),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.sp), // Apply ScreenUtil to borderRadius
          ),
          elevation: 0,
        ),
        child: Text(
          widget.buttonText,
          style: TextStyle(
            fontSize: 18.sp, // Apply ScreenUtil to font size
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
