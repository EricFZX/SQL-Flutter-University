import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});
  Widget _richText(String title, String body) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: const TextStyle(color: Colors.black, fontSize: 16, height: 1.3),
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: body,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Expanded(
                child: Container(
                  height: 130,
                  color: Colors.blue[800],
                ),
              )),
          Positioned(
              top: 30,
              left: 20,
              right: 20,
              bottom: 30,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text(
                        "¡Bienvenido Administrador!",
                        style: TextStyle(fontSize: 17),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Desde esta página podrás realizar todas tus transacciones de Consultas a Registro,"
                        "incluyendo matricular tus clases y revisar tu saldo.\n \n"
                        "Selecciona la opción que desees en el menú y no te olvides de cerrar la sesión"
                        "al salir del sitio.",
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      _richText("Importante: ",
                          "La aplicación de descuentos debe ser solicitado solamente en el periodo de matricula ordinaria y extraordinaria, fuera de estas fechas no será posible la aplicación."),
                      const SizedBox(
                        height: 15,
                      ),
                      _richText("Información sobre cursos virtuales:",
                          "La asistencia al examen es obligatoria y el estudiante elegirá entre los horarios disponibles el que más le convenga. Para aprobar el curso la nota del examen final integrador debe ser de 70% para las Ofimáticas y 60% para el resto de los cursos.")
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
