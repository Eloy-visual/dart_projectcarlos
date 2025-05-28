import 'dart:convert';
import 'package:http/http.dart' as http;

class Pokemon {
  String? nombre;
  int? salud;
  int? numeroDeAtaques;
  int? defensa;
  List<String> tipos = [];

  Pokemon();
  Pokemon.fromAPI(Map<String, dynamic> datos) {
    nombre = datos['name'];
    for (var elemento in datos['types']) {
      tipos.add(elemento['type']['name']);
    }
    for (var stat in datos['stats']) {
      switch (stat['stat']['name']) {
        case 'hp':
          salud = stat['base_stat'] ?? 0;
          break;
        case 'attack':
          numeroDeAtaques = stat['base_stat'] ?? 0;
          break;
          case 'defense':
          defensa = stat['base_stat'] ?? 0;
          break;
        default:
      }
    }
  }
  static Future<Pokemon?> obtenerPokemon(String nombre) async {
    Uri url = Uri.parse("https://pokeapi.co/api/v2/pokemon/$nombre");

    try {
      var respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        var body = json.decode(respuesta.body);
        return Pokemon.fromAPI(body);
      } else if (respuesta.statusCode == 404) {
        print("El Pokémon que buscas no existe");
      } else {
        print("Error de conexión: ${respuesta.statusCode}");
      }
    } catch (e) {
      print("Excepción al obtener el Pokémon: $e");
    }
    return null;
  }

  void imprimirInfo() {
    print("Nombre: $nombre");
    print("Clase: ${tipos.join(', ')}");
    print("Vida: $salud");
    print("Ataque: $numeroDeAtaques");
    print("Defensa: $defensa");
  }
}