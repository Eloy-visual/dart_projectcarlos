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
      Menus.registro();
      break;

    case "2":
      bool logueado = false;
      Usuario usuario = Usuario();

      do {
        stdout.writeln("Introduce tu nombre de usuario:");
        String nombre = stdin.readLineSync() ?? '';
        stdout.writeln("Ahora introduce tu contraseña:");
        String password = stdin.readLineSync() ?? '';

        if (nombre == usuario.user && password == usuario.password) {
          stdout.writeln("Login correcto");
          logueado = true;

          // Acción tras login exitoso: buscar un Pokémon
          stdout.writeln("Escribe el nombre del Pokémon que deseas buscar:");
          String nombrePokemon = stdin.readLineSync() ?? '';

          Pokemon pokeInstance = Pokemon();
          Pokemon? poke = await pokeInstance.obtenerPokemon(nombrePokemon);

          if (poke != null) {
            Pokemon.imprimirInfo(poke);
          }

        } else {
          stdout.writeln("Login incorrecto");
        }
      } while (!logueado);
      break;

    default:
      stdout.writeln("Opción no válida");
      break;
  }
}
