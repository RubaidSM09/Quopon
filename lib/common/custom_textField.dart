import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String headingText;
  final String fieldText;
  final String iconImagePath;
  final TextEditingController controller;
  final bool isPassword;
  final bool isRequired;

  const CustomTextField({
    super.key,
    required this.headingText,
    required this.fieldText,
    required this.iconImagePath,
    required this.controller,
    required this.isRequired,
    this.isPassword = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isPasswordVisible;

  @override
  void initState() {
    super.initState();
    _isPasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.headingText,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            widget.isRequired ? const
            Text(
              '*',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
            ) :
            Text(
              ' (Optional)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300] ?? Colors.grey),
          ),
          child: TextField(
            controller: widget.controller,
            obscureText: widget.isPassword && !_isPasswordVisible,
            decoration: InputDecoration(
              hintText: widget.isPassword ? '••••••••••••' : widget.fieldText,
              hintStyle: TextStyle(color: Colors.grey[500]),
              prefixIcon: widget.iconImagePath!='' ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  widget.iconImagePath,
                  width: 24,
                  height: 24,
                )
              ) : null,
              suffixIcon: widget.isPassword
                  ? IconButton(
                icon: Icon(
                  _isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.grey[500],
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
                  : null,
              border: InputBorder.none,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }
}