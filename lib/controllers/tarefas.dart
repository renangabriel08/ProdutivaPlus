import 'package:tarefas/controllers/cache.dart';
import 'package:tarefas/widgets/toast.dart';

class TarefasController {
  static deletarTarefa(String id) async {
    await CacheController.deletarTarefa(id);
    MyToast.gerarToast('Tarefa deletada com sucesso!');
  }
}
