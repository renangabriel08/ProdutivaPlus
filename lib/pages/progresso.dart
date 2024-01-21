import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tarefas/controllers/cache.dart';

class Progresso extends StatefulWidget {
  const Progresso({super.key});

  @override
  State<Progresso> createState() => _ProgressoState();
}

class _ProgressoState extends State<Progresso> {
  List<DateTime> datasConcluidas = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CacheController.getProgresso(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          dynamic snapshotData = snapshot.data;
          datasConcluidas = [];

          for (int i = 0; i < snapshotData.length; i++) {
            datasConcluidas.add(DateTime.parse(snapshotData[i]));
          }

          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/progresso.png',
                      height: 120,
                    ),
                    const SizedBox(width: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Confira seu',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Colors.purple[300],
                          ),
                        ),
                        const Text(
                          'progresso total',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Container(height: 20),
                TableCalendar(
                  firstDay: DateTime(2023),
                  lastDay: DateTime(2999),
                  focusedDay: DateTime.now(),

                  //Dias verdes
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, date, _) {
                      for (int i = 0; i < datasConcluidas.length; i++) {
                        if (isSameDay(date, datasConcluidas[i])) {
                          return Container(
                            margin: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: Colors.green[300],
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text(
                                '✓',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }
                      }

                      return null;
                    },
                  ),
                ),
                Container(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Continue, não desista',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.purple[300],
                          ),
                        ),
                        const Text(
                          'você vai conseguir!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/continue.png',
                      height: 120,
                    ),
                  ],
                ),
              ],
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Erro'),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
