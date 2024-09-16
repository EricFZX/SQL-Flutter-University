import 'package:bd_project/c/api.dart';
import 'package:bd_project/v/Teachers/create_teachers.dart';
import 'package:flutter/material.dart';

class ListTeachers extends StatefulWidget {
  const ListTeachers({super.key});

  @override
  State<ListTeachers> createState() => _ListTeachersState();
}

class _ListTeachersState extends State<ListTeachers> {
  //Variables
  List<dynamic> _teachers = [];
  final TextEditingController _cellphone = TextEditingController();

  Future<void> deleteDialog(codigoDocente) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("¿Eliminar Registro?"),
          actions: [
            TextButton(
                onPressed: () async {
                  await API.deleteTeacher(codigoDocente);
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

  Future<void> addCellphone(codigoDocente) async {
    _cellphone.clear();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "AGREGAR TELEFONO",
            textAlign: TextAlign.center,
          ),
          content: TextField(
            controller: _cellphone,
            decoration: const InputDecoration(hintText: "Nm.Telefono"),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  await API.postCellphoneTeacher(codigoDocente, _cellphone.text);
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

  Future<void> cellPhonesDialog(codigoDocente) async {
    final json = await API.getTeacherCellphone(codigoDocente);
    List<dynamic> cellphones = [];
    setState(() {
      cellphones = json;
    });
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Telefonos",
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: ListView.builder(
              itemCount: cellphones.length,
              itemBuilder: (context, index) {
                dynamic cellphone = cellphones[index];
                index++;
                return ListTile(
                  title: Text("$index.${cellphone['_numero']}"),
                );
              },
            ),
          ),
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
                DataColumn(label: Text("Telefonos")),
                DataColumn(label: Text("Acciones"))
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
                  DataCell(Row(
                    children: [
                      GestureDetector(
                        onTap: () => cellPhonesDialog(row['_codigoDocente']),
                        child: const Icon(Icons.remove_red_eye),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () => addCellphone(row['_codigoDocente']),
                        child: const Icon(Icons.add),
                      )
                    ],
                  )),
                  DataCell(Row(
                    children: [
                      GestureDetector(
                        onTap: () => deleteDialog(row['_codigoDocente']),
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
                                  builder: (context) => CreateTeachers(
                                        edit: true,
                                        teacher: row,
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
