import 'package:flutter/material.dart';

class CostomFromFild extends StatelessWidget {
  final String hintText;
  final double heigth;
  final RegExp velidationRegExp;
  final bool obscreText;
  final void Function(String?) onSaved;

  const CostomFromFild({
    super.key,
    required this.hintText,
    required this.heigth,
    required this.velidationRegExp,
    required this.onSaved,
    this.obscreText = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heigth,
      child: TextFormField(
        onSaved: onSaved,
        validator: (value) {
          if (value != null && velidationRegExp.hasMatch(value)) {
            return null;
          }
          return 'Enter a valid ${hintText.toLowerCase()}';
        },
        obscureText: obscreText,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
