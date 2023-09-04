import 'package:flutter/material.dart';

class MyDropDownButton extends StatefulWidget {
  final String value;
  final void Function(String?)? onChanged;
  const MyDropDownButton(
      {super.key, required this.onChanged, required this.value});
  @override
  State<MyDropDownButton> createState() => _MyDropDownButtonState();
}

class _MyDropDownButtonState extends State<MyDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: widget.value,
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      items: <String>[
        'Gallery',
        'Images',
        'Screenshots',
        'Camera',
        'Facebook',
        'Pictures',
        'Videos',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: widget.onChanged,
    );
  }
}
