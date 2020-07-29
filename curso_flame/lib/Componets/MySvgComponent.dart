import 'package:flame/components/component.dart';
import 'package:flame/game/base_game.dart';
import 'package:flame/sprite.dart';
import 'package:flame/svg.dart';

class MySvgComponent extends BaseGame{
  MySvgComponent(){
    add(createSvgComponent());
  }

  createSvgComponent(){
    Svg svg=Svg("cody_boy.svg");
    return SvgComponent.fromSvg(300, 400, svg);
  }
}
