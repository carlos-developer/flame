import 'dart:ui';

import 'package:flame/game/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/keyboard.dart';
import 'package:flutter/material.dart';

class MyGame extends Game with HasWidgetsOverlay,TapDetector,DoubleTapDetector,LongPressDetector,PanDetector,KeyboardEvents {
  double width;
  double height;
  Color color=Colors.brown;
  List<Offset>points=<Offset>[];


  void update(double t) {}

  void render(Canvas canvas) {
    Paint paint =Paint()..color=color
        ..strokeCap=StrokeCap.round
        ..strokeWidth=5.0;
    for(int i=0; i<points.length-1;i++){
      if(points[i]!=null && points[i+1]!=null)
        canvas.drawLine(points[i], points[i+1], paint);
    }
  }

  @override
  Color backgroundColor() {
    return Colors.greenAccent;
  }

  void resize(Size size) {
    width = size.width;
    height = size.height;
    createMenu();
  }

  void lifecycleStateChange(AppLifecycleState state) {
    print("lifecycle $state");
  }

  createMenu() {
    addWidgetOverlay(
        "menu",
        Center(
            child: Container(
              color: Colors.redAccent,
                width: 100,
                height: 100,
                child: Column(
                  children: <Widget>[
                    FlatButton(
                      child: Text("Reiniciar"),
                      onPressed: onRestart,
                    ),
                    FlatButton(
                      child: Text("Continuar"),
                      onPressed: onContinue,
                    )
                  ],
                ))));
  }

  onRestart() {}

  onContinue() {
    removeWidgetOverlay("menu");
  }

  @override
  void onTap() {
    color=Colors.red;
  }

  @override
  void onDoubleTap() {
    color=Colors.pink;
  }

  @override
  void onLongPress() {
    color=Colors.blueAccent;
  }

  @override
  void onPanUpdate(DragUpdateDetails details) {
    points=List.from(points)..add(details.localPosition);
  }

  @override
  void onPanEnd(DragEndDetails details) {
    points=<Offset>[];
  }

  @override
  void onKeyEvent(RawKeyEvent event) {
   if(event.data.keyLabel=="a")
     color=Colors.black;
  }
}
