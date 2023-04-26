import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../constantscolors.dart';
import 'AddRecipe/AddRecipePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(3.h),
        child: Column(
          children: [
            const TopContainer(),
            SizedBox(
              height: 2.h,
            ),
            const Flexible(child: BottomContainer()),
          ],
        ),
      ),
      floatingActionButton: InkResponse(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddRecipePage()),
          );
        },
        child: SizedBox(
          width: 18.w,
          height: 9.h,
          child: Card(
            color: cPrimaryColor,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(4.h),
            ),
            child: Icon(
              Icons.add,
              color: cScaffoldColor,
              size: 50.sp,
            ),
          ),
        ),
      ),
    );
  }
}

//Contenedores principales
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

class BottomContainer extends StatelessWidget {
  const BottomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: Text('No se ha agregado ninguna receta',
    //       textAlign: TextAlign.center,
    //       style: Theme.of(context).textTheme.headline3),
    // );

    return GridView.builder(
      padding: EdgeInsets.only(top: 1.h),
      itemCount: 10,
      itemBuilder: (context, index) {
        return RecipeCard();
      },
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    );
  }
}

class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
          highlightColor: Colors.white,
          splashColor: Color.fromARGB(137, 161, 157, 157),
          onTap: () {
            //animacion despues
          },
          child: Container(
            padding:
                EdgeInsets.only(left: 2.w, right: 1.w, top: 1.h, bottom: 1.h),
            margin: EdgeInsets.all(1.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.h),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                SvgPicture.asset(
                  'assets/icons/bottle.svg',
                  height: 7.h,
                  color: cPrimaryColor,
                ),
                const Spacer(),
                Text(
                  'B12',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.fade,
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 0.3.h,
                ),
                //tag animation
                Text(
                  'Cada 8 horas',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.fade,
                  style: Theme.of(context).textTheme.caption,
                ),
                //Condicion para intervalo de tiempo
              ],
            ),
          ),
        );
  }
}
