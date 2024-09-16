import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toastification/toastification.dart';

class API {
  static void toastError() {
    toastification.show(
      title: const Text('¡Error!'),
      type: ToastificationType.error,
      style: ToastificationStyle.flat,
      alignment: Alignment.topRight,
      description: const Text("¡Error de clave foranea!"),
      autoCloseDuration: const Duration(seconds: 5),
    );
  }

  static void toastSucces() {
    toastification.show(
      title: const Text('¡Satisfactorio!'),
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      alignment: Alignment.topRight,
      description: const Text("¡Accion realizada correctamente!"),
      autoCloseDuration: const Duration(seconds: 5),
    );
  }

  //Get Methods
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

  static Future<dynamic> getSections() async {
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

  static Future<dynamic> getClassrooms() async {
    try {
      final response =
          await http.get(Uri.parse("http://10.0.2.2:3000/classrooms"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  //Post Methods
  static Future<void> postStudentSection(codigoAlumno, codigoSeccion) async {
    try {
      var response =
          await http.post(Uri.parse("http://10.0.2.2:3000/sections/students"),
              headers: {
                "Content-Type": "application/json; charset=utf-8",
              },
              body: json.encode(
                {
                  "_codigoAlumno": codigoAlumno,
                  "_codigoSeccion": codigoSeccion,
                },
              ));
      if (response.statusCode == 200) {
        toastSucces();
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
      if (response.statusCode == 200) {
        toastSucces();
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
      if (response.statusCode == 200) {
        toastSucces();
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> postBranch(nombre, departamento, ciudad, calle) async {
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
      if (response.statusCode == 200) {
        toastSucces();
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
    if (response.statusCode == 200) {
      toastSucces();
    }
  }

  static Future<dynamic> postSection(
      codigoAsignatura, codigoDocente, codigoAula) async {
    try {
      final response =
          await http.post(Uri.parse("http://10.0.2.2:3000/sections"),
              headers: {
                "Content-Type": "application/json; charset=utf-8",
              },
              body: jsonEncode({
                "_codigoAsignatura": codigoAsignatura,
                "_codigoDocente": codigoDocente,
                "_codigoAula": codigoAula
              }));
      if (response.statusCode == 200) {
        toastSucces();
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
      if (response.statusCode == 200) {
        toastSucces();
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> postClassroom(codigoSucursal, cupos) async {
    try {
      final response = await http.post(
          Uri.parse("http://10.0.2.2:3000/classrooms"),
          headers: {
            "Content-Type": "application/json; charset=utf-8",
          },
          body:
              jsonEncode({"_codigoSucursal": codigoSucursal, "_cupos": cupos}));
      if (response.statusCode == 200) {
        toastSucces();
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> postStudentCareer(codigoCarrera, codigoAlumno) async {
    try {
      var response =
          await http.post(Uri.parse("http://10.0.2.2:3000/students/career"),
              headers: {
                "Content-Type": "application/json; charset=utf-8",
              },
              body: json.encode(
                {
                  "_codigoCarrera": codigoCarrera.toString(),
                  "_codigoAlumno": codigoAlumno.toString(),
                },
              ));
      if (response.statusCode == 200) {
        toastSucces();
      }
    } catch (e) {
      rethrow;
    }
  }

  //Delete Methods
  static Future<dynamic> deleteBranch(codigoSucursal) async {
    try {
      final response = await http
          .delete(Uri.parse("http://10.0.2.2:3000/branches/$codigoSucursal"));
      if (response.statusCode == 200) {
        toastSucces();
      } else if (response.statusCode == 500) {
        toastError();
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> deleteStudent(codigoAlumno) async {
    try {
      final response = await http
          .delete(Uri.parse("http://10.0.2.2:3000/students/$codigoAlumno"));
      if (response.statusCode == 200) {
        toastSucces();
      } else if (response.statusCode == 500) {
        toastError();
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> deleteTeacher(codigoDocente) async {
    try {
      final response = await http
          .delete(Uri.parse("http://10.0.2.2:3000/teachers/$codigoDocente"));
      if (response.statusCode == 200) {
        toastSucces();
      } else if (response.statusCode == 500) {
        toastError();
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> deleteSubject(codigoAsignatura) async {
    try {
      final response = await http
          .delete(Uri.parse("http://10.0.2.2:3000/subjects/$codigoAsignatura"));
      if (response.statusCode == 200) {
        toastSucces();
      } else if (response.statusCode == 500) {
        toastError();
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> deleteCareer(codigoCarrera) async {
    try {
      final response = await http
          .delete(Uri.parse("http://10.0.2.2:3000/careers/$codigoCarrera"));
      if (response.statusCode == 200) {
        toastSucces();
      } else if (response.statusCode == 500) {
        toastError();
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> deleteClassroom(codigoAula) async {
    try {
      final response = await http
          .delete(Uri.parse("http://10.0.2.2:3000/classrooms/$codigoAula"));
      if (response.statusCode == 200) {
        toastSucces();
      } else if (response.statusCode == 500) {
        toastError();
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> deleteSection(codigoSeccion) async {
    try {
      final response = await http
          .delete(Uri.parse("http://10.0.2.2:3000/sections/$codigoSeccion"));
      if (response.statusCode == 200) {
        toastSucces();
      } else if (response.statusCode == 500) {
        toastError();
      }
    } catch (e) {
      rethrow;
    }
  }

  //SubQuerys or Intermediate Tables
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
    if (response.statusCode == 200) {
      toastSucces();
    }
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
      if (response.statusCode == 200) {
        toastSucces();
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

  static Future<dynamic> branchClassroom(codigoSucursal) async {
    try {
      final response = await http.get(
          Uri.parse("http://10.0.2.2:3000/classroom/branch/$codigoSucursal"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> careerStudentNo(codigoAlumno, codigoSucursal) async {
    try {
      final response = await http.get(Uri.parse(
          "http://10.0.2.2:3000/careers/student/branch/$codigoAlumno/$codigoSucursal"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> studentSectionNO(codigoAlumno, codigoSucursal) async {
    try {
      final response = await http.get(Uri.parse(
          "http://10.0.2.2:3000/section/student/$codigoSucursal/$codigoAlumno"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> getInfoSectionsStudent(codigoAlumno) async {
    try {
      final response = await http
          .get(Uri.parse("http://10.0.2.2:3000/section/student/$codigoAlumno"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw "Error";
      }
    } catch (e) {
      rethrow;
    }
  }

  //Update
  static Future<void> patchScore(codigoAlumno, codigoSeccion, nota) async {
    try {
      var response = await http.patch(
          Uri.parse("http://10.0.2.2:3000/section/$codigoAlumno"),
          headers: {
            "Content-Type": "application/json; charset=utf-8",
          },
          body: json.encode(
            {
              "_codigoSeccion": codigoSeccion.toString(),
              "_nota": nota.toString()
            },
          ));
      if (response.statusCode == 200) {
        toastSucces();
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> patchBranch(
      codigoSucursal, nombre, departamento, ciudad, calle) async {
    try {
      var response = await http.patch(
          Uri.parse("http://10.0.2.2:3000/branches/$codigoSucursal"),
          headers: {
            "Content-Type": "application/json; charset=utf-8",
          },
          body: json.encode({
            "_nombre": nombre,
            "_departamento": departamento,
            "_ciudad": ciudad,
            "_calle": calle
          }));
      if (response.statusCode == 200) {
        toastSucces();
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> patchStudent(codigoAlumno, String dni, fName, sName,
      fLastname, sLastname, branch) async {
    try {
      var response = await http.patch(
          Uri.parse("http://10.0.2.2:3000/students/$codigoAlumno"),
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
      if (response.statusCode == 200) {
        toastSucces();
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> patchTeacher(codigoDocente, String dni, fName, sName,
      fLastname, sLastname, salario, branch) async {
    try {
      var response = await http.patch(
          Uri.parse("http://10.0.2.2:3000/teachers/$codigoDocente"),
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
      if (response.statusCode == 200) {
        toastSucces();
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> patchSubject(codigoAsignatura, nombre, uv) async {
    final response = await http.patch(
        Uri.parse("http://10.0.2.2:3000/subjects/$codigoAsignatura"),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
        body: jsonEncode({"_nombre": nombre, "_UV": uv}));
    if (response.statusCode == 200) {
      toastSucces();
    }
  }

  static Future<dynamic> patchCareer(codigoCarrera, nombre, uv) async {
    try {
      final response = await http.patch(
          Uri.parse("http://10.0.2.2:3000/careers/$codigoCarrera"),
          headers: {
            "Content-Type": "application/json; charset=utf-8",
          },
          body: jsonEncode({"_nombre": nombre, "_UV": uv}));
      if (response.statusCode == 200) {
        toastSucces();
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> patchClassroom(codigoAula, cupos) async {
    try {
      final response = await http.patch(
          Uri.parse("http://10.0.2.2:3000/classrooms/$codigoAula"),
          headers: {
            "Content-Type": "application/json; charset=utf-8",
          },
          body: jsonEncode({"_cupos": cupos}));
      if (response.statusCode == 200) {
        toastSucces();
      }
    } catch (e) {
      rethrow;
    }
  }
}
