import 'dart:convert';
import 'package:http/http.dart' as http;

class Pokemon {
  
  String? nombre;
  List<String> tipos = [];
  List<String> habilidades = [];
  int? vida;
  int? ataque;
  int? defensa;

  Pokemon();

  Pokemon.fromAPI(dynamic datos, List<String> listaHabilidades) {
    nombre = datos['name'];
    for (var elemento in datos['types']) {
      tipos.add(elemento['type']['name']);
    }
    for (var habilidad in listaHabilidades) {
      habilidades.add(habilidad);
    }
    for (var elemento in datos['stats']) {
      switch (elemento['stat']['name']) {
        case 'hp':
          vida = elemento['base_stat'];
          break;
        case 'attack':
          ataque = elemento['base_stat'];
          break;
        case 'defense':
          defensa = elemento['base_stat'];
          break;
      }
    }
  }

  Future<List<String>> listaDeHabilidades(dynamic datos) async {
    List<String> lista = [];
    for (var elemento in datos['abilities']) {
      lista.add(elemento['ability']['name']);
    }
    return lista;
  }

  Future<Pokemon?> obtenerPokemon(String nombre) async {
    Uri url = Uri.parse("https://pokeapi.co/api/v2/pokemon/$nombre");
    var respuesta = await http.get(url);
    try {
      if (respuesta.statusCode == 200) {
        var body = json.decode(respuesta.body);
        List<String> lista = await listaDeHabilidades(body);
        Pokemon pokemon = Pokemon.fromAPI(body, lista);
        return pokemon;
      } else if (respuesta.statusCode == 404) {
        throw ("El pokemon que buscas no existe!");
      } else {
        throw ("Error de conexión");
      }
    } catch (e) {
      return null;
    }
  }

  static void imprimirInfo(Pokemon pokemon) {
    print("Nombre: ${pokemon.nombre}");
    print("Tipos: ${pokemon.tipos.join(", ")}");
    print("Habilidades: ${pokemon.habilidades.join(", ")}");
    print("Nivel: ${(pokemon.vida ?? 0) + (pokemon.ataque ?? 0) + (pokemon.defensa ?? 0)}");
    print("    Vida:    ${pokemon.vida}");
    print("    Ataque:  ${pokemon.ataque}");
    print("    Defensa: ${pokemon.defensa}");
  }
}
