import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});
  static const String name = 'games';

  static const String path = 'games';

  static void pushPage(BuildContext context) => context.goNamed(path);

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: MyGame(),
    );
  }
}

class MyGame extends FlameGame {
  SpriteComponent girl = SpriteComponent();
  SpriteComponent boy = SpriteComponent();
  SpriteComponent background = SpriteComponent();
  final double charaterSize = 400;
  bool boyFilp = true;
  @override
  onLoad() async {
    super.onLoad();
    final screenWidth = size[0];
    final screenHeight = size[1];
    const textBoxHeight = 100;
    add(background
      ..sprite = await loadSprite('background.jpg')
      ..size = size);
    girl
      ..sprite = await loadSprite('girl.png')
      ..size = Vector2(charaterSize, charaterSize)
      ..y = screenHeight / 2 - charaterSize / 2 - textBoxHeight
      ..anchor = Anchor.topCenter;
    boy
      ..sprite = await loadSprite('boy.png')
      ..size = Vector2(charaterSize, charaterSize)
      ..y = screenHeight / 2 - charaterSize / 2 - textBoxHeight
      ..x = screenWidth - charaterSize
      ..anchor = Anchor.topCenter
      ..flipHorizontally();
    addAll([girl, boy]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (girl.x < size.x / 2 - 150) {
      girl.x += dt * 150;
    } else {
      if (boy.isFlippedHorizontally) {
        boy.flipHorizontally();
      }
    }
    if (boy.x > size.x / 2 - 50) {
      boy.x -= dt * 150;
    }
  }
}
