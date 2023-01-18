import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/data/models/horario_model.dart';
import 'package:gasjm/app/global_widgets/circular_progress.dart';
import 'package:gasjm/app/global_widgets/input_text.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:gasjm/app/modules/gasjm/gasjm_controller.dart';
import 'package:get/get.dart';
//Bottom dialog  modal que muestra los modulos, para  crud

class ModalEditarHorario extends StatelessWidget {
  const ModalEditarHorario({Key? key, required this.horario}) : super(key: key);
  final HorarioModel horario;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GasJMController>(
      builder: (_) => Container(
        height: Responsive.hp(context) * 0.5,
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 5,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: _gridModulos(context, _),
      ),
    );
  }

  Widget _gridModulos(BuildContext context, GasJMController controlador) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: <
        Widget>[
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
      TextSubtitle(
        text: HorarioModel.diasSemana[horario.idDiaHorario - 1]['nombreDia']
            .toString(),
      ),
      const TextDescription(
          text: "Seleccione la hora de apertura o de cierre para editar"),
      SizedBox(height: Responsive.getScreenSize(context).height * .03),
      GestureDetector(
        onTap: () async {
          TimeOfDay? aux = await showTimePicker(
              context: context,
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: AppTheme.blueBackground,
                      onPrimary: Colors.white,
                      onSurface: AppTheme.blueDark,
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        primary: AppTheme.blueBackground,
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
              initialTime: TimeOfDay(
                  hour: int.parse(controlador.horaAperturaTextController.text
                      .split(':')[0]),
                  minute: int.parse(controlador.horaAperturaTextController.text
                      .split(':')[1]))
              /*  TimeOfDay(
                  hour: int.parse(horario.aperturaHorario.split(':')[0]),
                  minute: int.parse(horario.aperturaHorario.split(':')[1]))*/
              );
          if (aux != null) {
            controlador.horaAperturaTextController.text = aux.format(context);
          }
        },
        child: InputText(
          controller: controlador.horaAperturaTextController,
          keyboardType: TextInputType.none,
          iconPrefix: Icons.watch_later_outlined,
          labelText: "Hora apertura",
          readOnly: true,
          enabled: false,
          // enabled: true,
        ),
      ),
      SizedBox(height: Responsive.getScreenSize(context).height * .02),
      GestureDetector(
        onTap: () async {
          TimeOfDay? aux = await showTimePicker(
              initialEntryMode: TimePickerEntryMode.input,
              context: context,
              initialTime: TimeOfDay(
                  hour: int.parse(
                      controlador.horaCierreTextController.text.split(':')[0]),
                  minute: int.parse(controlador.horaCierreTextController.text
                      .split(':')[1])));
          /* initialTime: TimeOfDay(
                  hour: int.parse(horario.cierreHorario.split(':')[0]),
                  minute: int.parse(horario.cierreHorario.split(':')[1])));*/
          if (aux != null) {
            controlador.horaCierreTextController.text = aux.format(context);
          }
        },
        child: InputText(
          controller: controlador.horaCierreTextController,
          keyboardType: TextInputType.none,
          iconPrefix: Icons.watch_later_outlined,
          labelText: "Hora cierre",
          readOnly: true,
          enabled: false,
          // enabled: true,
        ),
      ),
      SizedBox(height: Responsive.getScreenSize(context).height * .05),
      Obx(() {
        final estadoGuardar = controlador.actualizandoHorario.value;
        return Stack(
          alignment: Alignment.center,
          children: [
            Visibility(
              visible: !controlador.actualizandoHorario.value,
              child: PrimaryButton(
                texto: "Guardar",
                onPressed: () async {
                  HorarioModel horarioNuevo = HorarioModel(
                      idHorario: horario.idHorario,
                      idDiaHorario: horario.idDiaHorario,
                      uidHorario: horario.uidHorario,
                      aperturaHorario:
                          controlador.horaAperturaTextController.text,
                      cierreHorario: controlador.horaCierreTextController.text);
                  //
                  controlador.actualizarHorario(horarioNuevo);
                  //
                  await Future.delayed(const Duration(seconds: 1));
                  //
                  controlador.cargarDatosHorarios();
                  Navigator.pop(context);
                },
              ),
            ),
            if (estadoGuardar) const CircularProgress()
          ],
        );
      }),
      SizedBox(height: Responsive.getScreenSize(context).height * .03),
    ]);
  }
}
