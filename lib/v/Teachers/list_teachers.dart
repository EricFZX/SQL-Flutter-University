import 'package:bd_project/c/api.dart';
import 'package:flutter/material.dart';

class ListTeachers extends StatefulWidget {
  const ListTeachers({super.key});

  @override
  State<ListTeachers> createState() => _ListTeachersState();
}

class _ListTeachersState extends State<ListTeachers> {
  //Variables
  List<dynamic> teachers = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: FutureBuilder(
        future: API.getTeachers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            teachers = snapshot.data;
          }
          return ListView.builder(
            itemCount: teachers.length,
            itemBuilder: (context, index) {
              dynamic teacher = teachers[index];
              return ListTile(
                  title: Text(
                    "${teacher["_primerNombre"]} ${teacher["_primerApellido"]}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Codigo: ${teacher["_codigoDocente"]}"),
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
      ),);
  }
}