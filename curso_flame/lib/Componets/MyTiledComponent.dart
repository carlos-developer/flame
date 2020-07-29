import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/tiled_component.dart';
import 'package:flame/game/base_game.dart';
import 'package:flame/sprite.dart';
import 'package:flame/svg.dart';
import 'package:tiled/tiled.dart' show ObjectGroup, TmxObject;

class MyTiledComponent extends BaseGame{
  MyTiledComponent(){
    add(createTiledComponent());
  }

  createTiledComponent(){
    TiledComponent tiledComponent=TiledComponent("map.tmx");
    addCoinsInMap(tiledComponent);
    return tiledComponent;
  }

  addCoinsInMap(TiledComponent tiledComponent)async{
    final ObjectGroup objectGroup=await tiledComponent.getObjectGroupFromLayer("AnimatedCoins");

    if(objectGroup==null)
      return;

    objectGroup.tmxObjects.forEach((TmxObject element) {
      final comp=AnimationComponent.sequenced(20.0, 20.0, 'coins.png', 8,textureWidth: 20,textureHeight: 20);

      comp.x=element.x.toDouble();
      comp.y=element.y.toDouble();
      add(comp);
    });
  }
}
