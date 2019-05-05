
import 'package:flutter/material.dart';
import 'package:widget_fun/CanvasPainter.dart';

class PaintWidget extends StatefulWidget {
  PaintWidget({Key key}) : super(key: key);

  @override
  PaintWidgetState createState() => PaintWidgetState();

}

class PaintWidgetState extends State<PaintWidget> {
  GestureDetector _touch;
  CustomPaint _canvas;
  CanvasPainter _canvasPainter;

  void clearCanvas() {
    if (_canvasPainter == null) {
      print('canvasPainter null:( how come???');
      return;
    }

    _canvasPainter.clearCanvas();
  }

  void onGridStateChanged(bool isGridOn) {

    if (isGridOn)
      _canvasPainter.showGrid();
    else
      _canvasPainter.hideGrid();

    print('grid state is $isGridOn');
  }

  void panStart(DragStartDetails details) {
    print (details.globalPosition);

    RenderBox getBox = context.findRenderObject();
    Offset local = getBox.globalToLocal(details.globalPosition);

    _canvasPainter.startStroke(local);
  } // panStart

  void panUpdate(DragUpdateDetails details) {
    RenderBox getBox = context.findRenderObject();
    var local = getBox.globalToLocal(details.globalPosition);
    _canvasPainter.appendStroke(local);
    //canvasPainter.appendStroke(details.globalPosition);
  } // panUpdate

  void panEnd(DragEndDetails details) {
    _canvasPainter.endStroke();
  } // panEnd

  void _setCanvasPainterSize() {
    final RenderBox renderBoxRed = context.findRenderObject();
    _canvasPainter.setCanvasSize(renderBoxRed.size);
  }

   void _afterLayout(Duration d) {
     _setCanvasPainterSize();
   }

  @override
  void initState() {
    print('init state');
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    _canvasPainter = new CanvasPainter();
    super.initState();


  }

  @override
  Widget build(BuildContext context) {

    //touch
    _touch = new GestureDetector(
      onPanStart: panStart,
      onPanUpdate: panUpdate,
      onPanEnd: panEnd,
    );

    //canvas
    _canvas = new CustomPaint(
      painter: _canvasPainter,
      child: _touch,
    );

    Container container = new Container(
      //margin: new EdgeInsets.all(20.0),
        child: new ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: new Card(
              //elevation: 10.0,
              child: _canvas,
            )
        )
    );


    return container;
  } // build
} // PaintWidgetState