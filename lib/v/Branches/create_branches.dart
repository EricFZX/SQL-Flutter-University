import 'package:bd_project/c/api.dart';
import 'package:bd_project/v/home.dart';
import 'package:flutter/material.dart';

class CreateBranches extends StatefulWidget {
  const CreateBranches({
    super.key,
    required this.edit,
    this.onTap,
    this.branch,
    this.updateState,
  });
  final bool edit;
  final Function? onTap;
  final Function? updateState;
  final dynamic branch;

  @override
  State<CreateBranches> createState() => _CreateBranchesState();
}

class _CreateBranchesState extends State<CreateBranches> {
  //Variables
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _departamento = TextEditingController();
  final TextEditingController _ciudad = TextEditingController();
  final TextEditingController _calle = TextEditingController();

  //Map Values
  void getData() {
    if (widget.edit) {
      _nombre.text = widget.branch['_nombre'];
      _departamento.text = widget.branch['_departamento'];
      _ciudad.text = widget.branch['_ciudad'];
      _calle.text = widget.branch['_calle'];
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFededeb),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height / 1.8,
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
                      controller: _departamento,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Departamento",
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 160, 160, 147)),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _ciudad,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Ciudad",
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 160, 160, 147)),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _calle,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Calle",
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
                    if (widget.edit) {
                      await API
                          .patchBranch(
                              widget.branch['_codigoSucursal'],
                              _nombre.text,
                              _departamento.text,
                              _ciudad.text,
                              _calle.text)
                          .then((_) {
                        widget.updateState!();
                        Navigator.pop(context);
                      });
                    } else {
                      await API
                          .postBranch(_nombre.text, _departamento.text,
                              _ciudad.text, _calle.text)
                          .then((_) {
                        widget.onTap!(0, pop: false);
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      widget.edit ? "EDITAR SUCURSAL" : "CREAR SUCURSAL",
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
