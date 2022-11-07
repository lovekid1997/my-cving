import 'dart:async';

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

const _dealDuration = Duration(milliseconds: 350);
const _fadeInitDuration = Duration(milliseconds: 500);
const _curves = Curves.decelerate;

class GridViewAnimation extends StatefulWidget {
  const GridViewAnimation({
    Key? key,
    required this.children,
    required this.delegate,
    this.controller,
    this.defaultDuration = _dealDuration,
    this.delayPerItem = false,
    this.initialFadeAnimation = true,
    this.fadeAnimation = true,
  }) : super(key: key);

  final List<Widget> children;
  final SliverGridDelegate delegate;

  /// Used to refresh, create, return to the original state for gridView
  /// use ful because we canceled if instance exists
  final GridViewAnimationController? controller;

  /// default use [_dealDuration]
  final Duration defaultDuration;

  /// If it is [True], it will be similar to dealing with 52 cards
  final bool delayPerItem;

  /// Initial effect of the first element [createFadeAnimation]
  final bool initialFadeAnimation;

  /// Eeffect of the all element
  /// available when [delayPerItem] is [True]
  final bool fadeAnimation;

  @override
  State<GridViewAnimation> createState() => _GridViewAnimationState();
}

class _GridViewAnimationState extends State<GridViewAnimation> {
  // state
  final List<_GridAnimationObject> _gridAnimationObjects = [];
  final List<_GridAnimationObject> _gridAnimationDealObjects = [];
  Offset? rootOffset;

  // getter
  bool get delayPerItem => widget.delayPerItem;
  bool get initialFadeAnimation => widget.initialFadeAnimation;
  bool get fadeAnimation => widget.fadeAnimation;

  @override
  void initState() {
    // parse children to gridAnimationObject
    // Initialize key and type index
    widget.children.forEachIndexed((index, child) {
      _gridAnimationObjects.add(_GridAnimationObject.init(
        index,
        child,
        widget.controller?._animationActionStream,
      ));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GridView.builder(
            gridDelegate: widget.delegate,
            itemCount: _gridAnimationObjects.length,
            itemBuilder: (_, i) {
              return _Card(
                gridAnimationObject: _gridAnimationObjects.elementAt(i),
                create: _create,
                delayPerItem: delayPerItem,
                initialFadeAnimation: initialFadeAnimation,
              );
            },
          ),
        ),
        Positioned.fill(
          child: _DealStack(
            gridAnimationDealObjects: _gridAnimationDealObjects,
            delayPerItem: delayPerItem,
            initialFadeAnimation: initialFadeAnimation,
            fadeAnimation: fadeAnimation,
          ),
        ),
      ],
    );
  }

  void _create(_GridAnimationObject gridAnimationObject) {
    final globalKey = gridAnimationObject.globalKey;
    final index = gridAnimationObject.index;
    final myOffset = getLocalOffsetByKey(globalKey)!;
    final size = getSizeByKey(globalKey);
    rootOffset ??= index == 0 ? myOffset : null;
    _gridAnimationObjects[index].copyWith(
      rootOffset: rootOffset,
      myOffset: myOffset,
      size: size,
    );
    _gridAnimationDealObjects.add(_gridAnimationObjects[index]);
    setState(() {});
  }
}

class _DealStack extends StatelessWidget {
  const _DealStack({
    required this.gridAnimationDealObjects,
    required this.delayPerItem,
    required this.initialFadeAnimation,
    required this.fadeAnimation,
  });

  final List<_GridAnimationObject> gridAnimationDealObjects;
  final bool delayPerItem;
  final bool initialFadeAnimation;
  final bool fadeAnimation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(
        gridAnimationDealObjects.length,
        (index) => _DealCard(
          gridAnimationDealObject: gridAnimationDealObjects.elementAt(index),
          delayPerItem: delayPerItem,
          initialFadeAnimation: initialFadeAnimation,
          fadeAnimation: fadeAnimation,
        ),
      ),
    );
  }
}

class _DealCard extends StatefulWidget {
  const _DealCard({
    required this.gridAnimationDealObject,
    required this.delayPerItem,
    required this.initialFadeAnimation,
    required this.fadeAnimation,
  });

  final _GridAnimationObject gridAnimationDealObject;
  final bool delayPerItem;
  final bool initialFadeAnimation;
  final bool fadeAnimation;
  @override
  State<_DealCard> createState() => _DealCardState();
}

class _DealCardState extends State<_DealCard> with TickerProviderStateMixin {
  // animation
  late Animation<Offset> transitionAnimation;
  Animation<double>? fadeAnimation;
  late AnimationController animationController;

  // fade initial animation
  Animation<double>? initFadeAnimation;
  AnimationController? initFadeAnimationController;

  // state
  bool _hidden = false;
  Timer? delayedStartAnimationCardDeal;

  // getter
  _GridAnimationObject get gridAnimationObject =>
      widget.gridAnimationDealObject;

