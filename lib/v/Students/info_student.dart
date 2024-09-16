import 'package:bd_project/c/api.dart';
import 'package:flutter/material.dart';

class InfoStudent extends StatefulWidget {
  const InfoStudent({super.key, required this.codigoAlumno});
  final int codigoAlumno;
  @override
  State<InfoStudent> createState() => _InfoStudentState();
}

class _InfoStudentState extends State<InfoStudent> {
  //Variables
  List<dynamic> _sections = [];
  final TextEditingController _score = TextEditingController();
  //Method
  Future<void> updateScore(codigoSeccion) async {
    _score.clear();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "ASIGNAR NOTA",
            textAlign: TextAlign.center,
          ),
          content: TextField(
            controller: _score,
            decoration: const InputDecoration(hintText: "Ingresar nota"),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  await API.patchScore(
                      widget.codigoAlumno, codigoSeccion, _score.text);
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
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              "images/logo_blanco.png",
              width: 150,
            )
          ],
        ),
      ),
      body: FutureBuilder(
        future: API.getInfoSectionsStudent(widget.codigoAlumno),
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
                DataColumn(label: Text("Nota")),
                DataColumn(label: Text("Acciones"))
              ],
              rows: _sections.map((row) {
                return DataRow(cells: [
                  DataCell(Text(row['_codigoSeccion'].toString())),
                  DataCell(Text(row['_nombre'])),
                  DataCell(Text(
                      row['_nota'] == null ? "N/A" : row['_nota'].toString())),
                  DataCell(GestureDetector(
                    onTap: () => updateScore(row['_codigoSeccion']),
                    child: const Icon(Icons.edit),
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
