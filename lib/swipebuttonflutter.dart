import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'swipable_button.dart';

// ignore: must_be_immutable
class SwipingButton extends StatefulWidget {
  final String text;
  final double height;
  final VoidCallback onSwipeCallback;
  final Color swipeButtonColor;
  final Color backgroundColor;
  final Color iconColor;
  TextStyle? buttonTextStyle;
  final EdgeInsets padding;
  final double? swipePercentageNeeded;
  final bool isLoading;

  SwipingButton({
    Key? key,
    required this.text,
    required this.isLoading,
    this.height = 80,
    required this.onSwipeCallback,
    this.swipeButtonColor = Colors.amber,
    this.backgroundColor = Colors.black,
    this.padding = const EdgeInsets.fromLTRB(0, 0, 0, 0),
    this.iconColor = Colors.white,
    this.buttonTextStyle,
    this.swipePercentageNeeded,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => StateSwipingButton(
        text: text,
        onSwipeCallback: onSwipeCallback,
        height: height,
        padding: this.padding,
        swipeButtonColor: this.swipeButtonColor,
        backgroundColor: this.backgroundColor,
        iconColor: this.iconColor,
        buttonTextStyle: this.buttonTextStyle,
      );
}

class StateSwipingButton extends State<SwipingButton> {
  final String text;
  final double height;
  final VoidCallback onSwipeCallback;
  bool isSwiping = false;
  double opacityVal = 1;
  final Color swipeButtonColor;
  final Color backgroundColor;
  final Color iconColor;
  TextStyle? buttonTextStyle;
  final EdgeInsets padding;

  StateSwipingButton({
    Key? key,
    required this.text,
    required this.height,
    required this.onSwipeCallback,
    this.padding = const EdgeInsets.fromLTRB(0, 0, 0, 0),
    this.swipeButtonColor = Colors.amber,
    this.backgroundColor = Colors.black,
    this.iconColor = Colors.white,
    this.buttonTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    buttonTextStyle ??= const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w800,
      color: Colors.white,
    );
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: padding,
      child: Stack(
        children: [
          Container(
            height: height,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                text.toUpperCase(),
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          SwipeAbleWidget(
            height: height,
            swipePercentageNeeded: widget.swipePercentageNeeded ?? 0.8,
            screenSize: MediaQuery.of(context).size.width -
                (padding.right + padding.left),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: widget.isLoading
                    ? const CupertinoActivityIndicator()
                    : const Icon(Icons.arrow_forward_sharp),
              ),
              decoration: BoxDecoration(
                color: swipeButtonColor,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onSwipeCallback: onSwipeCallback,
            onSwipeStartCallback: (val, conVal) {
              SchedulerBinding.instance!
                  .addPostFrameCallback((_) => setState(() {
                        isSwiping = val;
                        opacityVal = 1 - conVal;
                      }));
            },
          ),
        ],
      ),
    );
  }
}
