import 'package:flutter/material.dart';
import 'package:tarefas/controllers/cache.dart';
import 'package:tarefas/widgets/toast.dart';

class ModalController {
  static String horario = '';
  static String titulo = '';

  static selecionarHorario(context, controller) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      String hr = value!.hour < 10 ? '0${value.hour}' : '${value.hour}';
      String min = value.minute < 10 ? '0${value.minute}' : '${value.minute}';

      horario = '$hr:$min';
      controller.text = horario;
    });
  }

  static adicionarTarefa(context) async {
    await CacheController.salvarTarefa(titulo, horario);
    MyToast.gerarToast('Tarefa adicionada com sucesso!');
    Navigator.pop(context, 'Adicionar');
  }

  static adicionarHabito(context) async {
    await CacheController.salvarHabito(titulo);
    MyToast.gerarToast('Hábito adicionado com sucesso!');
    Navigator.pop(context, 'Adicionar');
  }
}
