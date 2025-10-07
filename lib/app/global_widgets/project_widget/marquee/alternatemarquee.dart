import 'package:flutter/cupertino.dart';

import 'speed.dart';

class AlternateMarquee extends StatefulWidget {
  final List<Widget> items;
  final Speed speed;

  AlternateMarquee({Key? key, required this.items, this.speed = Speed.normal})
      : super(key: key);

  @override
  _AlternateMarqueeState createState() => _AlternateMarqueeState();
}

class _AlternateMarqueeState extends State<AlternateMarquee> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.doWhile(_scroll);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      physics: NeverScrollableScrollPhysics(),
      child: Row(children: widget.items), // not allow the user to scroll.
    ));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<bool> _scroll() async {
    await Future.delayed(widget.speed.pauseDuration);
    if (_scrollController.hasClients) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: widget.speed.animationDuration, curve: Curves.easeOut);
    }
    await Future.delayed(widget.speed.pauseDuration);
    if (_scrollController.hasClients) {
      _scrollController.animateTo(_scrollController.position.minScrollExtent,
          duration: widget.speed.backDuration, curve: Curves.easeOut);
    }
    return true;
  }
}
