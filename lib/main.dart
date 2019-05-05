// This sample shows adding an action to an [AppBar] that opens a shopping cart.

import 'package:flutter/material.dart';

import 'package:widget_fun/PaintWidget.dart';
import 'package:widget_fun/SideWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String appTitle = 'Draft it';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainWidget(title: appTitle),
    );
  }
}

class MainWidget extends StatelessWidget {
  final String title;
  final GlobalKey<PaintWidgetState> _keyPaintWidget = GlobalKey();

  MainWidget({this.title, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Open menu',
            onPressed: () {
              _keyPaintWidget.currentState.clearCanvas();
            },
          ),
        ],
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: SideWidget(
                  onGridStateChanged:  (bool isGridOn)=> _keyPaintWidget.currentState.onGridStateChanged(isGridOn)
              )
            ),

            Flexible(
              flex: 6,
              child: PaintWidget(key: _keyPaintWidget),
            )
          ],
        )

      ),
    );
  } // build
}


