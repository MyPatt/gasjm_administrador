import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/global_widgets/input_text.dart';

import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const InputText( 
        labelText: 'Buscar',
        keyboardType: TextInputType.text,
        iconPrefix: Icons.search_outlined,
        textInputAction: TextInputAction.search,
      ),
    );
  }
}
