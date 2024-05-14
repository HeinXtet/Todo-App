import 'package:app/theme/AppColors.dart';
import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final String? hint;
  final bool isPassword;
  final TextEditingController? controller;

  const Input({super.key, this.hint, this.controller, this.isPassword = false});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  void initState() {
    super.initState();
    setState(() {
      isObscureText = widget.isPassword;
    });
  }

  bool isObscureText = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isObscureText,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hint ?? "",
        fillColor: Colors.white.withOpacity(0.2),
        hintStyle: TextStyle(color: AppColors.primaryBlack, fontSize: 14),
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        suffixIcon: widget.isPassword
            ? GestureDetector(
          onTap: () {
            setState(() {
              isObscureText = !isObscureText;
            });
          },
          child: Icon(
            size: 18,
            color: Colors.grey,
            isObscureText
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
        )
            : null,
      ),
    );
  }
}
