//import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageMethods {
  // Creación del almacenamiento
  final storage = const FlutterSecureStorage();

  // Nombre de cada llave
  final String _keyUserName = 'username';
  final String _keyPassWord = 'password';

  // Metodo set para asignar nombre
  Future setUserName(String username) async {
    await storage.write(key: _keyUserName, value: username);
  }
  
  // Metodo set para asignar contrasenia
  Future setPassword(String password) async {
    await storage.write(key: _keyPassWord, value: password);
  }

  // Metodo get para obtener el nombre del usuario
  Future <String?> getUserName() async {
    return await storage.read(key: _keyUserName);
  }

  // Metodo get para obtener la contrasenia del usuario
  Future <String?> getPassword() async {
    return await storage.read(key: _keyPassWord);
  } 
}