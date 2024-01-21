import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tarefas/pages/home.dart';
import 'package:tarefas/pages/splash.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/splash': (context) => const Splash(),
        '/home': (context) => const Home(),
      },
      initialRoute: '/splash',
    );
  }
}
