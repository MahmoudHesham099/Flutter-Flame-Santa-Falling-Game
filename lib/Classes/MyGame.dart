import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'package:santafalling/Classes/BG.dart';
import 'package:santafalling/Classes/Santa.dart';
import 'package:flame/game.dart';

class MyGame extends BaseGame with TapDetector {
  Santa santa;

  MyGame(Size size) {
    //initialize the game
    add(BG());
    add(santa = Santa());
  }

  @override
  void onTap() {
    santa.onTap();
  }
}
