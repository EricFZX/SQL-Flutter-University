import 'package:bd_project/c/api.dart';
import 'package:flutter/material.dart';

class ListStudents extends StatefulWidget {
  const ListStudents({super.key});

  @override
  State<ListStudents> createState() => _ListStudentsState();
}

class _ListStudentsState extends State<ListStudents> {
  //Variables
  List<dynamic> students = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: API.getStudents(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            students = snapshot.data;
          }
          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              dynamic student = students[index];
              return ListTile(
                  title: Text(
                    "${student["_primerNombre"]} ${student["_primerApellido"]}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Codigo: ${student["_codigoAlumno"]}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        child: const Icon(Icons.delete),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        child: const Icon(Icons.arrow_forward_ios),
                      )
                    ],
                  ));
            },
          );
        },
      ),
    );
  }
}
