import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/recipe.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../constantscolors.dart';
import '../../global_bloc.dart';
import 'add_recipe/add_recipe_page.dart';
import 'resume_recipe/resume_recipe_page.dart';

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
    final GlobalB globalB = Provider.of<GlobalB>(context);
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
        StreamBuilder<List<Recipe>>(
          stream: globalB.recipeList$,
          builder: (context, snapshot) {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                bottom: 1.h,
              ),
              child: Text(
                !snapshot.hasData ? '0' : snapshot.data!.length.toString(),
                style: Theme.of(context).textTheme.headline4,
              ),
            );
          },
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

    final GlobalB globalB = Provider.of<GlobalB>(context);

    return StreamBuilder(
      stream: globalB.recipeList$,
      builder: (context, snapshot) {
        //si no se guardan los datos
        if (!snapshot.hasData) {
          return Container();
        } else if (snapshot.data!.isEmpty) {
          return Center(
            child: Text('No se ha agregado ninguna receta',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline3),
          );
        } else {
          return GridView.builder(
            padding: EdgeInsets.only(top: 1.h),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return RecipeCard(
                recipe: snapshot.data![index],
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
          );
        }
      },
    );
    //
  }
}

class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key, required this.recipe});
  final Recipe recipe;

  //funcion que recibe el icono
  Hero makeIcon(double size) {
    if (recipe.recipetype == 'bote') {
      return Hero(
        tag: recipe.recipename! + recipe.recipetype!,
        child: SvgPicture.asset(
          'assets/icons/bottle.svg',
          height: 7.h,
          color: cPrimaryColor,
        ),
      );
    } else if (recipe.recipetype == 'capsulas') {
      return Hero(
        tag: recipe.recipename! + recipe.recipetype!,
        child: SvgPicture.asset(
          'assets/icons/pill.svg',
          height: 7.h,
          color: cPrimaryColor,
        ),
      );
    } else if (recipe.recipetype == 'jeringa') {
      return Hero(
        tag: recipe.recipename! + recipe.recipetype!,
        child: SvgPicture.asset(
          'assets/icons/syringe.svg',
          height: 7.h,
          color: cPrimaryColor,
        ),
      );
    } else if (recipe.recipetype == 'tabletas') {
      return Hero(
        tag: recipe.recipename! + recipe.recipetype!,
        child: SvgPicture.asset(
          'assets/icons/pill2.svg',
          height: 7.h,
          color: cPrimaryColor,
        ),
      );
    }
    //en caso de no haber recipetype
    return Hero(
      tag: recipe.recipename! + recipe.recipetype!,
      child: Icon(Icons.error, size: size, color: cSecondaryColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.white,
      splashColor: Color.fromARGB(137, 161, 157, 157),
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder<void>(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return AnimatedBuilder(
                animation: animation,
                builder: (context, Widget? child) {
                  return Opacity(
                    opacity: animation.value,
                    child: ResumeRecipePage(recipe),
                  );
                },
              );
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(left: 2.w, right: 1.w, top: 1.h, bottom: 1.h),
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
            //llamado de la funcion que coloca el icono

            //Aqui se solucionara el error de los inconos

            makeIcon(7.h),
            const Spacer(),
            Hero(
              tag: recipe.recipename!,
              child: Text(
                recipe.recipename!,
                textAlign: TextAlign.start,
                overflow: TextOverflow.fade,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            SizedBox(
              height: 0.3.h,
            ),
            //tag animation
            Text(
              recipe.interval == 1
                  ? 'Cada ${recipe.interval} horas'
                  : 'Cada ${recipe.interval} horas',
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
