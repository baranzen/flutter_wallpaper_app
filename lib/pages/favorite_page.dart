import 'package:flutter/material.dart';
import 'package:wallpaper_app/pages/home_page.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return const Text('wallpaper');
        },
      ),
      bottomNavigationBar: const Bottom(),
    );
  }
}
