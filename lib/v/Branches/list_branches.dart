import 'package:bd_project/c/api.dart';
import 'package:flutter/material.dart';

class ListBranches extends StatefulWidget {
  const ListBranches({super.key});

  @override
  State<ListBranches> createState() => _ListBranchesState();
}

class _ListBranchesState extends State<ListBranches> {
  //Variables
  List<dynamic> _branches = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: API.getBranches(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _branches = snapshot.data;
          }
          return SingleChildScrollView(
              child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text("Codigo Sucursal")),
                DataColumn(label: Text("Nombre")),
                DataColumn(label: Text("Departamento")),
                DataColumn(label: Text("Ciudad")),
                DataColumn(label: Text("Calle"))
              ],
              rows: _branches.map((row) {
                return DataRow(cells: [
                  DataCell(Text(row['_codigoSucursal'].toString())),
                  DataCell(Text(row['_nombre'])),
                  DataCell(Text(row['_departamento'])),
                  DataCell(Text(row['_ciudad'])),
                  DataCell(Text(row['_calle'])),
                ]);
              }).toList(),
            ),
          ));
        },
      ),
    );
  }
}
