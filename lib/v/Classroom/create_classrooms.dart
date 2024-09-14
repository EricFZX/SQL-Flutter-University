import 'package:bd_project/c/api.dart';
import 'package:flutter/material.dart';

class CreateClassrooms extends StatefulWidget {
  const CreateClassrooms({super.key, required this.edit, required this.onTap});
  final bool edit;
  final Function onTap;
  @override
  State<CreateClassrooms> createState() => _CreateClassroomsState();
}

class _CreateClassroomsState extends State<CreateClassrooms> {
  //Variables
  List<dynamic> _branches = [];
  late int _selectedBranche;
  final TextEditingController _cupos = TextEditingController();
  //Methods
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
            height: 300,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                      TextFormField(
                        controller: _cupos,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Capacidad de Cupos",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 160, 160, 147)),
                        ),
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
                    API.postClassroom(_selectedBranche, _cupos.text);
                    widget.onTap(18, pop: false);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      widget.edit ? "EDITAR AULA" : "CREAR AULA",
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
