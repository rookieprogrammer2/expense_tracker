import 'package:flutter/material.dart';

typedef Validator = String? Function(String?);

class MyTextFormField extends StatelessWidget {
  final Validator validator;
  final String hintText;
  final bool isObscure;
  final IconButton? suffixIcon;
  final TextInputType keyboardType;
  final TextEditingController? textEditingController;
  final void Function(String)? onChanged;
  final Icon textFieldIcon;
  final BuildContext? context;

  const MyTextFormField(
      {super.key,
        this.textEditingController,
        required this.hintText,
        this.isObscure = false,
        this.suffixIcon,
        required this.keyboardType,
        required this.validator,
        this.onChanged,
        required this.textFieldIcon,
        this.context});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.001,
        vertical: height * 0.01,
      ),
      child: Row(
        children: [
          textFieldIcon,
          SizedBox(width: width * 0.02),
          Expanded(
            child: TextFormField(
              style: const TextStyle(
                color: Colors.white,
              ),
              validator: validator,
              controller: textEditingController,
              keyboardType: keyboardType,
              obscureText: isObscure,
              onChanged: onChanged,

              decoration: InputDecoration(
                border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1)),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade500, width: 1),
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.yellow.shade300, width: 1),
                ),

                suffixIcon: suffixIcon,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
