import 'package:tarefas/controllers/cache.dart';
import 'package:tarefas/widgets/toast.dart';

class HabitosController {
  static deletarHabilito(String id) async {
    await CacheController.deletarHabito(id);
    MyToast.gerarToast('Hábito deletada com sucesso!');
  }
}
