import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  MyTextField({
    super.key,
    required this.controller,
    required this.formkey,
    required this.validator,
    required this.label,
  });
  String label;
  GlobalKey<FormState> formkey;
  TextEditingController controller;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(label, style: Theme.of(context).textTheme.labelLarge),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            clipBehavior: Clip.hardEdge,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: InputBorder.none,
              ),
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }
}

class MyDropdownField extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String?>? onChanged;

  const MyDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(label, style: Theme.of(context).textTheme.labelLarge),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            clipBehavior: Clip.hardEdge,
            child: DropdownButtonFormField<String>(
              initialValue: value,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
              ),
              validator: validator,
              items: items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
