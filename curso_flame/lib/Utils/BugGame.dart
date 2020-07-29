import 'dart:math';
import 'dart:ui';

import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' as color;

class BugGame extends BaseGame with HasTapableComponents{
  Size size;
  MyComposedComponent myComposedComponent;
  BugGame(this.size){
    myComposedComponent=MyComposedComponent(size);
    add(myComposedComponent);
  }

  @override
  void update(double t) {
    myComposedComponent.updateBugs(t);
    super.update(t);
  }

  @override
  Color backgroundColor() {
    return color.Colors.greenAccent;
  }
}

class MyComposedComponent extends PositionComponent with  HasGameRef, Tapable,ComposedComponent{
  Size size;
  MyComposedComponent(this.size);

  updateBugs(double t){
    for(final component in components){
      Bug bug =component as Bug;
      bug.updateBug(t);
    }

    if(components.isNotEmpty){
      final bug=components.elementAt(components.length-1) as Bug;
      if(bug.x<100 && components.length==1)
        addBug();
    }else{
      addBug();
    }
  }

  addBug(){
    components.add(Bug()..x=size.width..y=getRandom([size.height-80,size.height/2]));
  }
}
Random random=Random();
getRandom(List list){
  return list[random.nextInt(list.length)];
}
class Bug extends AnimationComponent{
  bool toRemove=false;
  double speed=10;
  Bug() : super(70, 80,
      Animation.sequenced("bug.png", 2,amountPerRow: 2,loop: true,stepTime: 0.2,textureHeight: 481,textureWidth: 582)){

    width=70.0*getRandom([1,2]);
  }

  updateBug(double t){
    if(toRemove)
      return;

    x-=speed*t*20;
    if(!isVisible)
      toRemove=true;
  }


  @override
  bool destroy() {
    return toRemove;
  }

  bool get isVisible=>x+width>0;

}