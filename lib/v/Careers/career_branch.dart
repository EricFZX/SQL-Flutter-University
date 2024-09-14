import 'package:bd_project/c/api.dart';
import 'package:flutter/material.dart';

class CareerBranche extends StatefulWidget {
  const CareerBranche({super.key, required this.onTap});
  final Function onTap;
  @override
  State<CareerBranche> createState() => _CareerBrancheState();
}

class _CareerBrancheState extends State<CareerBranche> {
  //Variables
  List<dynamic> _branches = [];
  List<dynamic> _careers = [];
  int? _selectedBranche;
  late int _selectedCareer;
  //Methods
  Future<void> _getCareers() async {
    final json = await API.getCareers();
    setState(() {
      _careers = json;
    });
  }

  @override
  void initState() {
    super.initState();
    _getCareers();
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
                    const SizedBox(
                      height: 15,
                    ),
                    DropdownButtonFormField<Map<String, dynamic>>(
                      isExpanded: true,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      items: _careers.map((career) {
                        return DropdownMenuItem<Map<String, dynamic>>(
                          value: career,
                          child: Text(
                            career['_nombre'],
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: (Map<String, dynamic>? selectedCareer) async {
                        final json = await API.getCareersBranchNO(
                            selectedCareer?['_codigoCarrera'].toString());
                        setState(() {
                          _branches = [];
                          _selectedCareer = selectedCareer?['_codigoCarrera'];
                          _branches = json;
                        });
                      },
                      hint: const Text('Selecciona una carrera'),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
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
                      onChanged: (Map<String, dynamic>? selectedBranche) {
                        setState(() {
                          _selectedBranche =
                              selectedBranche?['_codigoSucursal'];
                        });
                      },
                      hint: const Text('Seleccione una sucursal'),
                      value: _branches.isNotEmpty
                          ? _branches.firstWhere(
                              (branch) =>
                                  branch['_codigoSucursal'] == _selectedBranche,
                              orElse: () => null)
                          : null,
                    ),
                  ]),
                )),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () async {
                    await API
                        .postCareerBranch(_selectedCareer, _selectedBranche)
                        .then((_) {
                      widget.onTap(0, pop: false);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      "REGISTRAR",
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
