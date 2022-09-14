import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:gasjm/app/global_widgets/button_navigator.dart';
import 'package:gasjm/app/global_widgets/content_title.dart';
import 'package:gasjm/app/modules/home/home_controller.dart';
import 'package:gasjm/app/modules/home/widgets/category.dart';
import 'package:gasjm/app/modules/home/widgets/header.dart';
import 'package:gasjm/app/modules/home/widgets/houses.dart';

import 'package:gasjm/app/global_widgets/repartidor/menu_appbar.dart';
import 'package:gasjm/app/global_widgets/menu_lateral.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/search.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductModel> addItems = [];
  @override
  Widget build(BuildContext context) {
    //Definir tamaño de animatedContainer
    final size = MediaQuery.of(context).size;
    double _height = addItems.length > 0 ? size.height * .78 : size.height;

    final _borderRadius = addItems.length > 0
        ? BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          )
        : BorderRadius.circular(0.0);
    return GetBuilder<HomeController>(
      builder: (_) => Scaffold(
        backgroundColor: AppTheme.background,
        //Menú deslizable a la izquierda con opciones del  usuario
        drawer: const MenuLateral(),
        //Barra de herramientas de opciones para  agenda y  historial
        appBar: AppBar(
          backgroundColor: AppTheme.blueBackground,
          actions: const [MenuAppBar()],
          title: const Text('GasJ&M'),
        ),
        body: Stack(
          children: [
            //_cart(),
            _animatedBody(_height, _borderRadius, context),
          ],
        ),

/*
        Stack(
          children: [
            Positioned.fill(
              child: CustomScrollView(
                slivers: [
                  /* Header(),
                  Search(),*/
                  Category(),
                  /* ContentTitle(
                    title: "Nearby to you",
                    more: "View more",
                  ),*/
                  //  Houses(),
                  _animatedBody(_height, _borderRadius, context),
                ],
              ),
            ),
            //ButtonNavigator()
          ],
        ),
        */
      ),
    );
  }

  Widget _animatedBody(double _height, _borderRadius, BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 700),
      width: double.infinity,
      height: _height,
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 0.5,
      ),
      decoration: BoxDecoration(
        color: Color.fromRGBO(240, 241, 248, 1.0),
        borderRadius: _borderRadius,
      ),
      child: _gridProduct(),
    );
  }

  Widget _gridProduct() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15.0,
        mainAxisSpacing: 15.0,
        mainAxisExtent: 215.0,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    print("Click!!!");
                  },
                  child: Hero(
                    tag: "Key_${products[index].id}",
                    child: Image.asset(
                      "assets/icons/gps.png",
                      width: 140.0,
                      height: 100.0,
                    ),
                  ),
                ),
                Text(
                  products[index].type ?? "Nike",
                  style: TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  products[index].description ?? "Description",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  "\$${products[index].price}",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

//////////////////////////////////////////
class ProductModel {
  int? id;
  String? type;
  String? description;
  double? price;
  String? path;

  ProductModel({
    this.id,
    this.type,
    this.description,
    this.price,
    this.path,
  });
}

List<ProductModel> products = [
  ProductModel(
    id: 1,
    type: "Pedidos",
    description: "Zoom shoe",
    price: 12.0,
    path: "assets/nike_1.png",
  ),
  ProductModel(
    id: 2,
    type: "Clientes",
    description: "Human Race",
    price: 20.0,
    path: "assets/nike_2.png",
  ),
  ProductModel(
    id: 3,
    type: "Repartidores",
    description: "Joyraide",
    price: 15.0,
    path: "assets/nike_3.png",
  ),
  ProductModel(
    id: 4,
    type: "Adidas",
    description: "Street Ball",
    price: 120.0,
    path: "assets/nike_4.png",
  ),
  ProductModel(
    id: 5,
    type: "Nike",
    description: "Pegasus",
    price: 120.0,
    path: "assets/nike_5.png",
  ),
  ProductModel(
    id: 6,
    type: "Nike",
    description: "Equipment",
    price: 120.0,
    path: "assets/nike_6.png",
  ),
  ProductModel(
    id: 7,
    type: "Adidas",
    description: "EQC Gazzelle",
    price: 120.0,
    path: "assets/nike_7.png",
  ),
  ProductModel(
    id: 8,
    type: "Nike",
    description: "Race X10",
    price: 120.0,
    path: "assets/nike_8.png",
  ),
  ProductModel(
    id: 9,
    type: "Adidas",
    description: "Z9 shoe",
    price: 120.0,
    path: "assets/nike_9.png",
  ),
  ProductModel(
    id: 10,
    type: "Adidas",
    description: "Shoe Ball",
    price: 120.0,
    path: "assets/nike_10.png",
  ),
];
