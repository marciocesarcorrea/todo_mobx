import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:todo/app/modules/home/home_controller.dart';
import 'package:todo/app/modules/home/home_module.dart';
import 'package:todo/app/shared/models/todo_model.dart';

class ItemWidget extends StatelessWidget {
  final TodoModel model;
  final Function onPressed;

  const ItemWidget({
    Key key,
    this.model,
    this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Dismissible(
          direction: DismissDirection.startToEnd,
          onDismissed: (direction) {
            HomeModule.to.bloc<HomeController>().remove(model.id);
          },
          background: Container(
            alignment: AlignmentDirectional(-1.0, 0),
            color: Colors.red.withOpacity(0.2),
            child: Icon(Icons.delete),
          ),
          key: Key(model.id.toString()),
          child: ListTile(
            onTap: onPressed,
            title: Text(
              model.title,
            ),
            trailing: Checkbox(
              onChanged: (v) {
                model.check = v;
              },
              value: model.check ?? false,
            ),
          ),
        );
      },
    );
  }
}
