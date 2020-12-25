import 'package:flame/anchor.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flutter/material.dart';
import 'package:santafalling/constants.dart';
import 'package:flame/position.dart';

class Santa extends AnimationComponent with Resizable {
  double speedY = 0;
  bool frozen = true;
  Santa()
      : super.sequenced(
          SIZE,
          SIZE,
          'santa.png',
          1,
          textureWidth: 600,
          textureHeight: 600,
        ) {
    this.anchor = Anchor.center;
  }

  Position get velocity => Position(300, speedY);

  reset() {
    this.x = size.width / 3;
    this.y = size.height / 5;
    speedY = 0;
    frozen = true;
    angle = 0;
  }

  @override
  void resize(Size size) {
    super.resize(size);
    reset();
  }

  @override
  void update(double t) {
    super.update(t);
    if (frozen) return;
    this.y += speedY * t - GRAVITY * t * t / 2;
    this.speedY += GRAVITY * t;
    this.angle = velocity.angle();

    try {
      if (y > size.height) {
        reset();
      }
    } catch (e) {
      print(e);
    }
  }

  onTap() {
    if (frozen) {
      frozen = false;
    } else {
      speedY = (speedY + BOOST).clamp(BOOST, speedY);
    }
  }
}
