import 'package:curso_flame/Model/TextureCollision.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/sprite_batch_component.dart';
import 'package:flame/game/base_game.dart';
import 'package:flame/sprite.dart';
import 'package:flame/sprite_batch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySpriteBatchComponent extends BaseGame{
  double startY;
  double axisY=0.0;
  double axisX=0.0;
  double scale=0.3;
  Size size;
  MySpriteBatchComponent(this.size){
    createMySpriteBatchComponent().then((value) => add(value))  ;
  }

  Future createMySpriteBatchComponent()async{
   SpriteBatch spriteBatch=await SpriteBatch.withAsset("texture.png");

   List<TextureCollision>listPlatform=[
     TextureCollision(
       key:"leafyGround" ,
       xStart:0,
       xEnd: 128*7*scale,
       yStart:size.height-128*scale,
       yEnd: size.height-128*1*scale,
       xAtlas: 1,
       yAtlas: 1
     ), TextureCollision(
         key:"rocky" ,
         xStart:128*9*scale,
         xEnd: 128*11*scale,
         yStart:size.height-128*3*scale,
         yEnd: size.height-128*4*scale,
         xAtlas: 3,
         yAtlas: 2
     ), TextureCollision(
         key:"leafy" ,
         xStart:0,
         xEnd: 128*6*scale,
         yStart:size.height-128*4*scale,
         yEnd: size.height-128*5*scale,
         xAtlas:0,
         yAtlas: 1
     ),TextureCollision(
         key:"leafy" ,
         xStart:0,
         xEnd: 128*6*scale,
         yStart:size.height-128*4*scale,
         yEnd: size.height-128*5*scale,
         xAtlas:0,
         yAtlas: 1
     ),TextureCollision(
         key:"ground" ,
         xStart:128*4*scale,
         xEnd: 128*5*scale,
         yStart:size.height-128*5*scale,
         yEnd: size.height-128*7*scale,
         xAtlas:3,
         yAtlas: 1
     ),
   ];

   List<TextureCollision>listDeath=[
     TextureCollision(
         key:"water" ,
         xStart:128*8*scale,
         xEnd: 128*13*scale,
         yStart:size.height-128*scale,
         yEnd: size.height-128*1*scale,
         xAtlas: 2,
         yAtlas: 3
     ),TextureCollision(
         key:"lave" ,
         xStart:0,
         xEnd: 128*3*scale,
         yStart:size.height-128*5*scale,
         yEnd: size.height-128*6*scale,
         xAtlas:1,
         yAtlas: 3
     ),
   ];
   startY=size.height-128.0*scale;
   axisY=startY;
   axisX=0.0;
   while(axisY>0){
     addSpriteBatch(spriteBatch,listPlatform,axisX,axisY,);
     addSpriteBatch(spriteBatch,listDeath,axisX,axisY,);

     axisX=axisX + 128.0*scale;
     if(axisX>size.width){
       axisY= axisY - 128.0 *scale;
       axisX=0;
     }
   }

   return SpriteBatchComponent.fromSpriteBatch(spriteBatch);
  }

  validateTexture(axisX,axisY,TextureCollision textureCollision){
    return axisX>=textureCollision.xStart && axisX<= textureCollision.xEnd && axisY<=textureCollision.yStart && axisY>=textureCollision.yEnd;
  }
  addSpriteBatch(SpriteBatch spriteBatch,List<TextureCollision>list,axisX,axisY){
    double rotation=0.0;
    Color color;
    for(TextureCollision textureCollision in list){
      if(validateTexture(axisX,axisY,textureCollision)){
        if(textureCollision.key=="water"){
          rotation=90;
          color=Colors.pink;
        }
        spriteBatch.add(rotation:rotation ,
          color: color,
          scale:scale,
          rect:Rect.fromLTWH(textureCollision.xAtlas* 128.0, textureCollision.yAtlas* 128.0, 128, 128),
          offset:Offset(axisX,axisY)
        );
      }
    }
  }
}
