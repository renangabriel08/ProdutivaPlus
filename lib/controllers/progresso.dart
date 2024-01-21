import 'package:tarefas/controllers/cache.dart';
import 'package:tarefas/widgets/toast.dart';

class ProgressoController {
  static checkDia(List<String> checks) {
    if (checks.isEmpty) {
      MyToast.gerarToast('Você não pode concluir sem tarefas');
    } else if (checks.contains('false')) {
      MyToast.gerarToast('Você precisa concluir todas tarefas');
    } else {
      adicionarDia();
    }
  }

  static adicionarDia() async {
    await CacheController.adicionarProgresso(DateTime.now());
    MyToast.gerarToast('Dia concluido com sucesso');
  }
}
