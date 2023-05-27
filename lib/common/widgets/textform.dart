import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/utils.dart';

class MyTextFormField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final int maxLines;
  final bool isRequired;
  final bool isNumber;
  final bool isEnabled;
  const MyTextFormField(
      {super.key,
      required this.label,
      required this.controller,
      this.maxLines = 1,
      this.isRequired = false,
      this.isNumber = false,
      this.isEnabled = true});

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  late var textLength = 0;

  @override
  void initState() {
    super.initState();
    textLength = widget.controller.text.length;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        //alignLabelWithHint: true,
        errorBorder: borderStyle(color: Colors.red),
        focusedBorder: borderStyle(color: AppColors.primaryColor),
        border: borderStyle(color: AppColors.primaryColor),
        enabledBorder: borderStyle(color: AppColors.primaryColor),
        disabledBorder: borderStyle(color: AppColors.terciaryColor),
        label: Text(
          widget.isRequired ? "${widget.label} *" : widget.label,
          textAlign: TextAlign.left,
          style: const TextStyle(color: AppColors.myBlack, fontSize: 16),
        ),
        counterText: '',
      ),
      enabled: widget.isEnabled,
      maxLines: widget.maxLines,
      cursorRadius: const Radius.circular(10),
      keyboardType: widget.isNumber ? TextInputType.number : TextInputType.text,
      inputFormatters: <TextInputFormatter>[
        widget.isNumber
            ? FilteringTextInputFormatter.allow(
                RegExp(r'^([0-9]+(\.?[0-9]?[0-9]?)?)'),
              )
            : FilteringTextInputFormatter.deny(
                RegExp(r'[]'),
              ),
      ],
      onChanged: (value) {
        setState(() {
          textLength = value.length;
        });
      },
      validator: (value) {
        if (!widget.isRequired) {
          return null;
        }
        if (value!.trim().isEmpty) {
          return "Requerido";
        }
        return null;
      },
    );
  }

  OutlineInputBorder borderStyle({required Color color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: color,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(15),
      ),
    );
  }
}
