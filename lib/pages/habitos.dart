import 'package:flutter/material.dart';
import 'package:tarefas/controllers/cache.dart';
import 'package:tarefas/controllers/habitos.dart';
import 'package:tarefas/controllers/modal.dart';
import 'package:tarefas/controllers/validator.dart';

class Habitos extends StatefulWidget {
  const Habitos({super.key});

  @override
  State<Habitos> createState() => _HabitosState();
}

class _HabitosState extends State<Habitos> {
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double widthTela = MediaQuery.of(context).size.width;

    gerarModal() {
      return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text(
            'Adicione um novo hábito',
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            width: double.infinity,
            height: 90,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    onChanged: (value) => ModalController.titulo = value,
                    validator: (value) => Validator.validarTituloHabito(value!),
                    decoration: const InputDecoration(
                      label: Text('Título'),
                      border: OutlineInputBorder(),
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
                  await ModalController.adicionarHabito(context);
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
        future: CacheController.getHabitos(),
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
                          'Você não possui nenhum hábito cadastrado',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.purple[300],
                          ),
                        ),
                        Text(
                          'Clique no "+" e adicione novos hábitos',
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

            dynamic habitos = snapshot.data;

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
                              'Confira seus',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                                color: Colors.purple[300],
                              ),
                            ),
                            const Text(
                              'hábitos diários',
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
                    for (int i = 0; i < habitos.length; i++)
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
                                    Checkbox(
                                      value: habitos[i][2] == 'false'
                                          ? false
                                          : true,
                                      onChanged: (value) async {
                                        await CacheController.atualizarHabito(
                                          habitos[i][0],
                                          habitos[i][1],
                                          value!,
                                        );
                                        setState(() {});
                                      },
                                    ),
                                    Container(
                                      width: widthTela * .65,
                                      child: Text('${habitos[i][1]}'),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        await HabitosController.deletarHabilito(
                                          habitos[i][0],
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
                                    habitos[i][2] == 'false' ? false : true,
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
                        'Ocorreu um erro ao carregar seus hábitos.',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => gerarModal(),
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
