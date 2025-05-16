import 'package:flutter/material.dart';
import '../utils/text_styles.dart';
import '../utils/colors.dart';

class DateInput extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hintText;

  const DateInput({
    Key? key,
    required this.controller,
    this.validator,
    this.hintText,
  }) : super(key: key);

  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    String text = widget.controller.text;
    if (text.length > 10) {
      widget.controller.value = TextEditingValue(
        text: text.substring(0, 10),
        selection: TextSelection.collapsed(offset: 10),
      );
      return;
    }

    // Format: JJ/MM/AAAA
    if (text.length == 2 || text.length == 5) {
      if (!text.endsWith('/')) {
        widget.controller.value = TextEditingValue(
          text: text + '/',
          selection: TextSelection.collapsed(offset: text.length + 1),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: 'Date de naissance',
        hintText: widget.hintText ?? 'JJ/MM/AAAA',
        labelStyle: AppTextStyles.regular.copyWith(color: AppColors.contrastColor),
        prefixIcon: Icon(Icons.calendar_today, color: AppColors.contrastColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.contrastColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.contrastColor),
        ),
        floatingLabelStyle: AppTextStyles.regular.copyWith(color: AppColors.contrastColor),
      ),
      keyboardType: TextInputType.number,
      maxLength: 10,
      validator: widget.validator,
      onChanged: (value) {
        if (value.length == 10) {
          // Vérifier si la date est valide
          final parts = value.split('/');
          if (parts.length == 3) {
            try {
              DateTime.parse(parts.reversed.join('-'));
            } catch (e) {
              widget.controller.value = TextEditingValue(
                text: value.substring(0, 8), // Supprimer le dernier caractère
                selection: TextSelection.collapsed(offset: 8),
              );
            }
          }
        }
      },
    );
  }
}
