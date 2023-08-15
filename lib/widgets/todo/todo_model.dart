class TodoModel {
  bool checked = false;
  bool? isEnabled = true;
  bool isAutoFocus = true;
  bool checkBoxVisibility = false;
  String text = '';
  String id = '';
  int timestamp = 0;

  TodoModel() {}

  TodoModel.fromJson(Map<String, dynamic> json)
      : checked = json['checked'],
        isEnabled = json['isEnabled'],
        isAutoFocus = json['isAutoFocus'],
        checkBoxVisibility = json['checkBoxVisibility'],
        text = json['text'],
        timestamp = json['timestamp'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
    'checked': checked,
    'isEnabled': isEnabled,
    'isAutoFocus': isAutoFocus,
    'checkBoxVisibility': checkBoxVisibility,
    'text': text,
    'timestamp': timestamp,
    'id': id
  };
}