import 'package:shared_preferences/shared_preferences.dart';

class CacheController {
  //Tarefas
  static getQuantidadeTarefas() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final int? quantidadeTarefas = prefs.getInt('quantidadeTarefas');

    return quantidadeTarefas;
  }

  static getUltimoIdTarefas() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final int? ultimoID = prefs.getInt('ultimoIdTarefas');

    return ultimoID;
  }

  static salvarTarefa(String titulo, String horario) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? quantidadeTarefas = await getQuantidadeTarefas();
    int? ultimoId = await getUltimoIdTarefas();

    if (quantidadeTarefas != null && ultimoId != null) {
      await prefs.setInt('quantidadeTarefas', quantidadeTarefas + 1);
      await prefs.setInt('ultimoIdTarefas', ultimoId + 1);

      await prefs.setStringList(
        'tarefa - ${ultimoId + 1}',
        <String>['${ultimoId + 1}', titulo, horario, 'false'],
      );
    } else {
      await prefs.setInt('quantidadeTarefas', 1);
      await prefs.setInt('ultimoIdTarefas', 1);

      await prefs.setStringList(
        'tarefa - 1',
        <String>['1', titulo, horario, 'false'],
      );
    }
  }

  static atualizarTarefa(String id, String titulo, horario, bool status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('tarefa - $id');

    await prefs.setStringList(
      'tarefa - $id',
      <String>[id, titulo, horario, status.toString()],
    );
  }

  static getTarefas() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? ultimoId = await getUltimoIdTarefas();
    List<List<String>> tarefas = [];

    if (ultimoId != null) {
      for (int i = 1; i <= ultimoId; i++) {
        if (prefs.getStringList('tarefa - ${i}') != null) {
          tarefas.add(prefs.getStringList('tarefa - ${i}')!);
        }
      }

      return tarefas;
    }

    return false;
  }

  static deletarTarefa(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? quantidadeTarefas = await getQuantidadeTarefas();
    await prefs.setInt('quantidadeTarefas', quantidadeTarefas! - 1);

    await prefs.remove('tarefa - $id');

    return;
  }

  //Habitos
  static getQuantidadeHabitos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final int? quantidadeHabitos = prefs.getInt('quantidadeHabitos');

    return quantidadeHabitos;
  }

  static getUltimoIdHabitos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final int? ultimoID = prefs.getInt('ultimoIdHabitos');

    return ultimoID;
  }

  static salvarHabito(String titulo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? quantidadeHabitos = await getQuantidadeHabitos();
    int? ultimoId = await getUltimoIdHabitos();

    if (quantidadeHabitos != null && ultimoId != null) {
      await prefs.setInt('quantidadeHabitos', quantidadeHabitos + 1);
      await prefs.setInt('ultimoIdHabitos', ultimoId + 1);

      await prefs.setStringList(
        'habito - ${ultimoId + 1}',
        <String>['${ultimoId + 1}', titulo, 'false'],
      );
    } else {
      await prefs.setInt('quantidadeHabitos', 1);
      await prefs.setInt('ultimoIdHabitos', 1);

      await prefs.setStringList(
        'habito - 1',
        <String>['1', titulo, 'false'],
      );
    }
  }

  static atualizarHabito(String id, String titulo, bool status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('habito - $id');

    await prefs.setStringList(
      'habito - $id',
      <String>['$id', titulo, status.toString()],
    );
  }

  static getHabitos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? ultimoId = await getUltimoIdHabitos();
    List<List<String>> habitos = [];

    if (ultimoId != null) {
      for (int i = 1; i <= ultimoId; i++) {
        if (prefs.getStringList('habito - ${i}') != null) {
          habitos.add(prefs.getStringList('habito - ${i}')!);
        }
      }

      return habitos;
    }

    return false;
  }

  static deletarHabito(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? quantidadeHabitos = await getQuantidadeHabitos();
    await prefs.setInt('quantidadeHabitos', quantidadeHabitos! - 1);

    await prefs.remove('habito - $id');

    return;
  }

  //Progresso
  static getProgresso() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? progresso = prefs.getStringList('progresso');

    progresso ??= [];

    return progresso;
  }

  static  adicionarProgresso(DateTime dia) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String diaFormatado = dia.toString();

    List<String> diasProgresso = await getProgresso();

    diasProgresso.isEmpty
        ? diasProgresso = [diaFormatado]
        : diasProgresso.add(diaFormatado);

    prefs.setStringList('progresso', diasProgresso);
  }
}
