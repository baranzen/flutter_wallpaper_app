import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class WallpaperAppText extends StatelessWidget {
  const WallpaperAppText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'wallpaper app',
      style: GoogleFonts.chewy(
        color: Colors.teal,
        fontSize: 38.sp,
      ),
    );
  }
}
