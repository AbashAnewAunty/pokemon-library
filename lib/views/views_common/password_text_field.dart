import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.textEditingController,
  });

  final TextEditingController textEditingController;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _visiblePassword = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        label: const Text('Password'),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _visiblePassword = !_visiblePassword;
            });
          },
          child: _visiblePassword
              ? const Icon(Icons.remove_red_eye)
              : const Icon(Icons.remove_red_eye_outlined),
        ),
      ),
      obscureText: !_visiblePassword,
      obscuringCharacter: "＊",
      controller: widget.textEditingController,
    );
  }
}
