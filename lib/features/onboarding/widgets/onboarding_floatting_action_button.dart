// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class YinFloatingActionButtonArgs {
  final double size;
  final Color scaffoldBackgroundColor;
  final int stepCount;
  final int currentStep;

  final void Function()? onTap;
  YinFloatingActionButtonArgs({
    required this.size,
    required this.scaffoldBackgroundColor,
    this.stepCount = 2,
    required this.currentStep,
    this.onTap,
  }) : assert(currentStep <= stepCount && currentStep >= 0);
}

class YinFloatingActionButton extends StatefulWidget {
  final YinFloatingActionButtonArgs args;
  const YinFloatingActionButton({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  State<YinFloatingActionButton> createState() =>
      _YinFloatingActionButtonState();
}

class _YinFloatingActionButtonState extends State<YinFloatingActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late double _progressValue;

  @override
  void initState() {
    _progressValue = widget.args.currentStep / widget.args.stepCount;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animationController.addListener(() {
      setState(() {
        _progressValue = _animationController.value;
      });
    });
    runProgress();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  void runProgress() {
    if (_progressValue == 1) {
      setState(() {
        _progressValue = 0;
      });
    }
    _animationController.animateTo(
        widget.args.currentStep / widget.args.stepCount,
        duration: const Duration(milliseconds: 300));
  }

  @override
  void didUpdateWidget(covariant YinFloatingActionButton oldWidget) {
    runProgress();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.args.onTap,
      child: Container(
        height: widget.args.size,
        width: widget.args.size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: [
            SizedBox(
              height: widget.args.size,
              width: widget.args.size,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
                value: _progressValue,
                backgroundColor: Colors.white.withOpacity(0.3),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/angle_right_solid.svg",
                    height: 20,
                    width: 16,
                    color: widget.args.scaffoldBackgroundColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
