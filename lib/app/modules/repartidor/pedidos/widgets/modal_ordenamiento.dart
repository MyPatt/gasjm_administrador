import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/data/models/categoria_model.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:gasjm/app/modules/home/home_controller.dart';
import 'package:get/get.dart';
//Bottom sheet modal que muestra los modulos, para  crud

class ModalOrdenamiento extends StatelessWidget {
  const ModalOrdenamiento(
      {Key? key,
      required this.listaCategoriasDeOrdenamiento,
      required this.selectedRadioTile})
      : super(key: key);
  final List<String> listaCategoriasDeOrdenamiento;
  final RxString selectedRadioTile;
  @override
  Widget build(BuildContext context) {
    var iconos = [
      Icons.calendar_today_outlined,
      Icons.pin_outlined,
      Icons.room_outlined,
      Icons.person_outline_outlined
    ];
    return Container(
        height: Responsive.hp(context) * .51,
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 5,
        ),
        decoration: const BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  width: 50.0,
                  height: 5.0,
                  margin: const EdgeInsets.only(bottom: 25.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              Text("Ordenar por",
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: AppTheme.blueDark, fontWeight: FontWeight.w700)),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 15.0),
                height: Responsive.getScreenSize(context).width * .8,
                child: ListView.builder(
                  itemCount: listaCategoriasDeOrdenamiento.length,
                  prototypeItem: RadioListTile(
                    value: listaCategoriasDeOrdenamiento.first,
                    groupValue: selectedRadioTile,
                    onChanged: (val) {
                      print("Radio Tile pressed $val");
                      selectedRadioTile.value = val.toString();
                    },
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 1,
                      margin: EdgeInsets.all(.50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.white,
                      child: Obx(
                        () => RadioListTile(
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: listaCategoriasDeOrdenamiento[index],
                          groupValue: selectedRadioTile.value,
                          activeColor: AppTheme.blueBackground,
                          title: Text(
                            listaCategoriasDeOrdenamiento[index],
                            style: const TextStyle(color: Colors.black38),
                          ),
                          onChanged: (val) {
                            print("Radio Tile pressed $val");
                            selectedRadioTile.value = val.toString();
                            print(selectedRadioTile.value);
                            Navigator.of(context).pop();
                          },
                          secondary: Icon(iconos[index]),
                        ),
                      ),
                    );
                  },
                ),
              )
            ]));
  }

  Widget _gridModulos(BuildContext context, HomeController homeController) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
              width: 50.0,
              height: 5.0,
              margin: const EdgeInsets.only(bottom: 25.0),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          const Center(
            child: TextSubtitle(
              text: "Seleccione una opción",
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 15.0),
            height: Responsive.getScreenSize(context).width * .8,
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: categoriasModulos.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    homeController.seleccionarCategoriaParaOperacion(index);
                  },
                  child: ItemCategoriaModulos(
                    categoria: categoriasModulos[index],
                    indice: index,
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 130.0,
              ),
            ),
          ),
          const Spacer(),
          const Divider(),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Text(
              "Cerrar",
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                  color: AppTheme.light, fontWeight: FontWeight.bold),
            ),
          ),
          const Spacer(),
        ]);
  }
}

class ItemCategoriaModulos extends StatelessWidget {
  const ItemCategoriaModulos({
    Key? key,
    required this.categoria,
    required this.indice,
  }) : super(key: key);

  final CategoriaModelo categoria;
  final int indice;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (_) => AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: Responsive.getScreenSize(context).width * .2,
            margin: const EdgeInsets.only(
              left: 10.0,
              bottom: 10.0,
            ),
            decoration: const BoxDecoration(
              color: AppTheme.background,
            ),
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    categoria.path,
                    width: 30.0,
                    color: AppTheme.light,
                  ),
                  //

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        right: 5.0,
                        left: 5.0,
                      ),
                      child: Text(
                        categoria.name,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              color: AppTheme.blueDark,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
