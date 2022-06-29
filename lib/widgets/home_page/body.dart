import 'dart:async';

import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/widgets/home_page/wallpaper_grid.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.progressString, required this.func2})
      : super(key: key);

  final Stream<String>? progressString;
  final Function func2;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var crossCount = 2;
  var textController = TextEditingController();
  var value = 2;
  var chips = [
    'Cars',
    'Nature',
    'Space',
    'Cars',
    'Nature',
    'Space',
    'Cars',
    'Nature',
    'Space',
    'Cars',
    'Nature',
    'Space',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        top(context),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: chips
                .map(
                  (e) => Row(
                    children: [
                      Chip(
                        label: Text(e),
                      ),
                      const SizedBox(width: 5),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
        MainBody(crossCount: crossCount, widget: widget),
      ],
    );
  }

  SafeArea top(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          const WallpaperAppText(),
          dropDown(),
          SearchBar(),
        ],
      ),
    );
  }

  Align dropDown() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: DropdownButton(
          focusColor: Colors.teal,
          iconEnabledColor: Colors.teal,
          onChanged: (value2) {
            setState(() {
              value = value2 as int;
              crossCount = value2;
            });
          },
          value: value,
          items: const [
            DropdownMenuItem(
              value: 1,
              child: Icon(
                Icons.view_agenda,
              ),
            ),
            DropdownMenuItem(
              value: 2,
              child: Icon(Icons.view_cozy_outlined),
            ),
            DropdownMenuItem(
              value: 3,
              child: Icon(Icons.view_column),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  SearchBar({
    Key? key,
  }) : super(key: key);
  var onChanged = '';
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
      hintText: 'Kategori, marka model veya link',
      onCollapseComplete: () {
        textEditing.clear();
      },
      durationInMilliSeconds: 500,
      onChanged: (value) {
        widget.onChanged = value;
        print(value);
      },
    );
  }
}

class WallpaperAppText extends StatelessWidget {
  const WallpaperAppText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Wallpaper App',
      style: TextStyle(color: Colors.teal, fontSize: 17),
    );
  }
}

class MainBody extends StatelessWidget {
  const MainBody({
    Key? key,
    required this.crossCount,
    required this.widget,
  }) : super(key: key);

  final int crossCount;
  final Body widget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: WallpaperGrid(crossCount, func: (likedList) {
        widget.func2(likedList);
      }),
    );
  }
}
