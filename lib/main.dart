import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:santafalling/Classes/MyGame.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.images.loadAll(<String>["cTree.jpg"]);
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
