import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/Recetas.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'constantscolors.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          theme: ThemeData.dark().copyWith(
            primaryColor: cPrimaryColor,
            scaffoldBackgroundColor: cScaffoldColor,
            appBarTheme: const AppBarTheme(
              backgroundColor: cScaffoldColor,
              elevation: 0,
            ),
            textTheme: TextTheme(
              headline4: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w800,
                  color: cTextColor),
              subtitle2:
                  GoogleFonts.poppins(fontSize: 12.sp, color: cTextColor),
            ),
          ),
          home: const RecetasPage());
    });
  }
}
