import 'baseDeDatosproyecto.dart';
import 'dart:io';
class Usuario {
  String _user ="carlos";
  String _password = "1wdf5d4";
  String get user => _user;
  String get password => _password;
  
  set user(String user){
    _user = user;
  }
  set password(String password){
    _password = password;
  }

 static Future<bool> comprobarSiExiste(String nombre) async {
    bool existe = true;
    var conn;
    try {
      conn = await DataBase.obtenerConexion();
      var registros =
          await conn.query("SELECT * FROM usuarios WHERE nombre = ?", [nombre]);
      if (registros.length == 0) {
        existe = false;
      }
    } catch (e) {
      print(e);
    } finally {
      conn.close();
    }
    return existe;
  }

  Future<bool> save() async {
    bool guardado = false;
    var conn;
    try {
      conn = await DataBase.obtenerConexion();
      await conn.query("INSERT INTO usuarios (nombre,password) VALUES(?,?)",
          [user, password]);
      stdout.writeln("Usuario insertado con éxito");
      guardado = true;
    } catch (e) {
      print(e);
    } finally {
      conn.close();
    }
    return guardado;
  }
}
