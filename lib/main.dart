import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/HomePage.dart';
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
              appBarTheme: AppBarTheme(
                toolbarHeight: 10.h,
                backgroundColor: cScaffoldColor,
                elevation: 0,
                iconTheme: IconThemeData(color: cSecondaryColor, size: 20.sp),
                titleTextStyle: GoogleFonts.mulish(
                  color: cTextColor,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.normal,
                  fontSize: 16.sp,
                ),
                centerTitle: true,
              ),
              textTheme: TextTheme(
                headline3: TextStyle(
                  fontSize: 28.sp,
                  color: cSecondaryColor,
                  fontWeight: FontWeight.w500,
                ),
                headline4: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w800,
                    color: cTextColor),
                subtitle2:
                    GoogleFonts.poppins(fontSize: 12.sp, color: cTextColor),
                labelMedium: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: cTextColor,
                ),
                caption: 
                GoogleFonts.poppins(
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w500,
                  color: cPrimaryColor,
                ),
              ),
              inputDecorationTheme: const InputDecorationTheme(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: cTextLightColor,
                    width: 1.0,
                  )),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: cTextLightColor,
                  )),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: cPrimaryColor,
                    width: 1.5,
                  )))),
          home: const RecetasPage());
    });
  }
}
