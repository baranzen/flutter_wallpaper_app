// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_typing_uninitialized_variables, must_call_super, avoid_print

import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  LikeButton(this.index,
      {Key? key, required this.list, required this.addToLikedList});

  var index;
  List list;
  final List list2 = [];
  final Function addToLikedList;
  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  late final List<String> likedList;
  var sayac;
  @override
  void initState() {
    likedList = [];
    sayac = 1;
  }

  var color = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: IconButton(
          icon: Icon(
            Icons.favorite,
            color: likeButtonColor(),
            shadows: const [
              Shadow(
                blurRadius: 10,
                color: Colors.white,
                offset: Offset(2, 2),
              ),
            ],
          ),
          onPressed: () {
            /*       likeButtonColor(); */ //!!
            widget.addToLikedList(widget.list[widget.index].url, sayac);
            sayac++;
            likeButtonColor(); //yes
            setState(() {});
          },
        ),
      ),
    );
  }

  likeButtonColor() {
    if (sayac % 2 == 1) {
      return color = Colors.grey;
    } else {
      return color = Colors.red;
    }
  }
}
