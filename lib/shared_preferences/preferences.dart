import 'dart:convert';

import 'package:ad_como/widgets/todo/todo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class SharedPreferencesUtils {
  static const THEME_PREF = "themePref";
  static late SharedPreferences prefs;

  static setDarkTheme(bool value) {
    prefs.setBool(THEME_PREF, value);
  }

  static getTheme() {
    return prefs.getBool(THEME_PREF) ?? false;
  }

  static List<TodoModel> getAllTodos() {
    List<TodoModel> todoModels = [];
    for(String key in prefs.getKeys()) {
      if(key.startsWith('_todo_id_')) {
        todoModels.add(getTodo(key));
      }
    }
    return todoModels;
  }

  static TodoModel getTodo(String id) {
    String? foundTodo = prefs.getString(id);
    if (foundTodo != null) {
      return TodoModel.fromJson(jsonDecode(foundTodo));
    }
    return TodoModel();
  }

  static saveTodo(TodoModel todoModel) {
    if(todoModel.id == '') {
      todoModel.id = '_todo_id_' + Uuid().v1() + Uuid().v4();
    }
    if(todoModel.timestamp == 0) {
      todoModel.timestamp = DateTime.now().millisecondsSinceEpoch;
    }
    prefs.setString(todoModel.id, jsonEncode(todoModel.toJson()));
  }

  static saveLastId(String id) {
    prefs.setString('last_saved_todo', id);
  }

  static String? getLastSavedId() {
    return prefs.getString('last_saved_todo');
  }

  static removeAll(){
    for(String key in prefs.getKeys()) {
      if(!key.startsWith(THEME_PREF)) {
        prefs.remove(key);
      }
    }
  }
}
