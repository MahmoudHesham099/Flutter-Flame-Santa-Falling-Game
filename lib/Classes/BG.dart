import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class BG extends Component with Resizable {
  Rect screen;
  Sprite _tree;

  BG() {
    _tree = Sprite('cTree.jpg');
  }

  @override
  void render(Canvas c) {
    _tree.renderRect(c, screen);
  }

  @override
  void update(double t) {
    //our bg noy update so will do nothing here
  }

  @override
  void resize(Size size) {
    screen = Rect.fromLTWH(0, 0, size.width, size.height);
  }
}
