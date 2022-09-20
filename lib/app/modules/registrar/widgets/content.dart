import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/registrar/widgets/form_registrar.dart';

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const FormRegistrar());
  }
}
