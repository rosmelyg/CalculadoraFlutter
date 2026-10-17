import 'package:flutter/material.dart';

class AcercaDePage extends StatelessWidget {
  const AcercaDePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca del Proyecto'),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                'https://itla.edu.do/wp-content/uploads/2022/07/logo-itla.png',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
            
            const SizedBox(height: 30),
            
            const Text(
              'Calculadora Científica en Flutter',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            
            const SizedBox(height: 10),
            
            const Text(
              'Desarrollado para la clase de Programación\n'
              'Cumpliendo con: Navigator, TextField,\n'
              'SizedBox, Imágenes y ElevatedButton.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            
            const SizedBox(height: 40),
            
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Volver a la Calculadora'),
            )
          ],
        ),
      ),
    );
  }
}