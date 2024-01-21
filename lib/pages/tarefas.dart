import 'package:flutter/material.dart';
import 'package:tarefas/controllers/cache.dart';
import 'package:tarefas/controllers/progresso.dart';
import 'package:tarefas/controllers/tarefas.dart';
import 'package:tarefas/controllers/validator.dart';
import 'package:tarefas/controllers/modal.dart';

class Tarefas extends StatefulWidget {
  const Tarefas({super.key});

  @override
  State<Tarefas> createState() => _TarefasState();
}

class _TarefasState extends State<Tarefas> {
  static final TextEditingController controller = TextEditingController();
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double widthTela = MediaQuery.of(context).size.width;
    List<String> checks = [];

    gerarModal() {
      return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text(
            'Adicione uma nova tarefa',
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            width: double.infinity,
            height: 186,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    onChanged: (value) => ModalController.titulo = value,
                    validator: (value) => Validator.validarTituloTarefa(value!),
                    decoration: const InputDecoration(
                      label: Text('Título'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Container(height: 10),
                  TextFormField(
                    controller: controller,
                    readOnly: true,
                    validator: (value) => Validator.validarForm(value),
                    decoration: InputDecoration(
                      label: const Text('Horário'),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () => ModalController.selecionarHorario(
                          context,
                          controller,
                        ),
                        icon: const Icon(Icons.timer_sharp),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancelar'),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await ModalController.adicionarTarefa(context);
                  setState(() {});
                }
              },
              child: const Text('Adicionar'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
        body: FutureBuilder(
          future: CacheController.getTarefas(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == false || snapshot.data?.toString() == '[]') {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/semtarefas.png',
                        height: 140,
                      ),
                      Column(
                        children: [
                          Text(
                            'Você não possui nenhuma tarefa cadastrada',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.purple[300],
                            ),
                          ),
                          Text(
                            'Clique no "+" e adicione novas tarefas',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.purple[300],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }

              dynamic tarefas = snapshot.data;

              checks = [];

              for (int i = 0; i < tarefas.length; i++) {
                checks.add(tarefas[i][3]);
              }

              return SizedBox(
                width: widthTela,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/tarefas.png',
                            height: 120,
                          ),
                          const SizedBox(width: 15),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Confira suas',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.purple[300],
                                ),
                              ),
                              const Text(
                                'tarefas diárias',
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
                      const SizedBox(height: 30),
                      for (int i = 0; i < tarefas.length; i++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: widthTela * .9,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.purple),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Checkbox(
                                            value: tarefas[i][3] == 'false'
                                                ? false
                                                : true,
                                            onChanged: (value) async {
                                              await CacheController
                                                  .atualizarTarefa(
                                                tarefas[i][0],
                                                tarefas[i][1],
                                                tarefas[i][2],
                                                value!,
                                              );
                                              setState(() {});
                                            },
                                          ),
                                          Container(
                                            width: widthTela * .65,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${tarefas[i][1]}',
                                                ),
                                                Text(
                                                  '${tarefas[i][2]}',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          await TarefasController.deletarTarefa(
                                            tarefas[i][0],
                                          );
                                          setState(() {});
                                        },
                                        icon: const Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      tarefas[i][3] == 'false' ? false : true,
                                  child: Positioned(
                                    top: 30,
                                    left: widthTela * .11,
                                    child: Container(
                                      width: widthTela * .68,
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10)
                          ],
                        ),
                    ],
                  ),
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/erro.png',
                      height: 140,
                    ),
                    Column(
                      children: [
                        Text(
                          'Ocorreu um erro ao carregar suas tarefas.',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.purple[300],
                          ),
                        ),
                        Text(
                          'Tente novamente!',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.purple[300],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () => setState(() {
                ProgressoController.checkDia(checks);
              }),
              child: const Icon(
                Icons.check,
                size: 30,
              ),
            ),
            const SizedBox(width: 15),
            FloatingActionButton(
              onPressed: () => gerarModal(),
              child: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
          ],
        ));
  }
}
