import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grafikaku/routes/app_pages.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grafika Komputer')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Selamat datang di Tools Grafika Komputer',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.canvas);
              },
              child: const Text('Mulai Canvas Interaktif'),
            ),
          ],
        ),
      ),
    );
  }
}
