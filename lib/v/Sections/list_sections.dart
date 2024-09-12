import 'package:bd_project/c/api.dart';
import 'package:flutter/material.dart';

class ListSections extends StatefulWidget {
  const ListSections({super.key});

  @override
  State<ListSections> createState() => _ListSectionsState();
}

class _ListSectionsState extends State<ListSections> {
  //Variables
  List<dynamic> _sections = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: API.getSectionsInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _sections = snapshot.data;
          }

          return SingleChildScrollView(
              child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text("Codigo Seccion")),
                DataColumn(label: Text("Asignatura")),
                DataColumn(label: Text("UV")),
                DataColumn(label: Text("Cupos Disponibles")),
                DataColumn(label: Text("Docente")),
                DataColumn(label: Text("Acciones"))
              ],
              rows: _sections.map((row) {
                return DataRow(cells: [
                  DataCell(Text(row['_codigoSeccion'].toString())),
                  DataCell(Text(row['_nombre'])),
                  DataCell(Text(row['_UV'].toString())),
                  DataCell(Text(row['_cupos'].toString())),
                  DataCell(Text(row['Docente'])),
                  DataCell(Row(
                    children: [
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.delete))
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
