import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Buscar extends StatelessWidget {
  const Buscar(
      {Key? key,
      required this.controller,
      required this.onChanged,
      required this.onTap,
      required this.existeTexoParaBuscar})
      : super(key: key);
  final TextEditingController controller;
  final Function(String valor) onChanged;
  final Function()? onTap;
  final RxBool existeTexoParaBuscar;
  @override
  Widget build(BuildContext context) {
    return TextField(
        autofocus: true,
        controller: controller,
        cursorColor: Colors.white,
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.streetAddress,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Buscar',
          filled: true,
          suffixIconColor: Colors.white,
          fillColor: AppTheme.blueDark.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          hintStyle: const TextStyle(color: Colors.white),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
          suffixIcon: Obx(
            () => Visibility(
              visible: existeTexoParaBuscar.value,
              child: GestureDetector(
                  onTap: onTap,
                  child: const Icon(Icons.close_outlined, color: Colors.white)),
            ),
          ),
        ));
  }
}
