import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RecetasPage extends StatefulWidget {
  const RecetasPage({super.key});

  @override
  State<RecetasPage> createState() => _RecetasPageState();
}

class _RecetasPageState extends State<RecetasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(3.h),
        child: Column(
          children: const [
            TopContainer(),
          ],
        ),
      ),
    );
  }
}

class TopContainer extends StatelessWidget {
  const TopContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(
            bottom: 1.h,
          ),
          child: Text(
            'Medicos sin \n Fronteras',
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(
            bottom: 1.h,
          ),
          child: Text(
            'Bienvenido a tus Dosis diarias',
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            bottom: 1.h,
          ),
          child: Text(
            '0',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
      ],
    );
  }
}
