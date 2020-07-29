import 'package:flame/components/component.dart';
import 'package:flame/components/parallax_component.dart';
import 'package:flame/game/base_game.dart';
import 'package:flame/sprite.dart';
import 'package:flame/svg.dart';
import 'package:flutter/cupertino.dart';

class MyParallaxComponent extends BaseGame{
  MyParallaxComponent(){
    add(createParallaxComponent());
  }

  createParallaxComponent(){
    final horizontal=[
      ParallaxImage("horizontal_background.png"),
      ParallaxImage("horizontal_Clouds.png"),
      ParallaxImage("horizontal_Rocks.png"),
      ParallaxImage("horizontal_Hills_2.png"),
      ParallaxImage("horizontal_Hills_1.png"),
      ParallaxImage("horizontal_Trees.png",repeat: ImageRepeat.noRepeat,),
      ParallaxImage("horizontal_Ground.png"),
    ];
    final vertical=[
      ParallaxImage("vertical_sky.png",fill:LayerFill.width,alignment:Alignment.center,repeat: ImageRepeat.repeatY),
      ParallaxImage("vertical_clouds.png",alignment:Alignment.center,repeat: ImageRepeat.repeatY),
      ParallaxImage("vertical_background_grass.png",fill:LayerFill.width,alignment:Alignment.center,repeat: ImageRepeat.repeatY),
    ];
    return ParallaxComponent(vertical,layerDelta: const Offset(0, 20),baseSpeed:const Offset(0, 20) );
  }
}
