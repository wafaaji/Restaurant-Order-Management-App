import 'package:employee/components/customDropdownButton.dart';
import 'package:employee/components/customText.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String buttonLabel;
  final VoidCallback onPressed;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final InputDecoration decoration;
  final bool obscureText;
  final String? defaultText;
  final String hint;
  final ValueChanged<String?> onChanged;
  final String? value;
  final List<String> items;


  const CustomDialog({
    required this.title,
    required this.controller,
    required this.buttonLabel,
    required this.onPressed,
    required this.keyboardType,
    this.textInputAction,
    required this.onSaved,
    this.validator,
    required this.decoration,
    this.obscureText = false,
    this.defaultText,
    required this.hint,
    required this.onChanged,
    required this.value,
    required this.items,
  }) : assert(obscureText == false || defaultText == null,
  "Cannot set defaultText when obscureText is true.");

  @override
  Widget build(BuildContext context) {

    if (defaultText != null && controller.text.isEmpty) {
      controller.text = defaultText!;
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: Center(
        child: CustomText(
          text: title,
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      content: Container(
        width: 300,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 50.0,
                width: 300.0,
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: TextFormField(
                      controller: controller,
                      keyboardType: keyboardType,
                      textInputAction: textInputAction,
                      obscureText: obscureText,
                      onSaved: onSaved,
                      validator: validator,
                      decoration: decoration.copyWith(
                        hintText: decoration.hintText,
                      ),
                      cursorColor: Color(0xFFBE0B0B),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              CustomDropdownButton(
                hint: hint,
                onChanged: onChanged,
                value: value,
                items: items,
                width: 150.0,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFBE0B0B)),
          ),
          onPressed: onPressed,
          child: CustomText(
              text: buttonLabel,
              fontSize: 20.0,
              color: Colors.white,
          ),
        ),
      ],
    );
  }
}
