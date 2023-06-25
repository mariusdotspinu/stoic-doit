import 'package:ad_como/shared_preferences/preferences.dart';
import 'package:ad_como/utils/animation_utils.dart';
import 'package:ad_como/widgets/dialogs/about_dialog_widget.dart';
import 'package:ad_como/widgets/bottom-app-bar/add_item.dart';
import 'package:ad_como/widgets/bottom-app-bar/clear_all_item.dart';
import 'package:ad_como/widgets/bottom-app-bar/info_item.dart';
import 'package:ad_como/widgets/todo/todo_widget.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';

import '../utils/quote_utils.dart';
import 'package:ad_como/widgets/quote_widget.dart';

import '../widgets/bottom_app_bar.dart';
import '../widgets/dismissible_widget.dart';
import '../widgets/todo/todo_model.dart';

class Primary extends StatefulWidget {
  late Future<Quote> quote;

  Primary({required Future<Quote> quote}) {
    this.quote = quote;
  }

  @override
  State<StatefulWidget> createState() {
    return new MainState(quote: quote);
  }
}

class MainState extends State<StatefulWidget> {
  late Future<Quote> quote;
  ScrollController listViewController = ScrollController();
  List<TodoWidget> todoItems = [];
  bool animationVisible = false;

  MainState({required Future<Quote> quote}) {
    this.quote = quote;
    for (TodoModel todoModel in SharedPreferencesUtils.getAllTodos()) {
      todoItems.add(
          TodoWidget(todoModel: todoModel, function: () => changeVisibility()));
    }
    todoItems
        .sort((a, b) => a.todoModel.timestamp.compareTo(b.todoModel.timestamp));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white10,
        appBar: buildAppBar(),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(children: [
              QuoteWidget(quote: quote).build(context),
              Expanded(
                  child: Stack(
                children: [
                  todoItems.length > 0
                      ? ListView.builder(
                          physics: ClampingScrollPhysics(),
                          controller: listViewController,
                          itemCount: todoItems.length,
                          itemBuilder: (context, index) {
                            var currentItem = todoItems[index];
                            return buildDismissibleWidget(currentItem, index);
                          })
                      : Container(
                          alignment: Alignment.center,
                          // margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Overthinking again...?",
                                  style: TextStyle(
                                      fontFamily: 'Quote',
                                      color: Colors.blueGrey,
                                      fontSize: 20),
                                ),
                                Lottie.asset('assets/yoda_math.json'),
                              ])),
                  Center(
                      // margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child:
                            Visibility(
                                visible: animationVisible,
                                child: AnimatedTextKit(
                                  totalRepeatCount: 1,
                                  onFinished: () => {changeVisibility()},
                                  animatedTexts: [
                                    ScaleAnimatedText(AnimationUtils.fetchRandomRewardString(),
                                        textStyle: TextStyle(fontSize: 50,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueGrey,
                                            fontFamily: 'Quote'),
                                        duration: new Duration(seconds: 1, milliseconds: 300)),
                                  ],
                                ))
                          )
                ],
              ))
            ])),
        bottomNavigationBar: buildBottomAppBarWithItems(context));
  }

  void changeVisibility() {
    setState(() {
      animationVisible = !animationVisible;
    });
  }

  DismissibleWidget buildDismissibleWidget(TodoWidget currentItem, int index) {
    return DismissibleWidget(
        dismissDirectionCallback: (d) => setState(() {
              todoItems.remove(currentItem);
              SharedPreferencesUtils.prefs.remove(currentItem.todoModel.id);
              if (SharedPreferencesUtils.getLastSavedId() ==
                  currentItem.todoModel.id) {
                SharedPreferencesUtils.prefs.remove('last_saved_todo');
              }
            }),
        todoWidget: currentItem,
        todoItemIndex: index);
  }

  BottomAppBarWithItems buildBottomAppBarWithItems(BuildContext context) {
    return BottomAppBarWithItems(
      widgets: [
        InfoItem(() => {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AboutDialogWidget())
            }),
        AddItem(this),
        ClearAllItem(this)
      ],
    );
  }

  void addItem() {
    setState(() {
      if (SharedPreferencesUtils.getLastSavedId() != null) {
        TodoModel lastSaved = SharedPreferencesUtils.getTodo(
            SharedPreferencesUtils.getLastSavedId()!);
        if (lastSaved.isEnabled == false) {
          saveNewTodo();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: Duration(seconds: 1),
              content: const Text(
                'You have a pending task already!',
                style: TextStyle(fontSize: 18, fontFamily: 'Quote'),
              )));
        }
      } else {
        saveNewTodo();
      }
    });
    SchedulerBinding.instance.addPostFrameCallback((_) {
      listViewController.animateTo(listViewController.position.maxScrollExtent,
          curve: Curves.linear, duration: Duration(milliseconds: 100));
    });
  }

  void clearAll() {
    setState(() {
      todoItems = [];
      SharedPreferencesUtils.removeAll();
      listViewController = ScrollController();
    });
  }

  void saveNewTodo() {
    TodoModel todoModel = TodoModel();
    todoItems.add(
        TodoWidget(todoModel: todoModel, function: () => changeVisibility()));
    SharedPreferencesUtils.saveTodo(todoModel);
    SharedPreferencesUtils.saveLastId(todoModel.id);
  }
}

AppBar buildAppBar() {
  return AppBar(
    toolbarHeight: 0,
    elevation: 0,
    backgroundColor: Colors.white10,
  );
}
