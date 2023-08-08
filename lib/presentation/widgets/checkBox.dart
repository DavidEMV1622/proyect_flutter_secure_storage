import 'package:flutter/material.dart';

class CheckBox extends StatefulWidget {
  final Future userName;
  final Future password;
  const CheckBox({super.key, required this.userName, required this.password});

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {

  bool isChecked = false; // Si se llena (true) o no (false) el check

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(_getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
        setState(() async {
          if (isChecked == true) {
            await widget.userName;
            await widget.password;
          }
        });
      },
    );
  }

  Color _getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.black45;
    }
}