  @override
  void initState() {
    /// The initial effect renders the first element
    /// control by [initialFadeAnimation]
    final createSuccessInItFadeAnimation = createInitFadeAnimation();

    // create transition animation
    createTransitionAnimation();

    /// create effect all element
    /// control by [fadeAnimation]
    createFadeAnimation();

    ///
    if (!createSuccessInItFadeAnimation) {
      startAnimation();
      addListenController();
    }

    super.initState();
  }

  /// [startAnimation] use when [initialFadeAnimation] is [True] and animation status complete
  bool createInitFadeAnimation() {
    if (!widget.initialFadeAnimation) {
      return false;
    }
    // animation
    initFadeAnimationController = AnimationController(
      vsync: this,
      duration: _fadeInitDuration,
    );
    initFadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: initFadeAnimationController!,
      curve: _curves,
      reverseCurve: _curves,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        switch (status) {
          case AnimationStatus.completed:
            startAnimation();
            addListenController();
            break;
          default:
            break;
        }
      });
    initFadeAnimationController!.forward();
    return true;
  }

  void createTransitionAnimation() {
    // animation
    animationController = AnimationController(
      vsync: this,
      duration: _dealDuration,
      reverseDuration: _dealDuration,
    );
    transitionAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: calcOffsetEndItem,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: _curves,
      reverseCurve: _curves,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        switch (status) {
          case AnimationStatus.dismissed:
            break;
          case AnimationStatus.forward:
            break;
          case AnimationStatus.reverse:
            _hidden = false;
            break;
          case AnimationStatus.completed:
            _hidden = true;
            break;
        }
      });
  }

  void createFadeAnimation() {
    if (!widget.fadeAnimation) {
      return;
    }
    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: _curves,
        reverseCurve: _curves,
      ),
    );
  }

  /// add listener reverse transion animation [transitionAnimation], cancel [delayedStartAnimationCardDeal] when refresh
  /// call when [animationController], [delayedStartAnimationCardDeal] has created
  /// call after [startAnimation]
  void addListenController() {
    gridAnimationObject.addListenRefreshOnDealCard(
      animationController,
      delayedStartAnimationCardDeal,
      startAnimation,
    );
  }

  /// create [delayedStartAnimationCardDeal]
  /// call before [addListenController]
  void startAnimation() {
    delayedStartAnimationCardDeal = Timer(
      deplayPerItemDuration(
        widget.delayPerItem,
        gridAnimationObject.index,
      ),
      () {
        animationController.forward();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: transitionAnimation.value.dx,
      top: transitionAnimation.value.dy,
      child: Opacity(
        opacity: opacity,
        child: Visibility(
          visible: !_hidden,
          child: SizedBox.fromSize(
            size: gridAnimationObject.size,
            child: gridAnimationObject.child,
          ),
        ),
      ),
    );
  }

  // getter
  double get opacity {
    if (gridAnimationObject.firstItem) {
      return initFadeAnimation?.value ?? 1;
    }
    return fadeAnimation?.value ?? 1;
  }

  Offset get calcOffsetEndItem =>
      (gridAnimationObject.myOffset! - gridAnimationObject.rootOffset!);

  @override
  void dispose() {
    animationController.dispose();
    initFadeAnimationController?.dispose();
    delayedStartAnimationCardDeal?.cancel();
    delayedStartAnimationCardDeal = null;
    gridAnimationObject.dispose();
    super.dispose();
  }
}

class _Card extends StatefulWidget {
  const _Card({
    Key? key,
    required this.create,
    required this.delayPerItem,
    required this.gridAnimationObject,
    required this.initialFadeAnimation,
  }) : super(key: key);
  final Function(_GridAnimationObject) create;
  final bool delayPerItem;
  final _GridAnimationObject gridAnimationObject;
  final bool initialFadeAnimation;

  @override
  State<_Card> createState() => _CardState();
}

class _CardState extends State<_Card> with TickerProviderStateMixin {
  // animation
  late Animation<double> animation;
  late AnimationController animationController;

  // state
  Timer? delayedStartAnimationCard;
  bool firstTimeBuild = true;

  // getter
  _GridAnimationObject get gridAnimationObject => widget.gridAnimationObject;
  int get index => widget.gridAnimationObject.index;

