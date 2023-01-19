import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/responsive.dart';

class FormDireccionm extends StatelessWidget {
  const FormDireccionm({Key? key, required this.controladorDeTexto})
      : super(key: key);
  final TextEditingController controladorDeTexto;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.transparent,
            alignment: Alignment.centerLeft,
            height: Responsive.getScreenSize(context).height * .05,
            width: Responsive.getScreenSize(context).width * .95,
            child: TextFormField(
              readOnly: true,
              enabled: false,
              maxLines: 1,
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                  color: Colors.black38, fontWeight: FontWeight.w400),
              controller: controladorDeTexto,
              keyboardType: TextInputType.none,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
        ),
      ],
    );
  }
}
