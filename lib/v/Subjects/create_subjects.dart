import 'package:bd_project/c/api.dart';
import 'package:flutter/material.dart';

class CreateSubjects extends StatefulWidget {
  const CreateSubjects({
    super.key,
    required this.edit,
    required this.onTap,
  });
  final bool edit;
  final Function onTap;
  @override
  State<CreateSubjects> createState() => _CreateSubjectsState();
}

class _CreateSubjectsState extends State<CreateSubjects> {
  //Variables
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _uvs = TextEditingController();

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
                    TextFormField(
                      controller: _nombre,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Nombre",
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 160, 160, 147)),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _uvs,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Unidades Valorativas",
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 160, 160, 147)),
                      ),
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
                    API.postSubject(_nombre.text, _uvs.text).then((_) {
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
                      widget.edit ? "EDITAR ASIGNATURA" : "CREAR ASIGNATURA",
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
