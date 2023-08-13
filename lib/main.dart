import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLoC Todo List',
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _bloc = TodoBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BLoC Todo List')),
      body: Center(
        child: StreamBuilder<List<Todo>>(
          stream: _bloc.stateStreamOutput,
          initialData: const [],
          builder: (context, snapshot) {

            final List<Todo> data = snapshot.data != null
                ? snapshot.data as List<Todo>
                : [];

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Record id:$index, record value: ${data[index].data}'),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              _bloc.eventSink.add(TodoEvent.add);
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              _bloc.eventSink.add(TodoEvent.remove);
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}




enum TodoEvent { add, remove }


class Todo {
  final String data;

  Todo(this.data);
}


class TodoBloc {

  TodoBloc() {
    _eventStreamController.stream.listen(_mapEventToState);
  }

  // state
  final List<Todo> _todoList = [];

  final _stateStreamController = StreamController<List<Todo>>();

  StreamSink<List<Todo>> get _stateStreamInput => _stateStreamController.sink;

  Stream<List<Todo>> get stateStreamOutput => _stateStreamController.stream;



  // events
  final _eventStreamController = StreamController<TodoEvent>();

  StreamSink<TodoEvent> get eventSink => _eventStreamController.sink;

  void _mapEventToState(TodoEvent event) {
    if (event == TodoEvent.add) {
      _todoList.add(Todo('some data'));
    } else if (event == TodoEvent.remove) {
      if (_todoList.isNotEmpty) {
        _todoList.removeAt(_todoList.length - 1);
      }
    }

    _stateStreamInput.add(_todoList);
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}