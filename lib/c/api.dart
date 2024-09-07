import 'dart:convert';

import 'package:http/http.dart' as http;

class API {
  static Future<dynamic> getStudents() async {
    try {
      final response =
          await http.get(Uri.parse("http://10.0.2.2:3000/students"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw "Error";
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> postStudent(
      String dni, fName, sName, fLastname, sLastname, branch) async {
    try {
      var response = await http.post(Uri.parse("http://10.0.2.2:3000/students"),
          headers: {
            "Content-Type": "application/json; charset=utf-8",
          },
          body: json.encode(
            {
              "_DNI": dni,
              "_primerNombre": fName,
              "_segundoNombre": sName,
              "_primerApellido": fLastname,
              "_segundoApellido": sLastname,
              "_codigoSucursal": branch.toString(),
            },
          ));
      if (response.statusCode == 200) {}
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> getTeachers() async {
    try {
      final response =
          await http.get(Uri.parse("http://10.0.2.2:3000/teachers"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw "Error";
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> postTeacher(
      String dni, fName, sName, fLastname, sLastname, salario, branch) async {
    try {
      var response = await http.post(Uri.parse("http://10.0.2.2:3000/teachers"),
          headers: {
            "Content-Type": "application/json; charset=utf-8",
          },
          body: json.encode(
            {
              "_DNI": dni,
              "_primerNombre": fName,
              "_segundoNombre": sName,
              "_primerApellido": fLastname,
              "_segundoApellido": sLastname,
              "_salario": salario,
              "_codigoSucursal": branch.toString(),
            },
          ));
      if (response.statusCode == 200) {}
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> getBranches() async {
    try {
      final response =
          await http.get(Uri.parse("http://10.0.2.2:3000/branches"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw "Error";
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> postBranche(nombre, departamento, ciudad, calle) async {
    try {
      final response =
          await http.post(Uri.parse("http://10.0.2.2:3000/branches"),
              headers: {
                "Content-Type": "application/json; charset=utf-8",
              },
              body: json.encode({
                "_nombre": nombre,
                "_departamento": departamento,
                "_ciudad": ciudad,
                "_calle": calle
              }));
      if (response.statusCode == 200) {}
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> postSubject(nombre, uv) async {
    final response = await http.post(Uri.parse("http://10.0.2.2:3000/subjects"),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
        body: jsonEncode({"_nombre": nombre, "_UV": uv}));
    if (response.statusCode == 200) {}
  }
}
