import 'package:bd_project/c/api.dart';
import 'package:flutter/material.dart';

class StudentSection extends StatefulWidget {
  const StudentSection({super.key, required this.onTap});
  final Function onTap;
  @override
  State<StudentSection> createState() => _StudentSectionState();
}

class _StudentSectionState extends State<StudentSection> {
  //variables
  List<dynamic> _branches = [];
  List<dynamic> _students = [];
  List<dynamic> _sections = [];

  int? _selectedBranch;
  int? _selectedStudent;
  int? _selectedSection;

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
            height: 360,
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
                          _sections = [];
                          _students = jsonStudent;
                          _selectedBranch = selectedBranche?['_codigoSucursal'];
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
                      items: _students.map((student) {
                        return DropdownMenuItem<Map<String, dynamic>>(
                          value: student,
                          child: Text(
                            "${student['_codigoAlumno']}-${student['_nombre']}",
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: (Map<String, dynamic>? selectedStudent) async {
                        final json = await API.studentSectionNO(
                            selectedStudent?['_codigoAlumno'], _selectedBranch);
                        setState(() {
                          _selectedStudent = selectedStudent?['_codigoAlumno'];
                          _sections = json;
                        });
                      },
                      hint: const Text('Seleccione un alumno'),
                      value: _students.isNotEmpty
                          ? _students.firstWhere(
                              (student) =>
                                  student['_codigoAlumno'] == _selectedStudent,
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
                      items: _sections.map((section) {
                        return DropdownMenuItem<Map<String, dynamic>>(
                          value: section,
                          child: Text(
                            "${section['_codigoSeccion']}-${section['_nombre']}",
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: (Map<String, dynamic>? selectedSection) async {
                        setState(() {
                          _selectedSection = selectedSection?['_codigoSeccion'];
                        });
                      },
                      hint: const Text('Seleccione una seccion'),
                      value: _sections.isNotEmpty
                          ? _sections.firstWhere(
                              (section) =>
                                  section['_codigoSeccion'] == _selectedSection,
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
                        .postStudentSection(_selectedStudent, _selectedSection)
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
                      "Matricular Seccion",
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
