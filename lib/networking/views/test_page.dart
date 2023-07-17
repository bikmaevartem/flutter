import 'package:flutter/material.dart';

import '../mixins/app_bar_mixin.dart';

class TestPageInheritedWidget extends InheritedWidget {

  final String data;
  final Function(String) updateData;

  const TestPageInheritedWidget({
    required this.data,
    required this.updateData,
    required Widget child,
  }): super(child: child);

  @override
  bool updateShouldNotify(covariant TestPageInheritedWidget oldWidget ) {
    return oldWidget.data != data;
  }

  static TestPageInheritedWidget? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TestPageInheritedWidget>();
  }

  static TestPageInheritedWidget of(BuildContext context) {
    final TestPageInheritedWidget? result = maybeOf(context);
    assert(result != null, 'No TestPageInheritedWidget found in context');
    return result!;
  }
}


class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestPageState();
  }
}

class _TestPageState extends State<TestPage> with AppBarMixin {
  String _data = 'none';

  void _updateData(String newData){
    setState(() {
      _data = newData;
    });
  }

  @override
  Widget build(BuildContext context ) {
    return TestPageInheritedWidget(
      data: _data,
      updateData: _updateData,
      child: Scaffold(
        appBar: buildAppBar(title: 'Test Page'),
        body: _TestPageBody(),
      ),
    );
  }
}

class _TestPageBody extends StatelessWidget{
  @override
  Widget build(BuildContext context ) {
    final TestPageInheritedWidget testPageInheritedWidget = TestPageInheritedWidget.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(testPageInheritedWidget.data),
          OutlinedButton(
            child: const Text('Button A'),
            onPressed: () {
              testPageInheritedWidget.updateData('A');
            },
          ),
          OutlinedButton(
            child: const Text('Button B'),
            onPressed: () {
              testPageInheritedWidget.updateData('B');
            },
          ),
          OutlinedButton(
            child: const Text('Button C'),
            onPressed: () {
              testPageInheritedWidget.updateData('C');
            },
          ),
        ],
      ),
    );
  }
}