import 'dart:io';
import 'usuarioproyecto.dart';

class Menus {
  static String inicio() {
    String? opcion;

    do {
      stdout.writeln("""Hola!, selecciona una opción:
      1. Registro
      2. Log in""");
      opcion = stdin.readLineSync() ?? 'error';
    } while (opcion != "1" && opcion != "2");

    return opcion;
  }

  static Future<Usuario?> registro() async {
    bool creado = false;
    Usuario? usuario;
    do {
      stdout.writeln("Introduce el nombre con el que te quieres registrar aquí");
      String nombre = stdin.readLineSync() ?? 'error';
      stdout.writeln("Ahora introduce la que será tu contraseña");
    String password = (stdin.readLineSync() ?? 'error');
      bool nombreExiste = await Usuario.comprobarSiExiste(nombre);

      if (nombreExiste) {
        stdout.writeln("El nombre de usuario ya existe, prueba con otro");
      } else {
        usuario = Usuario();
        usuario.user = nombre;
        usuario.password = password;
        creado = await usuario.save();
      }
    } while (!creado);
    return usuario;
  }
}