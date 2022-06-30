import 'package:flutter/material.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class SearchBar extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  SearchBar({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  var textEditing = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SearchBarAnimation(
      textEditingController: textEditing,
      isOriginalAnimation: false,
      buttonBorderColour: Colors.teal,
      trailingIcon: Icons.search,
      buttonIcon: Icons.search,
      buttonIconColour: Colors.teal,
      trailingIconColour: Colors.teal,
      onFieldSubmitted: (String value) {
        debugPrint('onFieldSubmitted value $value');
      },
      hintText: widget.hintText,
      onCollapseComplete: () {
        textEditing.clear();
        widget.onChanged('');
        FocusScope.of(context).requestFocus(FocusNode());
      },
      durationInMilliSeconds: 500,
      onChanged: widget.onChanged,
    );
  }
}
