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

class MyGame extends FlameGame with HasTappables {
  SpriteComponent girl = SpriteComponent();
  SpriteComponent boy = SpriteComponent();
  SpriteComponent background = SpriteComponent();
  final double charaterSize = 400;
  final textBoxHeight = 100;
  DialogButton dialogButton = DialogButton();

  TextPaint dialogTextPaint =
      TextPaint(style: const TextStyle(fontSize: 36, color: Colors.white));
  int dialogTextLevel = -1;
  @override
  onLoad() async {
    super.onLoad();
    final screenWidth = size[0];
    final screenHeight = size[1];
    add(background
      ..sprite = await loadSprite('background.jpg')
      ..size = Vector2(screenWidth, screenHeight - textBoxHeight));
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
    dialogButton
      ..sprite = await loadSprite('next.png')
      ..size = Vector2(50, 50)
      ..position = Vector2(screenWidth - 50, screenHeight - 50);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (girl.x < size.x / 2 - 150) {
      girl.x += dt * 150;
      if (girl.x > 50 && dialogTextLevel == -1) {
        dialogTextLevel = 0;
      }
      if (girl.x > 200) {
        dialogTextLevel = 1;
      }
    } else {
      if (boy.isFlippedHorizontally) {
        boy.flipHorizontally();
      }
    }
    if (boy.x > size.x / 2 - 50) {
      boy.x -= dt * 150;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    switch (dialogTextLevel) {
      case 0:
        dialogTextPaint.render(
            canvas, 'test', Vector2(10, size[1] - textBoxHeight));
        break;
      case 1:
        dialogTextPaint.render(canvas, '                dialogTextPaint test',
            Vector2(10, size[1] - textBoxHeight));
        if (!dialogButton.isMounted) {
          add(dialogButton);
        }
        break;
    }
  }
}

class DialogButton extends SpriteComponent with Tappable {
  @override
  bool onTapDown(info) {
    try {
      print('onTapDown');
      return true;
    } catch (e) {
      return false;
    }
  }
}
