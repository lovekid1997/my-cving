import 'package:flutter/material.dart';

const _pushDistribute = Duration(milliseconds: 400);

class GridViewAnimation extends StatefulWidget {
  const GridViewAnimation({
    Key? key,
  }) : super(key: key);

  @override
  State<GridViewAnimation> createState() => _GridViewAnimationState();
}

class _GridViewAnimationState extends State<GridViewAnimation> {
  final _keys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];

  final List<GridAnimationObject> _gridAnimationObjects = [];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Positioned.fill(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: _keys.length,
              itemBuilder: (context, index) {
                return _ItemCard(
                  index: index,
                  key: _keys.elementAt(index),
                  create: create,
                );
              },
            ),
          ),
          Positioned.fill(
            child:
                _DistributeStack(gridAnimationObjects: _gridAnimationObjects),
          ),
        ],
      ),
    );
  }

  Offset? root;

  void create(GlobalKey globalKey, int index) {
    final myOffset = getLocalOffsetByKey(globalKey)!;
    final size = getSizeByKey(globalKey);
    root ??= index == 0 ? myOffset : null;
    _gridAnimationObjects.add(GridAnimationObject(
      globalKey: globalKey,
      myOffset: myOffset,
      rootOffset: root,
      size: size,
      index: 0,
    ));
    if (_gridAnimationObjects.length == _keys.length) {
      setState(() {});
    }
  }
}

class _DistributeStack extends StatefulWidget {
  const _DistributeStack({required this.gridAnimationObjects});
  final List<GridAnimationObject> gridAnimationObjects;
  @override
  State<_DistributeStack> createState() => _DistributeStackState();
}

class _DistributeStackState extends State<_DistributeStack> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(
        widget.gridAnimationObjects.length,
        (index) => _DistributeAnimationItem(
          gridAnimationObject: widget.gridAnimationObjects.elementAt(index),
          index: index,
        ),
      ),
    );
  }
}

class _DistributeAnimationItem extends StatefulWidget {
  const _DistributeAnimationItem({
    required this.gridAnimationObject,
    required this.index,
  });
  final GridAnimationObject gridAnimationObject;
  final int index;
  @override
  State<_DistributeAnimationItem> createState() =>
      _DistributeAnimationItemState();
}

class _DistributeAnimationItemState extends State<_DistributeAnimationItem>
    with TickerProviderStateMixin {
  late Animation<Offset> animation;
  late AnimationController animationController;
  bool _hidden = false;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: _pushDistribute,
    );
    animation = Tween<Offset>(
      begin: Offset.zero,
      end: (widget.gridAnimationObject.myOffset! -
          widget.gridAnimationObject.rootOffset!),
    ).animate(animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _hidden = true;
        }
      });
    animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: animation.value.dx,
      top: animation.value.dy,
      child: Opacity(
        opacity: _hidden ? 0 : 1,
        child: Container(
          height: widget.gridAnimationObject.height,
          width: widget.gridAnimationObject.width,
          color: Colors.amber,
          child: const Text('test1'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class _ItemCard extends StatefulWidget {
  const _ItemCard({
    Key? key,
    required this.index,
    required this.create,
  }) : super(key: key);
  final int index;
  final Function(GlobalKey, int index) create;
  @override
  State<_ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<_ItemCard> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.create(widget.key as GlobalKey, widget.index);
    });
    animationController = AnimationController(
      vsync: this,
      duration: _pushDistribute,
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
    animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: animation.value >= 1 ? 1 : 0,
      child: Container(
        color: Colors.amber,
        child: const Text('test'),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class GridAnimationObject {
  final GlobalKey globalKey;
  Offset? rootOffset;
  Offset? myOffset;
  Size? size;
  final int index;
  GridAnimationObject({
    required this.globalKey,
    required this.rootOffset,
    required this.myOffset,
    required this.size,
    required this.index,
  });

  double? get width => size?.width;
  double? get height => size?.height;

  Offset get leftPosition => rootOffset! - myOffset!;
}

Offset? getGlobalOffsetByKey(GlobalKey key) {
  final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
  final offSet = renderBox?.globalToLocal(Offset.zero);
  return offSet;
}

Offset? getLocalOffsetByKey(GlobalKey key) {
  final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
  final offSet = renderBox?.localToGlobal(Offset.zero);
  return offSet;
}

Size? getSizeByKey(GlobalKey key) {
  final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
  final size = renderBox?.size;
  return size;
}
/// my print
//  print('parrentOffset  $parrentOffset');
//     Future.delayed(
//         const Duration(milliseconds: 1), () => print('offSet  $myOffset'));