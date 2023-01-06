import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/data/models/categoria_model.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:gasjm/app/modules/administrador/inicio/inicio_controller.dart';
import 'package:get/get.dart';
//Bottom sheet modal que muestra los modulos, para  crud

class ModalOperaciones extends StatelessWidget {
  const ModalOperaciones({Key? key, required this.indiceBottomItem})
      : super(key: key);
  final int indiceBottomItem;
  @override
  Widget build(BuildContext context) {
    return (GetBuilder<InicioAdministradorController>(
        builder: (_) => Container(
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
                            switch (indiceBottomItem) {
                              case 1:
                                _.seleccionarCategoriaParaAgregar(index);
                                break;
                              case 2:
                                _.seleccionarCategoriaParaOperacion(index);
                                break;
                            }
                          },
                          child: ItemCategoriaModulos(
                            categoria: categoriasModulos[index],
                            indice: index,
                          ),
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                ]))));
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
    return GetBuilder<InicioAdministradorController>(
        builder: (_) => 
        Card(
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
        ));
  }
}