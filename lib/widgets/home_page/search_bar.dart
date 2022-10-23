// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key? key, required this.func}) : super(key: key);

  Function func;
  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  var textEditing = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SearchBarAnimation(
        buttonWidget: const Icon(
          Icons.search,
          color: Colors.teal,
        ),
        secondaryButtonWidget: const Icon(
          Icons.cancel_rounded,
          color: Colors.teal,
        ),
        trailingWidget: const SizedBox(),
        textEditingController: textEditing,
        isOriginalAnimation: false,
        enableKeyboardFocus: true,
        buttonBorderColour: Colors.teal,
        onFieldSubmitted: (String value) {
          debugPrint('onFieldSubmitted value $value');
        },
        hintText: 'search here...',
        onExpansionComplete: () {},
        onCollapseComplete: () {
          textEditing.clear();
          widget.func(value: '');
          FocusScope.of(context)
              .requestFocus(FocusNode()); //! for close te search bar
        },
        durationInMilliSeconds: 500,
        onChanged: (value) {
          widget.func(value: value);
        });
  }
}
