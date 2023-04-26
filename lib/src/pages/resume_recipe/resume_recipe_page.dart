import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../constantscolors.dart';

class ResumeRecipePage extends StatefulWidget {
  const ResumeRecipePage({super.key});

  @override
  State<ResumeRecipePage> createState() => _ResumeRecipePageState();
}

class _ResumeRecipePageState extends State<ResumeRecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen de Receta'),
      ),
      body: Padding(
        padding: EdgeInsets.all(2.h),
        child: Column(
          children: [
            MainSection(),
            DetailedSection(),
            Spacer(),
            SizedBox(
              width: 100.w,
              height: 7.h,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: cSecondaryColor,
                ),
                onPressed: () {
                  //falta una accion
                  AlertBox(context);
                },
                child: Text(
                  'Eliminar',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: cScaffoldColor,
                      ),
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            )
          ],
        ),
      ),
    );
  }

  AlertBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: cScaffoldColor,
            title: Text(
                '¿Eliminar este recordatorio?',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1),
            contentPadding: EdgeInsets.only(top: 1.h),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancelar', 
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              TextButton(
                onPressed: () {
                  //se hace despues la accion de eliminar
                },
                child: Text(
                  'OK',
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: cSecondaryColor),
                ),
              ),
            ],
          );
        });
  }
}

class MainInfo extends StatelessWidget {
  const MainInfo(
      {super.key, required this.titlefield, required this.infofield});
  final String titlefield;
  final String infofield;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.w,
      height: 10.h,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titlefield, style: Theme.of(context).textTheme.subtitle2),
            SizedBox(height: 0.3.h),
            Text(infofield,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: cPrimaryColor)),
          ],
        ),
      ),
    );
  }
}

class DetailedInfo extends StatelessWidget {
  const DetailedInfo(
      {super.key, required this.titlefield, required this.infofield});
  final String titlefield;
  final String infofield;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: Text(
              titlefield,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: cTextColor),
            ),
          ),
          Text(
            infofield,
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(color: cSecondaryColor),
          ),
        ],
      ),
    );
  }
}

class MainSection extends StatelessWidget {
  const MainSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SvgPicture.asset(
          'assets/icons/bottle.svg',
          height: 7.h,
          color: cPrimaryColor,
        ),
        SizedBox(
          width: 2.w,
        ),
        Column(
          children: const [
            MainInfo(titlefield: 'Nombre de Medicamento', infofield: 'B12'),
            MainInfo(titlefield: 'Dosis', infofield: '500 mg'),
          ],
        ),
      ],
    );
  }
}

class DetailedSection extends StatelessWidget {
  const DetailedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: const [
        DetailedInfo(titlefield: 'Tipo de Medicamento', infofield: 'Bote'),
        DetailedInfo(
            titlefield: 'Intervalo de Tiempo', infofield: 'Cada 8 horas'),
        DetailedInfo(titlefield: 'Tiempo de Inicio', infofield: '12:00 PM'),
      ],
    );
  }
}