  @override
  void initState() {
    // get renderBox
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.create(gridAnimationObject);
    });
    createAnimationOpacity();
    startAnimation();
    addListenController();
    super.initState();
  }

  void createAnimationOpacity() {
    // animation
    animationController = AnimationController(
      vsync: this,
      duration: _dealDuration,
      reverseDuration: _dealDuration,
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: _curves,
      reverseCurve: _curves,
    ))
      ..addListener(() {
        setState(() {});
      });
  }

  /// plus _fadeInitDuration when first time build widget and initialFadeAnimation = [True]
  void startAnimation() {
    var delayDuration = deplayPerItemDuration(
      widget.delayPerItem,
      index,
    );
    if (firstTimeBuild) {
      delayDuration = widget.initialFadeAnimation
          ? _fadeInitDuration + delayDuration
          : delayDuration;
    }
    delayedStartAnimationCard = Timer(delayDuration, () {
      animationController.forward();
    });
    firstTimeBuild = false;
  }

  void addListenController() {
    gridAnimationObject.addListenRefreshOnCard(
      animationController,
      delayedStartAnimationCard,
      startAnimation,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: gridAnimationObject.globalKey,
      child: Opacity(
        opacity: animation.value >= 1 ? 1 : 0,
        child: gridAnimationObject.child,
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    delayedStartAnimationCard?.cancel();
    delayedStartAnimationCard = null;
    super.dispose();
  }
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

Duration deplayPerItemDuration(bool delayPerItem, int index) =>
    delayPerItem ? (_dealDuration * index) : Duration.zero;

enum GridViewAnimationAction {
  refresh,
  deal,
  cancel,
}

class GridViewAnimationController {
  late final StreamController<GridViewAnimationAction> _animationActionStream;
  GridViewAnimationController()
      : _animationActionStream =
            StreamController<GridViewAnimationAction>.broadcast();

  void refresh() {
    _animationActionStream.sink.add(GridViewAnimationAction.refresh);
  }

  void deal() {
    _animationActionStream.sink.add(GridViewAnimationAction.deal);
  }

  void cancel() {
    _animationActionStream.sink.add(GridViewAnimationAction.cancel);
  }

  dispose() {
    _animationActionStream.close();
  }
}

class _GridAnimationObject {
  final GlobalKey globalKey;
  final int index;
  final Widget child;
  final StreamController<GridViewAnimationAction>? animationActionStream;
  Offset? rootOffset;
  Offset? myOffset;
  Size? size;

  _GridAnimationObject({
    required this.globalKey,
    required this.index,
    required this.child,
    required this.animationActionStream,
    required this.rootOffset,
    required this.myOffset,
    required this.size,
  });

  factory _GridAnimationObject.init(int index, Widget child,
      StreamController<GridViewAnimationAction>? controller) {
    return _GridAnimationObject(
      globalKey: GlobalKey(),
      index: index,
      child: child,
      animationActionStream: controller,
      myOffset: null,
      rootOffset: null,
      size: null,
    );
  }
  void copyWith({
    Offset? rootOffset,
    Offset? myOffset,
    Size? size,
  }) {
    this.rootOffset = rootOffset ?? rootOffset;
    this.myOffset = myOffset ?? myOffset;
    this.size = size ?? size;
  }

  // first item
  bool get firstItem => index == 0;

  bool get hasRootOffset => rootOffset != null;

  /// size [_DealCard]
  double? get width => size?.width;
  double? get height => size?.height;

  StreamSubscription? _listenSubcriptionOnDealCard;
  StreamSubscription? _listenSubcriptionOnCard;

  /// add listen refresh
  /// register listener when [controller] != null
  void addListenRefreshOnDealCard(
    AnimationController animationController,
    Timer? delayedStartAnimationCardDeal,
    void Function() startAnimation,
  ) {
    if (animationActionStream == null) {
      return;
    }
    _listenSubcriptionOnDealCard ??=
        animationActionStream!.stream.listen((event) async {
      switch (event) {
        case GridViewAnimationAction.refresh:
          delayedStartAnimationCardDeal?.cancel();
          animationController.reverse().then((_) {
            animationController.forward();
          });
          break;
        case GridViewAnimationAction.deal:
          startAnimation();
          break;
        case GridViewAnimationAction.cancel:
          delayedStartAnimationCardDeal?.cancel();
          animationController.reverse();
          break;
      }
    });
  }

  ///add listen refresh
  /// register listener when [controller] != null
  void addListenRefreshOnCard(
    AnimationController animationController,
    Timer? delayedStartAnimationCard,
    void Function() startAnimation,
  ) {
    if (animationActionStream == null) {
      return;
    }
    _listenSubcriptionOnCard ??= animationActionStream!.stream.listen((event) {
      switch (event) {
        case GridViewAnimationAction.refresh:
          delayedStartAnimationCard?.cancel();
          animationController.reverse().then((_) {
            animationController.forward();
          });
          break;
        case GridViewAnimationAction.deal:
          startAnimation();
          break;
        case GridViewAnimationAction.cancel:
          delayedStartAnimationCard?.cancel();
          animationController.reverse();
          break;
      }
    });
  }

  void dispose() {
    // deal card
    _listenSubcriptionOnDealCard?.cancel();
    _listenSubcriptionOnDealCard = null;

    // card
    _listenSubcriptionOnCard?.cancel();
    _listenSubcriptionOnCard = null;
  }
}

/// my print
//  print('parrentOffset  $parrentOffset');
//     Future.delayed(
//         const Duration(milliseconds: 1), () => print('offSet  $myOffset'));
// Future<void> _testRevert(AnimationController controller) async {
//   await Future.delayed(const Duration(seconds: 3));
//   controller.reverse();
// }
