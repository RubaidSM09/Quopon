import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:quopon/app/modules/VendorProfile/controllers/vendor_profile_controller.dart';

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
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: boxShadow ?? [
          BoxShadow(
            color: colors.first.withOpacity(0.3),
            offset: Offset(0, elevation),
            blurRadius: elevation * 2,
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isEnabled
                  ? colors
                  : [Colors.grey.shade300, Colors.grey.shade400],
              begin: begin,
              end: end,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: InkWell(
            onTap: isEnabled ? onPressed : null,
            borderRadius: BorderRadius.circular(borderRadius),
            child: Container(
              padding: padding,
              child: Center(
                child: child ?? Text(
                  text,
                  style: textStyle ?? TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
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
      height: 56,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFDC143C),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          widget.buttonText,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
