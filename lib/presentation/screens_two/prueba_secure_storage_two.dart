import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/screens/sesion_iniciada_page.dart';
import 'package:flutter_application_1/presentation/utils/secure_storage_methods.dart';
import '../screens/avisos_prueba.dart';
import '../utils_two/DtoEmail_two.dart';
import '../widgets/checkBox.dart';

class HomePageTwo extends StatefulWidget {

  const HomePageTwo({super.key});

  @override
  State<HomePageTwo> createState() => _HomePageTwoState();
}

class _HomePageTwoState extends State<HomePageTwo> {

  List<String> newListEmail = []; // Listas de usuarios
  List<DtoEmailTwo> newListUserObject = []; // Listas de usuarios

  bool isChecked = false; // Si se llena (true) o no (false) el check
  // Llave global
  final GlobalKey<FormState> _formKey = GlobalKey();
  // Declarar cada controlodador
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // Declarar el llamado de la clase SecureStorageMethods para utilizar el metodo get en los controladores
  final SecureStorageMethods _secureStorageMethods = SecureStorageMethods();

  // Se ejecuta una vez antes de que se inicie el StatefulWidget
  @override
  void initState() {
    super.initState();
    fetchSecureStorageData();
    obtainedListEmailOfJSON();
  }

  // Metodo para obtener datos y mostrarlos en los formularios Username y password
  Future <void> fetchSecureStorageData() async {
    /* El keyword "await" se utiliza en el metodo "fetchSecureStorageData()" 
    para esperar a que estos métodos asíncronos (async) se completen antes de asignar 
    los valores recuperados u obtenidos (getUserName, getPassword) a los controladores 
    _userNameController y _passwordController. */
    _userNameController.text = await _secureStorageMethods.getUserName() ?? "";
    _passwordController.text = await _secureStorageMethods.getPassword() ?? "";

    await _secureStorageMethods.setIsNotices(true); // Para inicializar las notificaciones a true
  }

  // Metodo para guardar la lista en un JSON
  Future <void> saveListEmailOfJSON() async {
    await _secureStorageMethods.setListEmail(newListEmail);
    print("Lista guardada");
  }

  // Metodo para obtener la lista del JSON
  Future <void> obtainedListEmailOfJSON() async {
    newListEmail = await _secureStorageMethods.getListEmail(); /* Guarda la lista del JSON convertida 
                                                              (JSON a Dart) en la lista local (formato Dart) */
    print("El contenido de la lista es: ${newListEmail}");
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
                
                /* Boton utilizando el JSON y la lista local a la vez 
                (Aplicado la logica de la primera historia de usuario)*/
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width, // Largo del boton Response
                    child: ElevatedButton(
                      onPressed: () {
                        changeScreens(); // Llamado del metodo para cambiar pantallas
                      },
                      // Texto del boton
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Text('Imprimir Lista aplicando el JSON'),
                      ),
                    ),
                  ),
                ),

                /* Mismo boton, pero la lista es un objeto*/
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width, // Largo del boton Response
                    child: ElevatedButton(
                      onPressed: () {
                        changeScreensObjects(); // Llamado del metodo para cambiar pantallas
                      },
                      // Texto del boton
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Text('Imprimir Lista aplicando el JSON'),
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

  // Metodo para cambiar de pantallas si es la pantalla de avisos o el usuario logeado
  changeScreens() {
    bool isEmail = false;
    
    if (_userNameController.text.isNotEmpty) { // Si el formulario USername no esta vacio

      if (newListEmail.isNotEmpty) { // Si no esta vacia la lista

        // ciclo para saber si se encuentra el email en la lista
        for (int i = 0; i < newListEmail.length; i++) {
          if (newListEmail[i] == _userNameController.text) { // Si lo encuentra
            isEmail = true; /* No muestra la pantalla de avisos (true) de lo 
                            contrario se muestra dicha pantalla (false)*/
            print("Comparando Iguales: ${newListEmail[i]} == ${_userNameController.text}");
          }
        }

        if (isEmail) { // Si encuentra el dato en la lista, se muetra la pantalla de logeo
          Navigator.push(context, MaterialPageRoute(builder: (context) => InicioPage()));

        } else { // Si no se encontro el dato en la lista, se agrega el dato y se pasa a la pantalla de avisos
          newListEmail.add(_userNameController.text);
          saveListEmailOfJSON(); // Metodo para guardar la lista
          Navigator.push(context, MaterialPageRoute(builder: (context) => AvisosPage()));
        }

      } else { // Agrega el nuevo dato a la lista y se pasa a la pantalla de avisos
        newListEmail.add(_userNameController.text);
        print("NO hay datos en la lista, agregando: ${newListEmail[0]}");
        saveListEmailOfJSON(); // Metodo para guardar la lista
        Navigator.push(context, MaterialPageRoute(builder: (context) => AvisosPage()));
      }

    } else { // Debe llenar el formulario
      print("No hay nada en el formulario Username, llenelo por favor");
    }
  }


  // Metodo para utilizar la lista con un constructor
  changeScreensObjects() {
    bool isEmail = false;
    
    if (_userNameController.text.isNotEmpty) { // Si el formulario USername no esta vacio

      if (newListEmail.isNotEmpty) { // Si no esta vacia la lista

        // ciclo para saber si se encuentra el email en la lista
        for (int i = 0; i < newListUserObject.length; i++) {
          if (newListUserObject[i].email == _userNameController.text) { // Si lo encuentra
            isEmail = true; /* No muestra la pantalla de avisos (true) de lo 
                            contrario se muestra dicha pantalla (false)*/
            print("Comparando correos Iguales: ${newListUserObject[i].email} == ${_userNameController.text}");
            print("Comparando contraseñas Iguales: ${newListUserObject[i].password} == ${_passwordController.text}");
          }
        }

        if (isEmail) { // Si encuentra el dato en la lista, se muetra la pantalla de logeo
          Navigator.push(context, MaterialPageRoute(builder: (context) => InicioPage()));

        } else { // Si no se encontro el dato en la lista, se agrega el dato y se pasa a la pantalla de avisos
          newListUserObject.add(DtoEmailTwo());
          //emailOfUser.add(DtoEmail(_userNameController.text));
          saveListEmailOfJSON(); // Metodo para guardar la lista
          Navigator.push(context, MaterialPageRoute(builder: (context) => AvisosPage()));
        }

      } else { // Agrega el nuevo dato a la lista y se pasa a la pantalla de avisos
        newListEmail.add(_userNameController.text);
        print("NO hay datos en la lista, agregando: ${newListEmail[0]}");
        saveListEmailOfJSON(); // Metodo para guardar la lista
        Navigator.push(context, MaterialPageRoute(builder: (context) => AvisosPage()));
      }

    } else { // Debe llenar el formulario
      print("No hay nada en el formulario Username, llenelo por favor");
    }
  }
}