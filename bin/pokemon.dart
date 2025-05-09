import "dart:convert";
import "dart:io";

class Pokemon {
  String? nombre;
  int? evoluciones;
  int? nivelDelPokemon;
  int? idPokemon;
  List<String> tipos = [];
  int salud = 0;
  int numeroDeAtaques = 0;

  Pokemon();
  Pokemon.fromAPI(datos, listaHabilidades) {
    nombre = datos['name'];
    for (var elemento in datos['types']) {
      tipos.add(elemento['type']['name']);
    }
    for (var elemento in datos['stats']) {
      switch (elemento['stat']['name']) {
        case 'hp':
          salud = elemento['base_stat'] ?? 0;
          break;
        case 'attack':
          numeroDeAtaques = elemento['base_stat'];
          break;
      }
    }
  }
  
  get lista => null;
  
  get http => null;

  obtenerPokemon(String nombre) async {
    Uri url = Uri.parse("https://pokeapi.co/api/v2/pokemon/$nombre");
    var respuesta = await http.get(url);
    try {
      if (respuesta.statusCode == 200) {
        var body = json.decode(respuesta.body);
        Pokemon pokemon = Pokemon.fromAPI(body, lista);
        return pokemon;
      } else if (respuesta.statusCode == 404) {
        throw ("El pokemon que buscas no existe!");
      } else throw ("Ha habido un error de conexión");
    } catch (e) {
      stdout.writeln(e);
    }
  }

  static imprimirInfo(Pokemon pokemon) {
    stdout.writeln("Nombre: ${pokemon.nombre}");
    stdout.writeln(
        "Nivel: ${pokemon.salud + pokemon.numeroDeAtaques}");
    stdout.writeln("Estadísticas:");
    stdout.writeln("    Vida:             ${pokemon.salud}");
    stdout.writeln("    Ataque:           ${pokemon.numeroDeAtaques}");
}
}