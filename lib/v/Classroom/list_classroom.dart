import 'package:bd_project/c/api.dart';
import 'package:flutter/material.dart';

class ListClassroom extends StatefulWidget {
  const ListClassroom({super.key});

  @override
  State<ListClassroom> createState() => _ListClassroomState();
}

class _ListClassroomState extends State<ListClassroom> {
  //Variables
  List<dynamic> _classrooms = [];
  Future<void> deleteDialog(codigoAula) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("¿Eliminar Registro?"),
          actions: [
            TextButton(
                onPressed: () async {
                  await API.deleteClassroom(codigoAula);
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
        future: API.getClassrooms(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _classrooms = snapshot.data;
          }

          return SingleChildScrollView(
              child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text("Codigo Aula")),
                DataColumn(label: Text("Sucursal")),
                DataColumn(label: Text("Cupos")),
                DataColumn(label: Text("Acciones")),
              ],
              rows: _classrooms.map((row) {
                return DataRow(cells: [
                  DataCell(Text(row['_codigoAula'].toString())),
                  DataCell(Text(row['_nombre'])),
                  DataCell(Text(row['_cupos'].toString())),
                  DataCell(Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            deleteDialog(row['_codigoAula']);
                          },
                          icon: const Icon(Icons.delete))
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
