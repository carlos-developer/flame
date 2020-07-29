import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/game/base_game.dart';
import 'package:flame/sprite.dart';

class MyAnimationComponent extends BaseGame{
  MyAnimationComponent(){
    add(createMyAnimationComponent());
  }

  createMyAnimationComponent(){
    return AnimationComponent.sequenced(100, 100, "run.png",4,
        amountPerRow:4,loop: false,stepTime: 0.2,
        textureX:0,textureY: 0,textureHeight: 409,textureWidth:294.75 );
  }
}
