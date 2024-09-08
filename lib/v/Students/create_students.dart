import 'package:bd_project/c/api.dart';
import 'package:flutter/material.dart';

class CreateStudents extends StatefulWidget {
  const CreateStudents({super.key, required this.edit});
  final bool edit;
  @override
  State<CreateStudents> createState() => _CreateStudentsState();
}

class _CreateStudentsState extends State<CreateStudents> {
  //Variables
  final TextEditingController _fName = TextEditingController();
  final TextEditingController _sName = TextEditingController();
  final TextEditingController _fLastname = TextEditingController();
  final TextEditingController _sLastname = TextEditingController();
  final TextEditingController _dni = TextEditingController();
  List<dynamic> _branches = [];
  int _selectedBranche = 0;

  //Methods
  Future<void> _getBranches() async {
    final json = await API.getBranches();
    setState(() {
      _branches = json;
    });
  }

  @override
  void initState() {
    _getBranches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFededeb),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height / 1.4,
            padding: const EdgeInsets.all(20),
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
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
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _dni,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "DNI",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 160, 160, 147)),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _fName,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "P.Nombre",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 160, 160, 147)),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _sName,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "S.Nombre",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 160, 160, 147)),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _fLastname,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "P.Apellido",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 160, 160, 147)),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _sLastname,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "S.Apellido",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 160, 160, 147)),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      DropdownButtonFormField<Map<String, dynamic>>(
                        isExpanded: true,
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                        items: _branches.map((sucursal) {
                          return DropdownMenuItem<Map<String, dynamic>>(
                            value: sucursal,
                            child: Text(sucursal['_nombre']),
                          );
                        }).toList(),
                        onChanged: (Map<String, dynamic>? selectedSucursal) {
                          setState(() {
                            _selectedBranche =
                                selectedSucursal?['_codigoSucursal'];
                          });
                        },
                        hint: const Text('Selecciona una sucursal'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                )),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () async {
                    API
                        .postStudent(_dni.text, _fName.text, _sName.text,
                            _fLastname.text, _sLastname.text, _selectedBranche)
                        .then((_) {
                      if (!context.mounted) return;
                      Navigator.pop(context);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      widget.edit ? "EDITAR ALUMNO" : "CREAR ALUMNO",
                      style: const TextStyle(
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
