import 'package:anim_search_bar/anim_search_bar.dart';
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
          const Text(
            'Wallpaper App',
            style: TextStyle(color: Colors.teal, fontSize: 17),
          ),
          Align(
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
          ),
          AnimSearchBar(
            width: MediaQuery.of(context).size.width,
            textController: textController,
            helpText: 'marka, kategori veya link',
            onSuffixTap: () {
              setState(() {
                textController.clear();
              });
            },
          ),
        ],
      ),
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
