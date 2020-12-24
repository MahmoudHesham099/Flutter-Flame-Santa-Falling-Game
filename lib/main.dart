import 'package:flame/anchor.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/position.dart';
import 'package:flutter/material.dart';

const GRAVITY = 400.0;
const BOOST = -250.0;
const SIZE = 100.0;
const COLOR = const Color(0xffddc0a3);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final gameSize = await Flame.util.initialDimensions();

  final game = MyGame(gameSize);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: game.widget,
      ),
    ),
  );
}

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

class BG extends Component with Resizable {
  static final Paint _paint = Paint()..color = COLOR;

  @override
  void render(Canvas c) {
    c.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), _paint);
  }

  @override
  void update(double t) {
    //our bg noy update so will do nothing here
  }
}

class Santa extends AnimationComponent with Resizable {
  double speedY = 0;
  bool frozen = true;
  Santa()
      : super.sequenced(
          SIZE,
          SIZE,
          'bird.png',
          4,
          textureWidth: 16,
          textureHeight: 16,
        ) {
    this.anchor = Anchor.center;
  }

  Position get velocity => Position(300, speedY);

  reset() {
    this.x = size.width / 2;
    this.y = size.height / 2;
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
