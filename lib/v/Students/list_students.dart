import 'package:bd_project/c/api.dart';
import 'package:flutter/material.dart';

class ListStudents extends StatefulWidget {
  const ListStudents({super.key});

  @override
  State<ListStudents> createState() => _ListStudentsState();
}

class _ListStudentsState extends State<ListStudents> {
  //Variables
  List<dynamic> _students = [];

  Future<void> deleteDialog(codigoAlumno) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("¿Eliminar Registro?"),
          actions: [
            TextButton(
                onPressed: () async {
                  await API.deleteStudent(codigoAlumno);
                  setState(() {});
                  Navigator.pop(context);
                },
                child: const Text("Aceptar")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancelar"))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: API.getStudents(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _students = snapshot.data;
          }
          return SingleChildScrollView(
              child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text("Codigo Alumno")),
                DataColumn(label: Text("DNI")),
                DataColumn(label: Text("P.Nombre")),
                DataColumn(label: Text("S.Nombre")),
                DataColumn(label: Text("P.Apellido")),
                DataColumn(label: Text("S.Apellido")),
                DataColumn(label: Text("Acciones"))
              ],
              rows: _students.map((row) {
                return DataRow(cells: [
                  DataCell(Text(row['_codigoAlumno'].toString())),
                  DataCell(Text(row['_DNI'])),
                  DataCell(Text(row['_primerNombre'])),
                  DataCell(Text(row['_segundoNombre'])),
                  DataCell(Text(row['_primerApellido'])),
                  DataCell(Text(row['_segundoApellido'])),
                  DataCell(Row(
                    children: [
                      GestureDetector(
                        onTap: () => deleteDialog(row['_codigoAlumno']),
                        child: const Icon(Icons.delete),
                      )
                    ],
                  ))
                ]);
              }).toList(),
            ),
          ));
        },
      ),
    );
  }
}
