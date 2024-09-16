import 'package:bd_project/c/api.dart';
import 'package:bd_project/v/Subjects/create_subjects.dart';
import 'package:flutter/material.dart';

class ListSubjects extends StatefulWidget {
  const ListSubjects({super.key});

  @override
  State<ListSubjects> createState() => _ListSubjectsState();
}

class _ListSubjectsState extends State<ListSubjects> {
  //Variables
  List<dynamic> _subjects = [];

  Future<void> deleteDialog(codigoAsignatura) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("¿Eliminar Registro?"),
          actions: [
            TextButton(
                onPressed: () async {
                  await API.deleteSubject(codigoAsignatura);
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

  void updateState() {
    setState(() {});
  }

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
                DataColumn(label: Text("Acciones"))
              ],
              rows: _subjects.map((row) {
                return DataRow(cells: [
                  DataCell(Text(row['_codigoAsignatura'].toString())),
                  DataCell(Text(row['_nombre'])),
                  DataCell(Text(row['_UV'].toString())),
                  DataCell(Row(
                    children: [
                      GestureDetector(
                        onTap: () => deleteDialog(row['_codigoAsignatura']),
                        child: const Icon(Icons.delete),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateSubjects(
                                        edit: true,
                                        subject: row,
                                        updateState: updateState,
                                      )));
                        },
                        child: const Icon(Icons.edit),
                      ),
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
