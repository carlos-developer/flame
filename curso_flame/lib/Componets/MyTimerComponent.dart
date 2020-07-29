import 'package:flame/components/component.dart';
import 'package:flame/components/timer_component.dart';
import 'package:flame/game/base_game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/svg.dart';
import 'package:flame/text_config.dart';
import 'package:flame/time.dart';
import 'package:flutter/material.dart';

class MyTimerComponent extends BaseGame with TapDetector{
  Timer timer;
  MyTimerComponent(){
    timer=Timer(11,callback: checkFinish);
    add(RenderedTimerComponent(timer));
  }

  checkFinish(){
    if(timer.isFinished()){
      timer.stop();
    }
  }
  @override
  void onTap() {
    timer.start();
  }

  @override
  void update(double t) {
    timer.update(t);
  }
}

class RenderedTimerComponent extends TimerComponent{
  TextConfig textConfig=TextConfig(color: Colors.greenAccent);
  RenderedTimerComponent(Timer timer) : super(timer);

  @override
  void render(Canvas canvas) {
    textConfig.render(canvas, "Tiempo ${timer.current.round()}", Position(10,150));
  }
}
