import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:todo/app/modules/home/components/item/item_widget.dart';
import 'package:todo/app/modules/home/home_controller.dart';
import 'package:todo/app/modules/home/home_module.dart';
import 'package:todo/app/shared/models/todo_model.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Todo List"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeModule.to.bloc<HomeController>();

  _showDialog([TodoModel model]) {
    model = model ?? TodoModel();
    String cacheTitle = model.title;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text(model.id != null ? 'Edtar' : 'Novo'),
          content: TextFormField(
            initialValue: model.title,
            maxLines: 3,
            onChanged: (v) {
              model.title = v;
            },
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () {
                model.title = cacheTitle;
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('Salvar'),
              onPressed: () {
                if (model.id != null) {
                  controller.update(model);
                } else {
                  controller.add(model);
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Observer(
              builder: (_) => Text('Total: ${controller.itemsTotal}'),
            ),
          ),
        ],
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.delete_sweep),
          onPressed: () {
            controller.clearAll();
          },
        ),
      ),
      body: Observer(
        builder: (_) {
          return ListView.builder(
            itemBuilder: (BuildContext _, int index) {
              TodoModel model = controller.list[index];
              return ItemWidget(
                model: model,
                onPressed: () {
                  _showDialog(model);
                },
              );
            },
            itemCount: controller.list.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
