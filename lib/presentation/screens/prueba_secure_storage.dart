import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/screens/sesion_iniciada_page.dart';
import 'package:flutter_application_1/presentation/utils/secure_storage_methods.dart';

import '../utils/DtoEmail.dart';
import '../widgets/checkBox.dart';
import 'avisos_prueba.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<DtoEmail> emailOfUser = [
    //DtoEmail("david@gmail.com"),
  ];

  bool isChecked = false; // Si se llena (true) o no (false) el check
  // Llave global
  final GlobalKey<FormState> _formKey = GlobalKey();
  // Declarar cada controlodador
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // Declarar el llamado de la clase SecureStorageMethods para utilizar el metodo get en los controladores
  final SecureStorageMethods _secureStorageMethods = SecureStorageMethods();

  // Se ejecuta una vez antes de que se ejecute el StatefulWidget
  @override
  void initState() {
    super.initState();
    fetchSecureStorageData();
  }

  // Metodo para obtener datos y asignar true isNotice
  Future <void> fetchSecureStorageData() async {
    /* El keyword "await" se utiliza en el metodo "fetchSecureStorageData()" 
    para esperar a que estos métodos asíncronos (async) se completen antes de asignar 
    los valores recuperados u obtenidos (getUserName, getPassword) a los controladores 
    _userNameController y _passwordController. */
    _userNameController.text = await _secureStorageMethods.getUserName() ?? "";
    _passwordController.text = await _secureStorageMethods.getPassword() ?? "";

    await _secureStorageMethods.setIsNotices(true); // Para inicializar las notificaciones a true
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
                // Manejo del icono y texto en una fila
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
                
                // Manejo del formulario usuario
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextFormField(
                    controller: _userNameController,
                    decoration: const InputDecoration(
                      hintText: 'Username',
                    ),
                  ),
                ),

                // Manejo del formulario de la contraseña
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

                // Manejo del checkBox
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CheckBox( // Uso de un checkBox
                        // Mandar los controladores a utilizar oara cada formulario
                        userNameController: _userNameController,
                        passwordController: _passwordController,
                      ),
                      const Text("Recuerdame"),
                    ],
                  ),
                ),
                
                // Manejo del boton
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width, // Largo del boton Response
                    child: ElevatedButton(
                      onPressed: () async {
                        // Se obtiene el estado de isNotice si es true o false
                        bool? isNotices = await _secureStorageMethods.getIsNotices();

                        // Si isNotices es true, se pasa a las ventanas de avisos de lo contrario pasa a la ventana de inicio de sesion
                        if (isNotices!) {
                          await _secureStorageMethods.setIsNotices(false);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AvisosPage()));
                        } else {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => InicioPage()));
                        }
                      },
                      // Texto del boton
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Text('Siguiente pantalla'),
                      ),
                    ),
                  ),
                ),

                // Manejo del boton para probar la lista
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width, // Largo del boton Response
                    child: ElevatedButton(
                      onPressed: () {
                        bool isEmail = false;
                        
                        if (_userNameController.text.isNotEmpty) {

                          if (emailOfUser.isNotEmpty) {

                            // ciclo para saber si se encuentra el email en la lista
                            for (int i = 0; i < emailOfUser.length; i++) {
                              if (emailOfUser[i].email == _userNameController.text) { // Si lo encuentra
                                isEmail = true; // No muestra la pantalla de avisos
                              }
                            }

                            if (isEmail) {
                              
                              for (int i = 0; i < emailOfUser.length; i++) {

                                // Ciclo para saber si existe el correo para no mostrar nuevamente la pantalla de avisos
                                if (emailOfUser[i].email == _userNameController.text) {
                                  print("Comparando Iguales: ${emailOfUser[i].email} == ${_userNameController.text}");
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => InicioPage()));
                                }
                              // else {
                              //   print(" ");
                              //   print("Comparando NO son Iguales: ${emailOfUser[i].email} == ${_userNameController.text}");
                              //   emailOfUser.add(DtoEmail(_userNameController.text));
                              //   print("Como no son iguales, se guarda: ${emailOfUser[i].email}");
                              //   Navigator.push(context, MaterialPageRoute(builder: (context) => AvisosPage()));
                              // }
                              }

                            } else {
                              emailOfUser.add(DtoEmail(_userNameController.text));
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AvisosPage()));
                            }

                          } else {
                            emailOfUser.add(DtoEmail(_userNameController.text));
                            print("NO hay datos en la lista, agregando: ${emailOfUser[0].email}");
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AvisosPage()));
                          }

                        } else {
                          print("No hay nada en el formulario Username, llenelo por favor");
                          /*
                          if (emailOfUser.isEmpty) {
                            print("No hay nada en el formulario Username, llenelo por favor");

                          } else {
                            emailOfUser.add(DtoEmail(_userNameController.text));
                            print("NO hay datos en la lista, agregando: ${emailOfUser[0].email}");
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AvisosPage())); 
                          }
                          */
                        }
                        
                        // // Formas dde agregar datos a la lista
                        // print("${emailOfUser[0].email}");
                        // emailOfUser.add(DtoEmail("Correo"));
                        // print("${emailOfUser[1].email}");
                        // emailOfUser.add(DtoEmail(_userNameController.text));
                        // print("${emailOfUser[2].email}");
                      },
                      // Texto del boton
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Text('Imprimir Lista'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}