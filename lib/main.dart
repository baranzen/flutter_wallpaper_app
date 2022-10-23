import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        designSize: const Size(393, 786),
        builder: (context, child) => MaterialApp(
          title: 'wallpaper app',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.teal,
            primarySwatch: Colors.teal,
          ),
          home: const HomePage(),
        ),
      );
}
