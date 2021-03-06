import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tahiti/activity_model.dart';

class PaperActions extends StatefulWidget {
  final String action;
  final Function onClick;

  const PaperActions({Key key, this.action, this.onClick}) : super(key: key);
  @override
  PaperActionsState createState() {
    return new PaperActionsState();
  }
}

class PaperActionsState extends State<PaperActions> {
  Orientation orientation;
  Size size;
  @override
  Widget build(BuildContext context) {
    orientation = MediaQuery.of(context).orientation;
    size = MediaQuery.of(context).size;
    // TODO: implement build
    return ScopedModelDescendant<ActivityModel>(
        builder: (context, child, model) {
      if (widget.action == "backAction") {
        return Container(
          child: IconButton(
              icon: Icon(Icons.arrow_back),
              iconSize:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? size.width * .04
                      : size.width * .04,
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop('refresh');
              }),
        );
      } else if (widget.action == "saveAction") {
        return IconButton(
            icon: Icon(Icons.menu),
            iconSize: MediaQuery.of(context).orientation == Orientation.portrait
                ? size.width * .04
                : size.width * .05,
            color: Colors.white,
            onPressed: () {
              widget.onClick();
              Scaffold.of(context).showSnackBar(SnackBar(
                  duration: Duration(milliseconds: 1000),
                  content: Container(
                      height: 50.0,
                      child: Text(
                        "Image saved Successfully",
                        style: TextStyle(fontSize: 20.0),
                      ))));
            });
      } else if (widget.action == "UndoRedoAction") {
        return Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.undo),
                iconSize:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? size.height * .04
                        : size.height * .05,
                color: Colors.white,
                onPressed: model.canUndo() ? () => model.undo() : null),
            IconButton(
                icon: Icon(Icons.redo),
                iconSize:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? size.height * .04
                        : size.height * .05,
                color: Colors.white,
                onPressed: model.canRedo() ? () => model.redo() : null),
          ],
        );
      }
    });
  }
}
