import 'package:mobx/mobx.dart';

part 'todo_model.g.dart';

class TodoModel extends _TodoModel with _$TodoModel {
  TodoModel({
    bool check = false,
    String title,
    int id,
  }) : super(id: id, title: title, check: check);

  toJson() => {
        'title': title,
        'check': check,
        'id': id,
      };

  factory TodoModel.fromJson(Map json) =>
      TodoModel(id: json['id'], check: json['check'], title: json['title']);
}

abstract class _TodoModel with Store {
  int id;

  @observable
  String title;

  @observable
  bool check;
  _TodoModel({
    this.check = false,
    this.title,
    this.id,
  });
}
