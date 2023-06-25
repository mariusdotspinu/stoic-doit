import 'package:ad_como/widgets/todo/todo_model.dart';
import 'package:flutter/material.dart';

import '../../shared_preferences/preferences.dart';

class TodoWidget extends StatefulWidget {
  late TodoModel todoModel;
  late Function function;

  TodoWidget({required TodoModel todoModel, required Function function}) {
    this.todoModel = todoModel;
    this.function = function;
  }

  @override
  State<StatefulWidget> createState() {
    return TodoWidgetState(
        todoModel: SharedPreferencesUtils.getTodo(todoModel.id),
    function: function);
  }
}

class TodoWidgetState extends State<StatefulWidget> {
  late TodoModel todoModel;
  late Function function;
  final controller = TextEditingController();

  TodoWidgetState({required TodoModel todoModel, required Function function}) {
    this.todoModel = todoModel;
    this.function = function;
    controller.text = todoModel.text;
    controller.value = controller.value.copyWith(
      text: controller.text
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListTile(
      onTap: () {
        setState(() {
          todoModel.checked = !todoModel.checked!;
          SharedPreferencesUtils.saveTodo(todoModel);
          if(todoModel.checked == true)
            function.call();
        });
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      leading: IgnorePointer(
          child: Visibility(
            visible: todoModel.checkBoxVisibility,
        child: Checkbox(
            activeColor: Colors.blueAccent,
            checkColor: Colors.black,
            value: todoModel.checked,
          onChanged: (nothing) {
          },
        ),
      )),
      title: TextField(
        textInputAction: TextInputAction.go,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        autofocus: todoModel.isAutoFocus,
        enabled: todoModel.isEnabled,
        controller: controller,
        onSubmitted: submitTodo,
        style: TextStyle(
          fontFamily: 'Todo',
            fontSize: 28,
            fontWeight: FontWeight.bold,
            decoration: todoModel.checked == true
                ? TextDecoration.lineThrough
                : TextDecoration.none),
        decoration:
            InputDecoration(hintText: 'Write task', border: InputBorder.none),
      ),
    ));
  }

  SharedPreferencesUtils sharedPreferences = SharedPreferencesUtils();

  void submitTodo(text) {
    if(text != '')
    setState(() {
      todoModel.text = text.toString().trim();
      todoModel.isEnabled = false;
      todoModel.isAutoFocus = false;
      todoModel.checkBoxVisibility = true;
      SharedPreferencesUtils.saveTodo(todoModel);
    });
  }
}
