import 'package:flutter/material.dart';
import 'package:wallpaper_app/pages/liked_page.dart';

showSnackBarMessage(String message, context, {action = true, likedList}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: const Color.fromARGB(215, 0, 150, 135),
      behavior: SnackBarBehavior.floating,
      shape: ShapeBorder.lerp(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        1,
      ),
      duration: const Duration(milliseconds: 800),
      content: Text(message),
      action: action
          ? SnackBarAction(
              textColor: Colors.white,
              label: 'Go To Liked List',
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LikedPage(
                      likedList,
                    ),
                  ),
                );
              },
            )
          : null,
    ),
  );
}
