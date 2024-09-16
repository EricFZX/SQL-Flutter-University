import 'package:bd_project/c/api.dart';
import 'package:bd_project/v/Careers/create_careers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListCareers extends StatefulWidget {
  const ListCareers({super.key});

  @override
  State<ListCareers> createState() => _ListCareersState();
}

class _ListCareersState extends State<ListCareers> {
  //Variables
  List<dynamic> _careers = [];
  @override
  Widget build(BuildContext context) {
    Future<void> deleteDialog(codigoCarrera) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("¿Eliminar Registro?"),
            actions: [
              TextButton(
                  onPressed: () async {
                    await API.deleteCareer(codigoCarrera);
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

    return Scaffold(
      body: FutureBuilder(
        future: API.getCareers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _careers = snapshot.data;
          }
          return SingleChildScrollView(
              child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text("Codigo Carrera")),
                DataColumn(label: Text("Nombre")),
                DataColumn(label: Text("U.V")),
                DataColumn(label: Text("Año Carrera")),
                DataColumn(label: Text("Acciones"))
              ],
              rows: _careers.map((row) {
                DateTime dateTime = DateTime.parse(row['_añoCarrera']);

                String date = DateFormat('yyyy-MM-dd').format(dateTime);

                return DataRow(cells: [
                  DataCell(Text(row['_codigoCarrera'].toString())),
                  DataCell(Text(row['_nombre'])),
                  DataCell(Text(row['_UV'].toString())),
                  DataCell(Text(date)),
                  DataCell(Row(
                    children: [
                      GestureDetector(
                        onTap: () => deleteDialog(row['_codigoCarrera']),
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
                                  builder: (context) => CreateCareers(
                                        edit: true,
                                        career: row,
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
