import 'dart:convert'; // Libreria para utilizar las funciones del JSON
import 'package:flutter/material.dart';
// Libreria para utilizar las funciones del flutter secure storage
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageMethods {
  // Creación del almacenamiento
  final storage = const FlutterSecureStorage();

  // Nombre de cada llave
  final String _keyUserName = 'username';
  final String _keyPassWord = 'password';
  final String _keyListEmail = 'listEmail';

  final String _keyIsNotices = 'isNotices';

  // Metodo set para asignar la respuesta en bool 
  Future setIsNotices(bool isNotices) async {
    await storage.write(key: _keyIsNotices, value: isNotices.toString()); // "toString" convertir bool a String
  }
  // Metodo get para obtener la respuesta en bool
  Future<bool?> getIsNotices() async {
    var isNoticesValue = await storage.read(key: _keyIsNotices);
    return isNoticesValue == 'true'; // Si es igual a true, returna true de lo contrario retorna false
  }


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


  // Metodo para guardar la lista de Email en un JSON
  Future <void> setListEmail(List<String> listEmail) async {
    String myListEmailJson = jsonEncode(listEmail); /* Convertir la lista (formato Dart) a JSON */
    await storage.write(key: _keyListEmail, value: myListEmailJson);
  }

  // Metodo para obtener la lista de Email de un JSON
  Future <List<String>> getListEmail() async {
    String? obtainedStorageListEmailJson = await storage.read(key: _keyListEmail);

    if (obtainedStorageListEmailJson != null) { // Si la lista es diferente de nulo
      List <dynamic> obtainedStorageList = jsonDecode(obtainedStorageListEmailJson); /* Obtiene el formato JSON y lo 
                                                                                    convierte en formato de codigo Dart 
                                                                                    (se guarda en una la lista de tipo dynamic 
                                                                                    porque es la manera en como trabaja la funcion 
                                                                                    "jsonDecode", ya que a la hora de obtener los datos
                                                                                    de un JSON los devuelve como tipo dynamic)*/
      return List<String>.from(obtainedStorageList); /* "from" se crea  una nueva lista, pero especificando que sea de tipo
                                                    String y retorna la lista (normalmente se utiliza la funcion "from" para 
                                                    cuando se tiene una lista dinamica al principio y se especifica que sea 
                                                    de otro tipo creando otra lista) */
    }
    return []; // Si no hay nada en la lista, retorna la lista vacia
  }
}