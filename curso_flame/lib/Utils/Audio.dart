import 'package:flame/bgm.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';

class MyAudio extends BaseGame with TapDetector,DoubleTapDetector{
  Bgm bgm=Bgm();

  @override
  void onTapDown(TapDownDetails details) {
    bgm.play("music.mp3",volume: 5);
  }

  @override
  void onTapUp(TapUpDetails details) {
    bgm.stop();
  }

  @override
  void onDoubleTap() {
    Flame.audio.play("laser.mp3",volume: 5.0);
  }
}