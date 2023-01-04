import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';

class ContenidoLista extends StatelessWidget {
  const ContenidoLista({Key? key, required this.persona,required this.onPressed}) : super(key: key);
  final PersonaModel persona;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(right: 8.0, left: 8.0, top: 4.0, bottom: 4.0),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: AppTheme.light, width: 0.5),
        ),
        child: ListTile(
          style: ListTileStyle.list,
          iconColor: AppTheme.light,
          leading: const Icon(
            Icons.person_outlined,
            //  size: 30,
          ),
          title: TextSubtitle(
            text: '${persona.nombrePersona} ${persona.apellidoPersona}',
            textAlign: TextAlign.justify,
          ),
          subtitle: TextDescription(
              text: persona.cedulaPersona, textAlign: TextAlign.justify),
          trailing: IconButton(
              onPressed:onPressed,
              icon: const Icon(
                Icons.keyboard_arrow_right_outlined,
                // size: 30,
              )),
        ),
      ),
    );
    ;
  }
}
