import 'dart:math';

import 'package:flutter/material.dart';

class AppleWalletSwiper<T> extends StatefulWidget {
  final List<T> cardData;
  final Widget Function(BuildContext, int index, int visibleIndex) cardBuilder;
  final Duration animationDuration;
  final void Function(int)? onCardChange;

  const AppleWalletSwiper({
    required this.cardData,
    required this.cardBuilder,
    this.animationDuration = const Duration(milliseconds: 600),
    this.onCardChange,
    super.key,
  });

  @override
  State<AppleWalletSwiper<T>> createState() => _AppleWalletSwiperState<T>();
}

class _AppleWalletSwiperState<T> extends State<AppleWalletSwiper<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late List<T> _cardData;
  bool _isCardSwitched = false;

  @override
  void initState() {
    super.initState();
    _cardData = List.from(widget.cardData);

    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    final curved = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _rotationAnimation = Tween<double>(begin: 0, end: pi).animate(curved)
      ..addListener(() {
        if (_rotationAnimation.value >= pi / 2 && !_isCardSwitched) {
          setState(() {
            final first = _cardData.removeAt(0);
            _cardData.add(first);
            _isCardSwitched = true;
          });

          widget.onCardChange?.call(widget.cardData.indexOf(_cardData[0]));
        }

        if (_rotationAnimation.isCompleted) {
          _controller.reset();
          _isCardSwitched = false;
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (_controller.isAnimating) return;
    _controller.forward();
  }

  Widget _buildCard(int index, double elevationOffset) {
    return Transform.translate(
      offset: Offset(0, elevationOffset),
      child: Material(
        elevation: 8 - elevationOffset / 5,
        borderRadius: BorderRadius.circular(25),
        child: widget.cardBuilder(context, index, index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final topCardIndex = widget.cardData.indexOf(_cardData[0]);
    final midCardIndex =
        _cardData.length > 1 ? widget.cardData.indexOf(_cardData[1]) : -1;
    final btmCardIndex =
        _cardData.length > 2 ? widget.cardData.indexOf(_cardData[2]) : -1;

    return GestureDetector(
      onVerticalDragEnd: _onVerticalDragEnd,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_cardData.length > 2) _buildCard(btmCardIndex, 40),
          if (_cardData.length > 1) _buildCard(midCardIndex, 20),
          AnimatedBuilder(
            animation: _rotationAnimation,
            builder: (context, child) {
              final isBack = _rotationAnimation.value > pi / 2;
              final angle =
                  isBack
                      ? _rotationAnimation.value - pi
                      : _rotationAnimation.value;

              return Transform(
                alignment: Alignment.center,
                transform:
                    Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateX(angle),
                child: _buildCard(topCardIndex, 0),
              );
            },
          ),
        ],
      ),
    );
  }
}
