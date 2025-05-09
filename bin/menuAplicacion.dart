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

  static registro() async {
    bool creado = false;
    do {
      creado = false;
      stdout.writeln("Introduce el nombre con el que te quieres registrar");
      String nombre = stdin.readLineSync() ?? 'error';
      stdout.writeln("Ahora introduce la que será tu contraseña");
      String password = stdin.readLineSync() ?? 'error';
      bool nombreExiste = await Usuario.comprobarSiExiste(nombre);
    Usuario Registro() {
  stdout.writeln("Introduce un nombre.");
  String user = stdin.readLineSync() ?? '';
  stdout.writeln("Introduce una contraseña.");
  String password = stdin.readLineSync() ?? '';
  
  Usuario nuevoUsuario = Usuario();
  nuevoUsuario.user = user;
  nuevoUsuario.password = password;

  stdout.writeln("Registro exitoso.");
  return nuevoUsuario;
    }

      if (nombreExiste) {
        stdout.writeln("El nombre ya existe, prueba con otro");
      } else {
        Usuario usuario = Usuario();
        usuario.user = nombre;
        usuario.password = password;
        creado = await usuario.save();
      }
    } while (creado == false);
  }
}