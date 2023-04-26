import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/AddRecipe/AddRecipeBlock.dart';
import 'package:flutter_application_1/src/pages/HomePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'constantscolors.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AddRecipeB? addRecipeB;

  @override
  void initState() {
    addRecipeB = AddRecipeB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<AddRecipeB>.value(
        value: addRecipeB!,
        child: Sizer(builder: (context, orientation, deviceType) {
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
                  headline6: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.0,
                      color: cSecondaryColor),
                  subtitle2:
                      GoogleFonts.poppins(fontSize: 12.sp, color: cTextColor),
                  labelMedium: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: cTextColor,
                  ),
                  caption: GoogleFonts.poppins(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w500,
                    color: cTextLightColor,
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
                    ))),
                timePickerTheme: const TimePickerThemeData(
                  backgroundColor: cScaffoldColor,
                  hourMinuteColor: cPrimaryColor,
                  hourMinuteTextColor: cScaffoldColor,
                  dayPeriodColor: cPrimaryColor,
                  dayPeriodTextColor: cScaffoldColor,
                  dialBackgroundColor: cPrimaryColor,
                  dialTextColor: cScaffoldColor,
                  dialHandColor: cSecondaryColor,
                  entryModeIconColor: cOtherColor,
                ),
              ),
              home: const HomePage());
        }));
  }
}
