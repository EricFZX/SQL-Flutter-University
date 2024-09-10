import 'package:bd_project/c/api.dart';
import 'package:flutter/material.dart';

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
          return ListView.builder(
            itemCount: _careers.length,
            itemBuilder: (context, index) {
              dynamic career = _careers[index];
              return ListTile(
                  title: Text(
                    career["_nombre"],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      "Codigo:${career["_codigoCarrera"]}\nUV:${career["_UV"]}"),
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