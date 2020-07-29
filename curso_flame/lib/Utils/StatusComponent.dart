import 'dart:ui';

import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';

class StatusComponent extends BaseGame with TapDetector{
  Size size;
  CodyBoy codyBoy;
  StatusComponent(this.size){
    codyBoy=CodyBoy(size);
    add(codyBoy);
  }

  @override
  void update(double t) {
    codyBoy.update(t);
    super.update(t);
  }

  @override
  void onTap() {
    codyBoy.status=Status.crashed;
  }
}

enum Status{running,crashed}
class CodyBoy extends PositionComponent{
  AnimationComponent codyBoyRun;
  AnimationComponent codyBoyCrash;
  Status status=Status.running;
  Size size;
  CodyBoy(this.size):
      codyBoyRun= AnimationComponent(70,80,Animation.sequenced(
          "run.png", 4,amountPerRow: 4,stepTime: 0.2,textureHeight: 409,textureWidth: 294.75)),
        codyBoyCrash=AnimationComponent(70,80,Animation.sequenced(
            "crash.png", 2,amountPerRow: 2,stepTime: 0.2,textureHeight: 451,textureWidth: 321));
  @override
  void render(Canvas c) {
    currentCodyBoy.render(c);
  }


  @override
  void update(double dt) {
    currentCodyBoy.y=size.height-80;
    currentCodyBoy.update(dt);
    super.update(dt);
  }

  PositionComponent get currentCodyBoy {

    switch(status){
      case Status.running:
        return codyBoyRun;
      case Status.crashed:
        return codyBoyCrash;
    }
  }

}