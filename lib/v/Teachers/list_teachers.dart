import 'package:bd_project/c/api.dart';
import 'package:flutter/material.dart';

class ListTeachers extends StatefulWidget {
  const ListTeachers({super.key});

  @override
  State<ListTeachers> createState() => _ListTeachersState();
}

class _ListTeachersState extends State<ListTeachers> {
  //Variables
  List<dynamic> _teachers = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: API.getTeachers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _teachers = snapshot.data;
          }
          return SingleChildScrollView(
              child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text("Codigo Docente")),
                DataColumn(label: Text("DNI")),
                DataColumn(label: Text("P.Nombre")),
                DataColumn(label: Text("S.Nombre")),
                DataColumn(label: Text("P.Apellido")),
                DataColumn(label: Text("S.Apellido")),
                DataColumn(label: Text("Salario")),

              ],
              rows: _teachers.map((row) {
                return DataRow(cells: [
                  DataCell(Text(row['_codigoDocente'].toString())),
                  DataCell(Text(row['_DNI'])),
                  DataCell(Text(row['_primerNombre'])),
                  DataCell(Text(row['_segundoNombre'])),
                  DataCell(Text(row['_primerApellido'])),
                  DataCell(Text(row['_segundoApellido'])),
                  DataCell(Text(row['_salario'].toString())),
                ]);
              }).toList(),
            ),
          ));
        },
      ),
    );
  }
}
