import 'package:flutter/material.dart';
import 'package:my_cving/app/config/constant.dart';

class GridViewAnimation extends StatefulWidget {
  const GridViewAnimation({
    Key? key,
  }) : super(key: key);

  @override
  State<GridViewAnimation> createState() => _GridViewAnimationState();
}

class _GridViewAnimationState extends State<GridViewAnimation> {
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      key: _key,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return _Item(index: index, parrentKey: _key);
        },
      ),
    );
  }
}

class _Item extends StatefulWidget {
  const _Item({
    Key? key,
    required this.index,
    required this.parrentKey,
  }) : super(key: key);
  final int index;
  final GlobalKey<State<StatefulWidget>> parrentKey;
  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> with TickerProviderStateMixin {
  final GlobalKey _key = GlobalKey();
  late Animation<Offset> animation;
  late final AnimationController animationController;
  late Tween<Offset> tween;
  late Offset? myOffset;
  late Offset? parrentOffset;
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    tween = Tween<Offset>(
      begin: Offset(-1, -1),
      end: Offset.zero,
    );
    animation = tween.animate(animationController)
      ..addListener(() {
        setState(() {});
      });
    animationController.forward();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myOffset = getOffsetByKey(_key);
      parrentOffset = getOffsetByKey(widget.parrentKey);
      print('parrentOffset  $parrentOffset');
      Future.delayed(
          const Duration(milliseconds: 1), () => print('offSet  $myOffset'));
      Future.delayed(
        const Duration(seconds: 4),
        () {
          myOffset = getOffsetByKey(_key);
          print('offSet  $myOffset');
          // print('run animation');
          // tween = Tween<Offset>(
          //   begin: myOffset!,
          //   end: parrentOffset!,
          // );
          // animationController.reset();
          // animationController.forward();
        },
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print('rebuild ${animation.value}');
    return Container(
      key: _key,
      color: Colors.amber,
      child: const Text('tes'),
      transform: Matrix4.translationValues(420.0,  64.0, 0.0),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class GridObject {
  final GlobalKey key;
  GridObject(this.key);
}

Offset? getOffsetByKey(GlobalKey key) {
  final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
  final offSet = renderBox?.localToGlobal(Offset.zero);
  return offSet;
}
/// my print
//  print('parrentOffset  $parrentOffset');
//     Future.delayed(
//         const Duration(milliseconds: 1), () => print('offSet  $myOffset'));