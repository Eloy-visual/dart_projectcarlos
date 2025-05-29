import 'dart:io';
import 'baseDeDatosproyecto.dart';
import 'menuAplicacion.dart';
import 'usuarioproyecto.dart';
import 'pokemon.dart';

void main() async {
  
  await DataBase.instalarBBDD();

  String opcion = Menus.inicio();

  switch (opcion) {
    case "1":
      Usuario? usuario = await Menus.registro();
      if (usuario != null) {
        stdout.writeln("Registro exitoso. ¡Bienvenido, ${usuario.user}!");
        await buscarPokemon();
      }
      break;

    case "2":
      bool logueado = false;
      Usuario usuario = Usuario();

      do {
        stdout.writeln("Introduce tu nombre de usuario.");
        String nombre = stdin.readLineSync() ?? '';
        stdout.writeln("Ahora introduce tu contraseña.");
        String password = stdin.readLineSync() ?? '';

        if (nombre == usuario.user && password == usuario.password) {
          stdout.writeln("Login correcto");
          logueado = true;
          await buscarPokemon();
        } else {
          stdout.writeln("Login incorrecto");
        }
      } while (!logueado);
      break;

    default:
      stdout.writeln("Opción no válida para este programa.");
      break;
  }
}

Future<void> buscarPokemon() async {
  stdout.writeln("Escribe el nombre del pokemon.");
  String nombrePokemon = stdin.readLineSync() ?? '';
  Pokemon? poke = await Pokemon().obtenerPokemon(nombrePokemon.toLowerCase());
  if (poke != null) {
    Pokemon.imprimirInfo(poke);
  } else {
    stdout.writeln("No se encontró información sobre el Pokémon '$nombrePokemon'.");
  }
}