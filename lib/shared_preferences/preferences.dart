import 'dart:convert';

import 'package:ad_como/utils/common_utils.dart';
import 'package:ad_como/widgets/todo/todo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class SharedPreferencesUtils {
  static const THEME_PREF = "themePref";
  static const TODO_KEY = "_todo_id_";
  static const LAST_SAVED_KEY = "last_saved_todo";
  static late SharedPreferences prefs;

  static setDarkTheme(bool value) {
    prefs.setBool(THEME_PREF, value);
  }

  static getTheme() {
    return prefs.getBool(THEME_PREF) ?? false;
  }

  static bool isAtLeastOneChecked() {
    for(String key in prefs.getKeys()) {
      if(key.startsWith(TODO_KEY)) {
        final todoModel = jsonDecode(prefs.get(key).toString());
        if(todoModel['checked'] == true) {
          return true;
        }
      }
    }
    return false;
  }

  static List<TodoModel> getAllTodos() {
    List<TodoModel> todoModels = [];
    for(String key in prefs.getKeys()) {
      if(key.startsWith(TODO_KEY)) {
        todoModels.add(getTodo(key));
      }
    }
    CommonUtils.sortByAddingOrder(todoModels);
    CommonUtils.sortByCheckedItemModel(todoModels);
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
    return prefs.getString(LAST_SAVED_KEY);
  }

  static removeAll() {
    for(String key in prefs.getKeys()) {
      if(!key.startsWith(THEME_PREF)) {
        prefs.remove(key);
      }
    }
  }

  static removeFinished() {
    for(String key in prefs.getKeys()) {
      if(key.startsWith(TODO_KEY)) {
        final todoModel = jsonDecode(prefs.get(key).toString());
        if(todoModel['checked'] == true) {
          prefs.remove(key);
        }
        if(todoModel['id'] == getLastSavedId()) {
          prefs.remove(LAST_SAVED_KEY);
        }
      }
    }
  }
}
