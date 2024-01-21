import 'package:flutter/material.dart';
import 'package:tarefas/pages/habitos.dart';
import 'package:tarefas/pages/progresso.dart';
import 'package:tarefas/pages/tarefas.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: IndexedStack(
          index: index,
          children: const [Tarefas(), Habitos(), Progresso()],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (value) => setState(() {
            index = value;
          }),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined),
              label: 'Tarefas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.psychology_outlined),
              label: 'Hábitos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Progresso',
            ),
          ],
        ),
      ),
    );
  }
}
