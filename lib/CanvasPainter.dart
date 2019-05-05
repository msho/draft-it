import 'package:flutter/material.dart';

class CanvasPainter extends ChangeNotifier implements CustomPainter {

  //region VARIABLES DECLARATION

  Color _strokeColor;
  Size _canvasSize;
  double _strokeWidth;
  List<List<Offset>> _strokes;
  List<List<Offset>> _gridStrokes;
  bool _isShowGrid;

  static const int GRID_SPACES = 10;

  //endregion

  //region INIT

  CanvasPainter() {
    /* **canvas init** */
    // default size. would change after app init and setCanvasSize is called
    _canvasSize = new Size(100, 100);

    /* **Brush init** */
    _strokeWidth = 2.5;
    _strokeColor = Colors.blue[900];

    /* Brush line containers */
    _strokes = new List<List<Offset>>();

    // default grid state MUST be false. as we init grid only after we get canvas size
    _isShowGrid = false;

  }

  void setCanvasSize(Size size) {
    _canvasSize = size;

    /* Grid lines init */
    _initGridLines();
  }

  //endregion

  void clearCanvas(){
    _strokes.clear();
    notifyListeners();
  }

  //region STROKE HANDLING

  void startStroke(Offset position) {
    print("startStroke");
    _strokes.add([position]);
    notifyListeners();
  } // startStroke

  void appendStroke(Offset position) {
    //print("appendStroke");
    var stroke = _strokes.last;

    if (position.dy < 0 || position.dx < 0) {
      print ('position ' + position.toString() + 'to small');
      return;
    }

    if (position.dy+3 > _canvasSize.height || position.dx+3 > _canvasSize.width) {
      print ('position ' + position.toString() + 'to big');
      print ('max size: ' + _canvasSize.toString());

      return;
    }


    stroke.add(position);
    notifyListeners();
  } // appendStroke

  void endStroke() {
    print("endStroke");
    notifyListeners();
  } // endStroke

  //endregion

  //region GRID

  void hideGrid() {
    _isShowGrid = false;
  }

  void showGrid() {
    _isShowGrid = true;
  }

  void _initGridLines() {

    // contain grid strokes
    _gridStrokes = new  List<List<Offset>>();

    // vertical grid lines
    for (double x = 0; x < _canvasSize.width; x += GRID_SPACES) {
      _gridStrokes.add(
          [
            new Offset(x, 0),
            new Offset(x, _canvasSize.height)
          ]
      );
    }

    // horizontal grid lines
    for (double y = 0; y < _canvasSize.height; y += GRID_SPACES) {
      _gridStrokes.add(
          [
            new Offset(0, y),
            new Offset(_canvasSize.width, y)
          ]
      );
    }

  }

  void _paintGrid(Canvas canvas) {
    Paint strokePaint = new Paint()
      ..color = Colors.black12
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (var stroke in _gridStrokes) {
      Path strokePath = new Path();
      strokePath.addPolygon(stroke, false);
      canvas.drawPath(strokePath, strokePaint);
    }

  }

  //endregion

  //region PAINT
  void _paintStrokes(Canvas canvas) {
    // TODO: show stroke size while painting strokes

    Paint strokePaint = new Paint()
      ..color = _strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth;

    for (var stroke in _strokes) {
      Path strokePath = new Path();
      strokePath.addPolygon(stroke, false);
      canvas.drawPath(strokePath, strokePaint);
    }
  }

  void _paintContainer(Size size, Canvas canvas) {
    var rect = Offset.zero & size;
    Paint fillPaint = new Paint()
      ..color = Colors.yellow[100]
      ..style = PaintingStyle.fill;

    canvas.drawRect(rect, fillPaint);
  } // paint

  @override
  void paint(Canvas canvas, Size size) {

    _paintContainer(size, canvas);

    _paintStrokes(canvas);

    if (_isShowGrid) {
      _paintGrid(canvas);
    }

  }

  //endregion

  //region OVERRIDES
  @override
  bool hitTest(Offset position) {
    return null;
  }

  @override
  // TODO: implement semanticsBuilder
  get semanticsBuilder => null;

  @override
  bool shouldRebuildSemantics(CustomPainter oldDelegate) {
    // TODO: implement shouldRebuildSemantics
    return null;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
  //endregion

} // CanvasPainter