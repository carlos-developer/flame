import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/text_box_component.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/game/base_game.dart';
import 'package:flame/palette.dart';
import 'package:flame/sprite.dart';
import 'package:flame/svg.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';

TextConfig regular=TextConfig(color:Colors.white );
TextConfig tiny=regular.withFontSize(15.0);
class MyTextComponent extends BaseGame{
  MyTextComponent(){
    add(MyTextBoxComponent("Hola a todos bienvenidos al curso de flame sssasasasas")..y=200.0);
    add(createTextComponent());
  }

  createTextComponent(){
    return TextComponent("CodigoFacilito",config: regular)..y=32.0;
  }
  
  
}

class MyTextBoxComponent extends TextBoxComponent{
  MyTextBoxComponent(String text) : super(text,config:tiny,boxConfig:const TextBoxConfig(timePerChar: 0.05));

  @override
  void drawBackground(Canvas c) {
    Rect rect=Rect.fromLTWH(0, 0, width, height);
    c.drawRect(rect, Paint()..color=Colors.greenAccent);
    c.drawRect(rect.deflate(boxConfig.margin),  Paint()..color=Colors.black26..style=PaintingStyle.stroke);

  }
}

