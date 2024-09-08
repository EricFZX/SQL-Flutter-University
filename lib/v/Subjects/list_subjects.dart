import 'package:bd_project/c/api.dart';
import 'package:flutter/material.dart';

class ListSubjects extends StatefulWidget {
  const ListSubjects({super.key});

  @override
  State<ListSubjects> createState() => _ListSubjectsState();
}

class _ListSubjectsState extends State<ListSubjects> {
  //Variables
  List <dynamic> _subjects = [];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: API.getSubjects(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _subjects = snapshot.data;
          }
          return ListView.builder(
            itemCount: _subjects.length,
            itemBuilder: (context, index) {
              dynamic subject = _subjects[index];
              return ListTile(
                  title: Text(
                    subject["_nombre"],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      "Codigo:${subject["_codigoAsignatura"]}\nUV:${subject["_UV"]}"),
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