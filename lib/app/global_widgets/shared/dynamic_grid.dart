import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

typedef ItemBuilder<T> = Widget Function(T item);

class DynamicGridView<T> extends StatefulWidget {
  final Axis axis;
  final List<dynamic> data;
  final int count;
  final bool scrollable;
  final double paddingTop;

  final double paddingBottom;

  final double aspectRatio, crossSpacing, mainSpacing;
  final ItemBuilder<dynamic> itemBuilder;

  DynamicGridView({
    Key? key,
    required this.data,
    this.axis = Axis.vertical,
    required this.itemBuilder,
    this.scrollable = true,
    this.paddingBottom = 50,
    this.paddingTop = 30,
    this.count = 0,
    this.aspectRatio = 1.0,
    this.crossSpacing = 15.0,
    this.mainSpacing = 15.0,
  }) : super(key: key);

  @override
  _DynamicGridViewState createState() => _DynamicGridViewState();
}

class _DynamicGridViewState<T> extends State<DynamicGridView<T>> {
  final delay = 0;
  final duration = 500;

  @override
  Widget build(BuildContext context) {
    // print(widget.data.length);
    // print(widget.itemBuilder.runtimeType);
    // print(widget.data.first.runtimeType);
    return GridView.builder(
      key: UniqueKey(),
      physics: widget.scrollable
          ? AlwaysScrollableScrollPhysics()
          : NeverScrollableScrollPhysics(),
      shrinkWrap: !widget.scrollable,
      padding: EdgeInsets.only(
          top: widget.paddingTop.h, bottom: widget.paddingBottom.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.count,
          childAspectRatio: widget.aspectRatio >0 ?widget.aspectRatio :1,
          crossAxisSpacing: widget.crossSpacing.h,
          mainAxisSpacing: widget.mainSpacing.h),
      scrollDirection: widget.axis,
      itemCount: widget.data.length,
      itemBuilder: (context, index) {
        return AnimationConfiguration.staggeredList(
          position: index,
          //  width: 200,
          //  height: 200,
          duration: Duration(milliseconds: duration),
          delay: Duration(milliseconds: delay),

          // color: Colors.blue[index * 100],
          child: SlideAnimation(
            duration: Duration(milliseconds: duration),
            delay: Duration(milliseconds: delay),
            verticalOffset: 100.h,
            child: FadeInAnimation(
              duration: Duration(milliseconds: duration),
              delay: Duration(milliseconds: delay),
              curve: Curves.easeInOut,
              child: widget.itemBuilder(
                widget.data[index] ,
              ),
            ),
          ),
        );
      },
    );
  }
}
