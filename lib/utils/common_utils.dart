import 'package:ad_como/widgets/todo/todo_widget.dart';

import '../widgets/todo/todo_model.dart';

class CommonUtils {

  static void sortByAddingOrder(List<TodoModel> todoModels) {
    todoModels
        .sort((a, b) => a.timestamp.compareTo(b.timestamp));
  }

  static void sortByCheckedItems(List<TodoWidget> todoItems) {
    todoItems.sort((a, b) {
      if (b.todoModel.checked == true) {
        return 1;
      }
      return -1;
    });
  }

  static void sortByCheckedItemModel(List<TodoModel> todoModels) {
    todoModels.sort((a, b) {
      if (b.checked == true) {
        return 1;
      }
      return -1;
    });
  }
}
