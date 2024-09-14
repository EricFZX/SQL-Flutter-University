import 'package:bd_project/c/api.dart';
import 'package:flutter/material.dart';

class EnrollStudents extends StatefulWidget {
  const EnrollStudents({super.key});

  @override
  State<EnrollStudents> createState() => _EnrollStudentsState();
}

class _EnrollStudentsState extends State<EnrollStudents> {
  //Variables
  List<dynamic> _branches = [];
  List<dynamic> _students = [];

  Future<void> _getBranches() async {
    final json = await API.getBranches();
    setState(() {
      _branches = json;
    });
  }

  @override
  void initState() {
    super.initState();
    _getBranches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFededeb),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Container(
            height: 400,
            padding: const EdgeInsets.all(20),
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "FORMULARIO",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(children: [
                    DropdownButtonFormField<Map<String, dynamic>>(
                      isExpanded: true,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      items: _branches.map((branch) {
                        return DropdownMenuItem<Map<String, dynamic>>(
                          value: branch,
                          child: Text(
                            branch['_nombre'],
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: (Map<String, dynamic>? selectedBranche) async {
                        final jsonStudent = await API
                            .branchStudent(selectedBranche?['_codigoSucursal']);
                        setState(() {
                          _students = jsonStudent;
                        });
                      },
                      hint: const Text('Seleccione una sucursal'),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ]),
                )),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () async {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      "Matricular Carrera",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
