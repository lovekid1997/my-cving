import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_cving/app/config/constant.dart';

class DocPage extends StatelessWidget {
  const DocPage({super.key});

  static const String name = 'doc';

  static const String path = 'doc';

  static void pushPage(BuildContext context) => context.goNamed(path);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text("Demo"),
      ),
      body: const SafeArea(child: _Draw()),
    );
  }
}

class _Draw extends StatefulWidget {
  const _Draw({
    Key? key,
  }) : super(key: key);

  @override
  State<_Draw> createState() => _DrawState();
}

class _DrawState extends State<_Draw> {
  final rows = 5;
  final cols = 5;
  List<TargetObject> targetObjects = [];
  ValueNotifier<bool> enable = ValueNotifier<bool>(false);
  TargetObject test = TargetObject(
    position: const Offset(150, 150),
    id: 0,
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (layoutContext, c) {
        final screenWidth = c.maxWidth;
        final screenHeight = c.maxHeight;
        final cellSize = Size(
          screenWidth / cols,
          screenHeight / rows,
        );

        final haftWidth = cellSize.width / 2;
        final haftHeight = cellSize.height / 2;

        return Stack(
          children: [
            CustomPaint(
              painter: GridPainter(
                cols: cols,
                rows: rows,
                cellSize: cellSize,
              ),
              child: SizedBox(
                width: screenWidth,
                height: screenHeight,
              ),
            ),
            ...getTargetPoint(
              haftHeight: haftHeight,
              haftWidth: haftWidth,
            ),
            ValueListenableBuilder(
              valueListenable: enable,
              builder: (context, value, __) {
                if (!value) {
                  return const SizedBox();
                }
                if (test.id != null) {
                  test = targetObjects[test.id!];
                }
                return _CirlcleItem(
                  left: test.position.dx,
                  top: test.position.dy,
                  size: 100,
                  callBackPosition: (currentPosition) {},
                  color: Color(int.tryParse("4294034447", radix: 10) ?? 0xff000000),
                  onPanEnd: (Offset currentPosition) {
                    findPosition(currentPosition);
                    setState(() {});
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  List<Widget> getTargetPoint({
    required double haftHeight,
    required double haftWidth,
  }) {
    enable.value = false;
    final List<Widget> widgets = [];
    int id = 0;
    for (var colCount = 0; colCount < cols; colCount++) {
      for (var rowCount = 0; rowCount < rows; rowCount++) {
        widgets.add(
          _CirlcleItem(
            top: haftHeight * (rowCount * 2 + 1),
            left: haftWidth * (colCount * 2 + 1),
            callBackPosition: (position) {
              final targetObject = TargetObject(
                position: position,
                id: id,
              );
              try {
                targetObjects[id] = targetObject;
              } catch (_) {
                targetObjects.add(targetObject);
              }
              id++;
              if (targetObjects.length >= (cols * rows)) {
                enable.value = true;
              }
            },
            color: Colors.blue,
            onPanEnd: (_) {},
            size: 0,
          ),
        );
      }
    }
    return widgets;
  }

  void findPosition(Offset currentPosition) {
    List<TargetObject> list = [targetObjects[0]];

    for (int i = 1; i < targetObjects.length; i++) {
      if (list.first.position.dx == targetObjects[i].position.dx) {
        list.add(targetObjects[i]);
      } else if ((currentPosition.dx - targetObjects[i].position.dx).abs() <=
          (currentPosition.dx - list.first.position.dx).abs()) {
        list.clear();
        list.add(targetObjects[i]);
      }
    }

    var targetObject = list.first;

    for (int i = 1; i < list.length; i++) {
      if ((currentPosition.dy - list[i].position.dy).abs() <=
          (currentPosition.dy - targetObject.position.dy).abs()) {
        targetObject = list[i];
      }
    }

    test = targetObject;
  }
}

class TargetObject {
  final Offset position;
  final int? id;

  TargetObject({
    required this.position,
    required this.id,
  });

  @override
  String toString() {
    return "id: $id - position: ${position.toString()}";
  }
}

class _CirlcleItem extends StatefulWidget {
  const _CirlcleItem({
    required this.left,
    required this.top,
    required this.callBackPosition,
    required this.color,
    required this.onPanEnd,
    required this.size,
  });

  final double left;
  final double top;
  final Function(Offset) callBackPosition;
  final Color color;
  final Function(Offset) onPanEnd;
  final double size;
  @override
  State<_CirlcleItem> createState() => _CirlcleItemState();
}

class _CirlcleItemState extends State<_CirlcleItem> {
  late double _leftState;
  late double _topState;
  @override
  void initState() {
    _leftState = widget.left;
    _topState = widget.top;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.callBackPosition(getCurrentPosition(context));
    });
    super.initState();
  }

  Offset getCurrentPosition(BuildContext cContext) {
    if (!mounted) {
      return Offset.zero;
    }
    final renderbox = cContext.findRenderObject() as RenderBox;
    final position = renderbox.localToGlobal(Offset.zero);
    return Offset(position.dx + widget.size / 2,
        position.dy - kToolbarHeight + widget.size / 2);
  }

  @override
  void didUpdateWidget(covariant _CirlcleItem oldWidget) {
    _leftState = widget.left;
    _topState = widget.top;
    widget.callBackPosition(getCurrentPosition(context));
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: kDuration100ml,
      top: _topState - widget.size / 2,
      left: _leftState - widget.size / 2,
      child: GestureDetector(
        onPanCancel: () {},
        onPanDown: (details) {},
        onPanEnd: (details) {
          widget.onPanEnd(getCurrentPosition(context));
        },
        onPanStart: (details) {},
        onPanUpdate: (details) {
          // cập nhật vị trí mới của hình tròn khi kéo thả
          _leftState = max(0, _leftState + details.delta.dx);
          _topState = max(0, _topState + details.delta.dy);
          setState(() {});
        },
        child: SizedBox.square(
          dimension: widget.size,
          child: CircleAvatar(
            backgroundColor: widget.color,
          ),
        ),
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  final int rows;
  final int cols;
  final Size cellSize;
  GridPainter({
    required this.rows,
    required this.cols,
    required this.cellSize,
  });
  @override
  void paint(Canvas canvas, Size size) {
    var backgroundPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.lime
      ..isAntiAlias = true;

    final screenWidth = size.width;
    final screenHeight = size.height;

    Rect rect = Rect.fromLTWH(0, 0, screenWidth, screenHeight);
    canvas.drawRect(rect, backgroundPaint);

    var linePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black38
      ..isAntiAlias = true;

    final cellWidth = cellSize.width;
    final cellHeight = cellSize.height;

    /// draw row
    for (int row = 0; row < rows; row++) {
      final space = row * cellHeight;
      final p1 = Offset(0, space);
      final p2 = Offset(screenWidth, space);

      canvas.drawLine(p1, p2, linePaint);
    }

    for (int col = 0; col < cols; col++) {
      final space = col * cellWidth;
      final p1 = Offset(space, 0);
      final p2 = Offset(space, screenHeight);

      canvas.drawLine(p1, p2, linePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
