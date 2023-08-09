import 'package:flutter/material.dart';

import '../utils/secure_storage_methods.dart';

class CheckBox extends StatefulWidget {
  // final Future userName;
  // final Future password;
  final TextEditingController userNameController;
  final TextEditingController passwordController;
  const CheckBox({
    super.key, 
    // required this.userName,
    // required this.password,
    required this.userNameController, 
    required this.passwordController
  });

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {

  bool isChecked = false; // Si se llena (true) o no (false) el check
  
  /* Declarar el llamado de la clase SecureStorageMethods para utilizar los metodos (set, get)
  */
  final SecureStorageMethods _secureStorageMethods = SecureStorageMethods();

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      checkColor: Colors.white,
      //fillColor: MaterialStateProperty.resolveWith(_getColor),
      value: isChecked,
      onChanged: (bool? value) async {
        setState(() {
          isChecked = value!;
        });
        if (value == true) {
          await _secureStorageMethods.setUserName(widget.userNameController.text);
          await _secureStorageMethods.setPassword(widget.passwordController.text);
        }
      },
    );
  }
  /*
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
  */
}