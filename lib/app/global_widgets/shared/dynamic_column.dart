import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class DynamicColumn extends StatelessWidget {
  const DynamicColumn({Key? key, required this.children}) : super(key: key);
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: Column(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 500),
          childAnimationBuilder: (widget) => SlideAnimation(
            verticalOffset: 100.0,
            duration: const Duration(milliseconds: 500),
            child: FadeInAnimation(
              duration: const Duration(milliseconds: 500),
              child: widget,
            ),
          ),
          children: children,
        ),
      ),
    );
  }
}
