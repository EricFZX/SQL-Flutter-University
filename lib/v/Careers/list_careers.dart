import 'package:bd_project/c/api.dart';
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
              ],
              rows: _careers.map((row) {
                DateTime dateTime = DateTime.parse(row['_añoCarrera']);

                String date = DateFormat('yyyy-MM-dd').format(dateTime);

                return DataRow(cells: [
                  DataCell(Text(row['_codigoCarrera'].toString())),
                  DataCell(Text(row['_nombre'])),
                  DataCell(Text(row['_UV'].toString())),
                  DataCell(Text(date)),
                ]);
              }).toList(),
            ),
          ));
        },
      ),
    );
  }
}
