import 'package:accordion/accordion.dart';
import 'package:bd_project/v/Students/create_students.dart';
import 'package:bd_project/v/Students/list_students.dart';
import 'package:bd_project/v/Subjects/create_subjects.dart';
import 'package:bd_project/v/Teachers/create_teachers.dart';
import 'package:bd_project/v/Teachers/list_teachers.dart';
import 'package:bd_project/v/Branches/create_branches.dart';
import 'package:bd_project/v/Branches/list_branches.dart';
import 'package:bd_project/v/landing_page.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Variables
  int _selectIndex = 0;
  final Color _colordefault = const Color(0xFFededeb);
  //Methods
  void _ontap(int index, {bool pop = true}) {
    if (pop == true) {
      Navigator.pop(context);
    }
    setState(() {
      _selectIndex = index;
    });
  }

  Widget _accordionText(String title) {
    return Text(title, style: const TextStyle(fontSize: 17));
  }

  // Functions

  Widget _drawer() {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        children: [
          SizedBox(
            height: 250,
            child: DrawerHeader(
                child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("images/logo_user.png"),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Administrador".toUpperCase(),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  "UNITEC",
                  style: TextStyle(fontWeight: FontWeight.w300),
                )
              ],
            )),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Menú:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Accordion(
              disableScrolling: true,
              rightIcon: const Icon(Icons.arrow_drop_down),
              headerBackgroundColor: Colors.white,
              contentBackgroundColor: Colors.white,
              contentBorderColor: Colors.white,
              paddingBetweenClosedSections: 20,
              paddingListBottom: 0,
              maxOpenSections: 2,
              children: [
                AccordionSection(
                    header: _accordionText("Sucursal"),
                    content: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text("Crear Sucursal"),
                          onTap: () => _ontap(1),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text("Listar Sucursales"),
                          onTap: () => _ontap(2),
                        )
                      ],
                    )),
                AccordionSection(
                    header: _accordionText("Alumnos"),
                    content: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text("Crear Alumno"),
                          onTap: () => _ontap(3),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text("Listar Alumnos"),
                          onTap: () => _ontap(4),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text("Matricular Estudiante"),
                        )
                      ],
                    )),
                AccordionSection(
                    header: _accordionText("Docentes"),
                    content: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text("Crear Docente"),
                          onTap: () => _ontap(4),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text("Listar Docentes"),
                          onTap: () => _ontap(3),
                        ),
                      ],
                    )),
                AccordionSection(
                    header: _accordionText("Asignaturas"),
                    content: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text("Crear Asignatura"),
                          onTap: () => _ontap(7),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text("Listar Asignaturas"),
                          onTap: () => _ontap(3),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text("Asignar Carrera"),
                          onTap: () => _ontap(3),
                        ),
                      ],
                    )),
              ]),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //List Widgets
    final List<Widget> widgets = [
      const LandingPage(),
      CreateBranches(
        edit: false,
        onTap: _ontap,
      ),
      const ListBranches(),
      CreateStudents(
        edit: false,
      ),
      const ListStudents(),
      const ListTeachers(),
      CreateTeachers(
        edit: false,
        onTap: _ontap,
      ),
      CreateSubjects(edit: false, onTap: _ontap)
    ];
    return Scaffold(
      backgroundColor: _colordefault,
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              "images/logo_blanco.png",
              width: 150,
            )
          ],
        ),
      ),
      body: widgets[_selectIndex],
      drawer: _drawer(),
    );
  }
}
