import 'package:bd_project/c/api.dart';
import 'package:flutter/material.dart';

class ListSubjects extends StatefulWidget {
  const ListSubjects({super.key});

  @override
  State<ListSubjects> createState() => _ListSubjectsState();
}

class _ListSubjectsState extends State<ListSubjects> {
  //Variables
  List<dynamic> _subjects = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: API.getSubjects(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _subjects = snapshot.data;
          }
          return SingleChildScrollView(
              child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text("Codigo Asignatura")),
                DataColumn(label: Text("Nombre")),
                DataColumn(label: Text("U.V")),
              ],
              rows: _subjects.map((row) {
                return DataRow(cells: [
                  DataCell(Text(row['_codigoAsignatura'].toString())),
                  DataCell(Text(row['_nombre'])),
                  DataCell(Text(row['_UV'].toString())),
                ]);
              }).toList(),
            ),
          ));
        },
      ),
    );
  }
}
