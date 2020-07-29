import 'package:flame/components/component.dart';
import 'package:flame/game/base_game.dart';
import 'package:flame/sprite.dart';

class MySpriteComponent extends BaseGame{
  MySpriteComponent(){
    add(createSpriteComponent());
  }

  createSpriteComponent(){
    Sprite sprite=Sprite("cody_all.png",x:313.6*2,width: 313.6,height: 456.0);
    return SpriteComponent.fromSprite(100, 100, sprite);
  }
}
