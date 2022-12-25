import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:get/get.dart';
//Bottom sheet modal que muestra los modulos, para  crud

class ModalOrdenamiento extends StatelessWidget {
  const ModalOrdenamiento(
      {Key? key,
      required this.listaCategoriasDeOrdenamiento,
      required this.selectedRadioTile,
      required this.onChanged})
      : super(key: key);
  final List<String> listaCategoriasDeOrdenamiento;
  final RxString selectedRadioTile;
  final Function(String valor) onChanged;
  @override
  Widget build(BuildContext context) {
    var iconos = [
      Icons.calendar_today_outlined,
      Icons.pin_outlined,
      Icons.room_outlined,
      Icons.person_outline_outlined
    ];
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
              const TextSubtitle(text: "Ordenar por"),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 15.0),
                height: Responsive.getScreenSize(context).width * .8,
                child: ListView.builder(
                  itemCount: listaCategoriasDeOrdenamiento.length,
                  prototypeItem: RadioListTile(
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: listaCategoriasDeOrdenamiento[0],
                    groupValue: selectedRadioTile.value,
                    activeColor: AppTheme.blueBackground,
                    title: TextDescription(
                      text: listaCategoriasDeOrdenamiento[0],
                      textAlign: TextAlign.start,
                    ),
                    onChanged: (val) {
                      onChanged(val.toString());
                      Navigator.of(context).pop();
                    },
                    secondary: Icon(
                      iconos[0],
                      size: 20.0,
                    ),
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
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: listaCategoriasDeOrdenamiento[index],
                          groupValue: selectedRadioTile.value,
                          activeColor: AppTheme.blueBackground,
                          title: TextDescription(
                            text: listaCategoriasDeOrdenamiento[index],
                            textAlign: TextAlign.start,
                          ),
                          onChanged: (val) {
                            onChanged(val.toString());
                            Navigator.of(context).pop();
                          },
                          secondary: Icon(
                            iconos[index],
                            size: 20.0,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ]));
  }
}
