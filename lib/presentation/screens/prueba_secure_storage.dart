import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/utils/secure_storage_methods.dart';

import '../widgets/checkBox.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isChecked = false; // Si se llena (true) o no (false) el check
  // Llave global
  final GlobalKey<FormState> _formKey = GlobalKey();
  // Declarar cada controlodador
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // Declarar el llamado de la clase SecureStorageMethods para utilizar los metodos (set, get)
  final SecureStorageMethods _secureStorageMethods = SecureStorageMethods();

  // Se ejecuta una vez antes de que se ejecute el StatefulWidget
  @override
  void initState() {
    super.initState();
    fetchSecureStorageData();
  }

  // Metodo para obtener datos (get)
  Future <void> fetchSecureStorageData() async {
    /* El keyword "await" se utiliza en el metodo "fetchSecureStorageData()" 
    para esperar a que estos métodos asíncronos (async) se completen antes de asignar 
    los valores recuperados u obtenidos (getUserName, getPassword) a los controladores 
    _userNameController y _passwordController. */
    _userNameController.text = await _secureStorageMethods.getUserName() ?? "";
    _passwordController.text = await _secureStorageMethods.getPassword() ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.key),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Prueba del Flutter Secure Storage',
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextFormField(
                    controller: _userNameController,
                    decoration: const InputDecoration(
                      hintText: 'Username',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 20),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Checkbox(
                //       checkColor: Colors.white,
                //       //fillColor: MaterialStateProperty.resolveWith(_getColor),
                //       value: isChecked,
                //       onChanged: (bool? value) async {
                //         setState(() {
                //           isChecked = value!;
                //         });
                //         if (value == true) {
                //           await _secureStorageMethods.setUserName(_userNameController.text);
                //           await _secureStorageMethods.setPassword(_passwordController.text);
                //         }
                //       },
                //     ),
                //     const Text("Recuerdame"),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CheckBox( // Uso de un checkBox
                        userNameController: _userNameController,
                        passwordController: _passwordController,
                      ),
                      const Text("Recuerdame"),
                    ],
                  ),
                ),
                /*
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Almacena el contenido de los formularios
                        await _secureStorageMethods.setUserName(_userNameController.text);
                        await _secureStorageMethods.setPassword(_passwordController.text);
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Text('Save'),
                      ),
                    ),
                  ),
                ), */
              ],
            ),
          ),
        ),
      ),
    );
  }
}