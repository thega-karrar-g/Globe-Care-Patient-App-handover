import 'package:flutter/material.dart';

import '../../data/models/slides_model.dart';
import '../../core/assets_helper/app_images.dart';

class HomeSliderWidget extends StatefulWidget {
  final List<SliderModel>? slides;
  final List<String> asstsSlides;

  @override
  _HomeSliderWidgetState createState() => _HomeSliderWidgetState();

  const HomeSliderWidget({Key? key, this.slides, required this.asstsSlides})
      : super(key: key);
}

class _HomeSliderWidgetState extends State<HomeSliderWidget> {
  AlignmentDirectional? alignmentDirectional;

  @override
  Widget build(BuildContext context) {
    return
         widget.slides == null || widget.slides!.isEmpty ? const HomeSliderLoaderWidget() :
        Column();
  }
}

class HomeSliderLoaderWidget extends StatelessWidget {
  const HomeSliderLoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).focusColor.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        child: Image.asset(AppImages.loadingSlides, fit: BoxFit.cover),
      ),
    );
  }
}
