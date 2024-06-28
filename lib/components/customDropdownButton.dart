import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {

  final String hint;
  final ValueChanged<String?> onChanged;
  final String? value;
  final List<String> items;
  final double width;

  CustomDropdownButton({
    required this.hint,
    required this.onChanged,
    required this.value,
    required this.items,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: DropdownButton<String>(
          hint: Text(hint),
          onChanged: (newValue) {
            onChanged(newValue);
          },
          value: value,
          items: items.map((selectedType) {
            return DropdownMenuItem<String>(
              child: Text(selectedType),
              value: selectedType,
            );
          }).toList(),
        ),
      ),
    );
  }
}
