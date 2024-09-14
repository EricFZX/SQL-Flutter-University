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

  Future<void> deleteDialog(codigoSucursal) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("¿Eliminar Registro?"),
          actions: [
            TextButton(
                onPressed: () async {
                  await API.deleteBranch(codigoSucursal);
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
                DataColumn(label: Text("Calle")),
                DataColumn(label: Text("Acciones"))
              ],
              rows: _branches.map((row) {
                return DataRow(cells: [
                  DataCell(Text(row['_codigoSucursal'].toString())),
                  DataCell(Text(row['_nombre'])),
                  DataCell(Text(row['_departamento'])),
                  DataCell(Text(row['_ciudad'])),
                  DataCell(Text(row['_calle'])),
                  DataCell(Row(
                    children: [
                      GestureDetector(
                        onTap: () => deleteDialog(row['_codigoSucursal']),
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
