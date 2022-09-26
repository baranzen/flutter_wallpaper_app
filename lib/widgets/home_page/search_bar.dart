// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:wallpaper_app/services/interstitialad.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key? key, required this.func}) : super(key: key);

  Function func;
  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late InterstitialAds interstitialAd;

  @override
  void initState() {
    interstitialAd = InterstitialAds();
    super.initState();
  }

  var textEditing = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SearchBarAnimation(
        textEditingController: textEditing,
        isOriginalAnimation: false,
        enableKeyboardFocus: true,
        buttonBorderColour: Colors.teal,
        trailingIcon: Icons.search,
        buttonIcon: Icons.search,
        buttonIconColour: Colors.teal,
        trailingIconColour: Colors.teal,
        onFieldSubmitted: (String value) {
          debugPrint('onFieldSubmitted value $value');
        },
        hintText: 'search here...',
        onExpansionComplete: () {
          interstitialAd.loadInterstitialAd();
        },
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
