import 'package:flutter/material.dart';
import 'package:helper_finder/ui/widgets/text_field_container.dart';

import '../../core/utils/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;

  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool isObscure = true;
  final GlobalKey<FormState> _passkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFieldContainer(
          child: Form(
            key: _passkey,
            child: TextFormField(
              controller: widget.controller,
              obscureText: isObscure,
              validator: (value) {
                if (value!.length < 6) {
                  return 'Password must be longer than 6 characters';
                } else {
                  return "";
                }
              },
              onChanged: widget.onChanged,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Password",
                icon: Icon(
                  Icons.lock,
                  color: kPrimaryColor,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Positioned(
          right: 15,
          height: 80,
          child: GestureDetector(
            onTap: () {
              setState(() {
                isObscure = !isObscure;
              });
            },
            child: isObscure
                ? const Icon(
                    Icons.visibility,
                    color: kPrimaryColor,
                  )
                : const Icon(
                    Icons.visibility_off,
                    color: kPrimaryColor,
                  ),
          ),
        )
      ],
    );
  }
}
