import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class MyListBuilder extends StatelessWidget {
  List list;
  Function(BuildContext context, int index) builder;
  MyListBuilder({Key key, this.builder, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) => builder(context, index),
      ),
    );
  }
}

class MyAnimationListBuilder extends StatelessWidget {
  int index;
  Widget child;

  MyAnimationListBuilder({
    Key key,
    this.index,
    this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 375),
      child: SlideAnimation(
        horizontalOffset: 100.0,
        child: FadeInAnimation(
          child: new Material(
              color: Colors.transparent,
              child: child
          ),
        ),
      ),
    );
  }
}
