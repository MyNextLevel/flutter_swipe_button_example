import 'package:flutter/material.dart';

class SwipeAbleWidget extends StatefulWidget {
  final Widget child;
  final double height;
  final VoidCallback onSwipeCallback;
  final double? swipePercentageNeeded;
  final double screenSize;
  final Function(bool, double) onSwipeStartCallback;

  SwipeAbleWidget({
    Key? key,
    required this.child,
    required this.height,
    required this.onSwipeCallback,
    required this.onSwipeStartCallback,
    required this.screenSize,
    this.swipePercentageNeeded = 0.75,
  })  : assert(swipePercentageNeeded! <= 1.0),
        super(key: key);

  @override
  _SwipeAbleWidgetState createState() => _SwipeAbleWidgetState();
}

class _SwipeAbleWidgetState extends State<SwipeAbleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  var _dxStartPosition = 0.0;
  var _dxEndsPosition = 0.0;
  var _initControllerVal;

  @override
  void initState() {
    super.initState();
    _initControllerVal = widget.height / widget.screenSize;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(
        () {
          if (_controller.value > _initControllerVal) {
            setState(() {});
            widget.onSwipeStartCallback(
                _controller.value > _initControllerVal + 0.1,
                _controller.value);
          }
          if (_controller.value == _initControllerVal) {
            widget.onSwipeStartCallback(false, 0);
          }
        },
      );
    _controller.value = _initControllerVal;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        setState(() {
          _dxStartPosition = details.localPosition.dx;
        });
      },
      onPanUpdate: (details) {
        final widgetSize = context.size!.width;

        final minimumXToStartSwiping = widgetSize * 0.25;
        if (_dxStartPosition <= minimumXToStartSwiping) {
          setState(() {
            _dxEndsPosition = details.localPosition.dx;
          });

          final widgetSize = context.size!.width;
          if (_dxEndsPosition >= minimumXToStartSwiping) {
            _controller.value = ((details.localPosition.dx) / widgetSize);
          }
        }
      },
      onPanEnd: (details) async {
        final delta = _dxEndsPosition - _dxStartPosition;
        final widgetSize = context.size!.width;
        final deltaNeededToBeSwiped =
            widgetSize * widget.swipePercentageNeeded!;
        if (delta > deltaNeededToBeSwiped) {
          _controller.animateTo(
            1.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
          );
          widget.onSwipeCallback();
        } else {
          _controller.animateTo(
            _initControllerVal,
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
          );
        }
      },
      child: SizedBox(
        height: widget.height,
        child: Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: _controller.value,
            heightFactor: 1.0,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
