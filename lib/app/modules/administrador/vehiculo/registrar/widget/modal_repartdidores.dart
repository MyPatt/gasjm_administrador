import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:get/get.dart';
//Bottom sheet modal que muestra los modulos, para  crud

class ModalRepartidores extends StatelessWidget {
  const ModalRepartidores(
      {Key? key,
      required this.listaCategorias,
      required this.selectedRadioTile,
      required this.onChanged})
      : super(key: key);
  final List<PersonaModel> listaCategorias;
  final RxString selectedRadioTile;
  final Function(String valor) onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: Responsive.hp(context) * .5,
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
              const TextSubtitle(text: "Seleccione un repartidor"),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 15.0),
                height: Responsive.getScreenSize(context).width * .8,
                child: listaCategorias.isEmpty
                    ? const Center(
                        child: TextDescription(text: 'Agregue un repartidor!'),
                      )
                    : ListView.builder(
                        itemCount: listaCategorias.length,
                        prototypeItem: RadioListTile(
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: listaCategorias[0],
                          groupValue: selectedRadioTile.value,
                          activeColor: AppTheme.blueBackground,
                          title: TextDescription(
                            text: listaCategorias[0].nombreUsuario!,
                            textAlign: TextAlign.start,
                          ),
                          onChanged: (val) {
                            onChanged(val.toString());
                            Navigator.of(context).pop();
                          },
                        ),
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 1,
                            margin: const EdgeInsets.all(1.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Colors.white,
                            child: Obx(
                              () => RadioListTile(
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                value: listaCategorias[index].uidPersona!,
                                groupValue: selectedRadioTile.value,
                                activeColor: AppTheme.blueBackground,
                                title: TextDescription(
                                  text: listaCategorias[index].nombreUsuario!,
                                  textAlign: TextAlign.start,
                                ),
                                onChanged: ( val) {
                                  onChanged(val.toString());
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          );
                        },
                      ),
              )
            ]));
  }
}
