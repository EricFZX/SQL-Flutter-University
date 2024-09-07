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
          return ListView.builder(
            itemCount: _branches.length,
            itemBuilder: (context, index) {
              dynamic branch = _branches[index];
              return ListTile(
                  title: Text(
                    branch["_nombre"],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      "${branch["_departamento"]}, ${branch["_ciudad"]}"),
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
