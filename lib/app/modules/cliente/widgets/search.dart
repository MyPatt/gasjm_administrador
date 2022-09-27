import 'package:gasjm/app/global_widgets/input_text.dart';
import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Expanded(
            child: InputText(
              labelText: 'Buscar',
              iconPrefix: Icons.search_outlined,
            ),
          ),

          /*Icon(
              Icons.folder_delete_outlined,
              color: AppTheme.blueDark,
            )*/
        ],
      ),
    );
  }
}
