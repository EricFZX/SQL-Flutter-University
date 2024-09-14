import 'package:bd_project/c/api.dart';
import 'package:flutter/material.dart';

class CreateSections extends StatefulWidget {
  const CreateSections({super.key, required this.edit, required this.onTap});
  final bool edit;
  final Function onTap;
  @override
  State<CreateSections> createState() => _CreateSectionsState();
}

class _CreateSectionsState extends State<CreateSections> {
  //Variables
  List<dynamic> _branches = [];
  List<dynamic> _teachers = [];
  List<dynamic> _subjects = [];
  List<dynamic> _classrooms = [];

  int? _selectedTeacher;
  int? _selectedSubject;
  int? _selectedClassroom;

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
                        final jsonTeachers = await API
                            .branchTeacher(selectedBranche?['_codigoSucursal']);
                        final jsonSubjects = await API
                            .branchSubject(selectedBranche?['_codigoSucursal']);
                        final jsonCareers = await API.branchClassroom(
                            selectedBranche?['_codigoSucursal']);

                        setState(() {
                          _teachers = [];
                          _subjects = [];
                          _classrooms = [];
                          _teachers = jsonTeachers;
                          _subjects = jsonSubjects;
                          _classrooms = jsonCareers;
                        });
                      },
                      hint: const Text('Seleccione una sucursal'),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DropdownButtonFormField<Map<String, dynamic>>(
                      isExpanded: true,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      items: _teachers.map((teacher) {
                        return DropdownMenuItem<Map<String, dynamic>>(
                          value: teacher,
                          child: Text(
                            teacher['_primerNombre'] +
                                " " +
                                teacher['_primerApellido'],
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: (Map<String, dynamic>? selectedTeacher) async {
                        setState(() {
                          _selectedTeacher = selectedTeacher?['_codigoDocente'];
                        });
                      },
                      hint: const Text('Seleccione un Docente'),
                      value: _teachers.isNotEmpty
                          ? _teachers.firstWhere(
                              (teacher) =>
                                  teacher['_codigoDocente'] == _selectedTeacher,
                              orElse: () => null)
                          : null,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DropdownButtonFormField<Map<String, dynamic>>(
                      isExpanded: true,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      items: _subjects.map((subject) {
                        return DropdownMenuItem<Map<String, dynamic>>(
                          value: subject,
                          child: Text(
                            subject['_nombre'],
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: (Map<String, dynamic>? selectedSubject) async {
                        setState(() {
                          _selectedSubject =
                              selectedSubject?['_codigoAsignatura'];
                        });
                      },
                      hint: const Text('Seleccione una Asignatura'),
                      value: _subjects.isNotEmpty
                          ? _subjects.firstWhere(
                              (subject) =>
                                  subject['_codigoAsignatura'] ==
                                  _selectedSubject,
                              orElse: () => null)
                          : null,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DropdownButtonFormField<Map<String, dynamic>>(
                      isExpanded: true,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      items: _classrooms.map((classroom) {
                        return DropdownMenuItem<Map<String, dynamic>>(
                          value: classroom,
                          child: Text(
                            "COD:${classroom['_codigoAula']} CUPOS:${classroom['_cupos']}",
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged:
                          (Map<String, dynamic>? selectedClassroom) async {
                        setState(() {
                          _selectedClassroom =
                              selectedClassroom?['_codigoAula'];
                        });
                      },
                      hint: const Text('Seleccione un Aula'),
                      value: _classrooms.isNotEmpty
                          ? _classrooms.firstWhere(
                              (classroom) =>
                                  classroom['_codigoAula'] ==
                                  _selectedClassroom,
                              orElse: () => null)
                          : null,
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
                  onTap: () async {
                    API
                        .postSection(_selectedSubject, _selectedTeacher,
                            _selectedClassroom)
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
                    child: Text(
                      widget.edit ? "EDITAR SECCION" : "CREAR SECCION",
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
