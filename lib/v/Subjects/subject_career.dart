import 'package:bd_project/c/api.dart';
import 'package:flutter/material.dart';

class SubjectCareer extends StatefulWidget {
  const SubjectCareer({super.key});

  @override
  State<SubjectCareer> createState() => _SubjectCareerState();
}

class _SubjectCareerState extends State<SubjectCareer> {
  //Variables
  List<dynamic> _subjects = [];
  late int _selectSubject;

  //Methods
  Future<void> _getSubjects() async {
    final json = await API.getSubjects();
    setState(() {
      _subjects = json;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFededeb),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Container(
            height: 280,
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
                      items: _subjects.map((subject) {
                        return DropdownMenuItem<Map<String, dynamic>>(
                          value: subject,
                          child: Text(
                            subject['_nombre'],
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: (Map<String, dynamic>? selectedSubject) {
                        setState(() {
                          _selectSubject =
                              selectedSubject?['_codigoAsignatura'];
                        });
                      },
                      hint: const Text('Selecciona una Asignatura'),
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
