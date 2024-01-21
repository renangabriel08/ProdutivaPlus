import 'package:flutter/material.dart';
import 'package:tarefas/controllers/biometria.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/splash.png',
                    height: 150,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Desperte sua produtividade, domine seus hábitos, viva com progresso.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      color: Colors.purple[300],
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () => Biometria.verificarCompatibilidade(context),
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
