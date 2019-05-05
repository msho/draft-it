import 'package:flutter/material.dart';

class SideWidget extends StatefulWidget {
  final void Function(bool gridState) onGridStateChanged;

  SideWidget({this.onGridStateChanged, Key key}) : super(key: key);


  @override
  _SideWidget createState() => _SideWidget();


}

class _SideWidget extends State<SideWidget> {

  var gridState = {
    "current": "off",
    "off": Icons.grid_on,
    "on": Icons.grid_off,
  };

  void _changeGridState(){
    bool isGridOn = gridState["current"] == "on";

    // tell parent that grid is changed
    widget.onGridStateChanged(!isGridOn);

    if (isGridOn)
      _hideGrid();
    else
      _showGrid();
  }
  void _showGrid(){
    setState(() {
      gridState["current"] = "on";
    });

  }

  void _hideGrid(){
    setState(() {
      gridState["current"] = "off";
    });
  }

  void _drawDoor(){
    // TODO: implement draw door
  }

  // TODO: new stroke button that would only draw straight lines (very sharp turn is new line)
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          FlatButton(
            onPressed: _changeGridState,
            child: Icon(gridState[gridState["current"]]),
          ),
          FlatButton(
            onPressed: _drawDoor,
            child:  Icon(Icons.exit_to_app),
          )
        ],
      ),
    );
  }

}