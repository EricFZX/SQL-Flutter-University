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

  static Future<dynamic> getSubjects() async {
    try {
      final response =
          await http.get(Uri.parse("http://10.0.2.2:3000/subjects"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw "Error";
      }
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

  static Future<void> postSubjectCareer(codigoCarrera, codigoAsignatura) async {
    final response = await http.post(
        Uri.parse("http://10.0.2.2:3000/subjects/career"),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
        body: jsonEncode({
          "_codigoCarrera": codigoCarrera,
          "_codigoAsignatura": codigoAsignatura
        }));
    if (response.statusCode == 200) {}
  }

  static Future<dynamic> getSubjectsCareerNO(codigoAsignatura) async {
    try {
      final response = await http.get(
          Uri.parse("http://10.0.2.2:3000/subjects/career/$codigoAsignatura"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw "Error";
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> getCareers() async {
    try {
      final response =
          await http.get(Uri.parse("http://10.0.2.2:3000/careers"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw "Error";
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> postCareer(nombre, uv) async {
    try {
      final response =
          await http.post(Uri.parse("http://10.0.2.2:3000/careers"),
              headers: {
                "Content-Type": "application/json; charset=utf-8",
              },
              body: jsonEncode({"_nombre": nombre, "_UV": uv}));
      if (response.statusCode == 200) {}
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> getCareersBranchNO(codigoCarrera) async {
    try {
      final response = await http
          .get(Uri.parse("http://10.0.2.2:3000/careers/branch/$codigoCarrera"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw "Error";
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> postCareerBranch(codigoCarrera, codigoSucursal) async {
    try {
      final response = await http.post(
          Uri.parse("http://10.0.2.2:3000/careers/branch"),
          headers: {
            "Content-Type": "application/json; charset=utf-8",
          },
          body: jsonEncode({
            "_codigoSucursal": codigoSucursal,
            "_codigoCarrera": codigoCarrera
          }));
      if (response.statusCode == 200) {}
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> getSectionsInfo() async {
    try {
      final response =
          await http.get(Uri.parse("http://10.0.2.2:3000/sections"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> branchTeacher(codigoSucursal) async {
    try {
      final response = await http.get(
          Uri.parse("http://10.0.2.2:3000/teachers/branch/$codigoSucursal"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> branchSubject(codigoSucursal) async {
    try {
      final response = await http.get(
          Uri.parse("http://10.0.2.2:3000/subjects/branch/$codigoSucursal"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> postSection(
      codigoAsignatura, codigoDocente, cupos) async {
    try {
      final response =
          await http.post(Uri.parse("http://10.0.2.2:3000/sections"),
              headers: {
                "Content-Type": "application/json; charset=utf-8",
              },
              body: jsonEncode({
                "_codigoAsignatura": codigoAsignatura,
                "_codigoDocente": codigoDocente,
                "_cupos": cupos
              }));
      if (response.statusCode == 200) {}
    } catch (e) {
      rethrow;
    }
  }
  static Future<dynamic> branchStudent(codigoSucursal) async {
    try {
      final response = await http.get(
          Uri.parse("http://10.0.2.2:3000/students/branch/$codigoSucursal"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }
}
