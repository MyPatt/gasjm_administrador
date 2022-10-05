import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:gasjm/app/modules/editar_cliente/editar_cliente_controller.dart';
import 'package:gasjm/app/modules/editar_cliente/widgets/perfil_cliente.dart';
import 'package:get/get.dart';

class EditarClientePage extends StatelessWidget {
  EditarClientePage({key}) : super(key: key);
  final EditarClienteController controladorDePedidos =
      Get.put(EditarClienteController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditarClienteController>(
      builder: (_) => Scaffold(
        backgroundColor: AppTheme.background,
        appBar: AppBar(
          backgroundColor: AppTheme.blueBackground,
          // actions: const [MenuAppBar()],
          title: const Text('Editar cliente'),
          actions: [
            //Eliminar cliente
            IconButton(
                onPressed: () {
                  _showDialogoParaEliminarCliente(context, _.cliente.uidPersona??_.cliente.cedulaPersona);
                },
                icon: const Icon(Icons.delete_outlined)),
          ],
        ),
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
                child: const PerfilCliente()),
          ),
        ),
      ),
    );
  }

  Future<void> _showDialogoParaEliminarCliente(BuildContext context, String id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const TextSubtitle(
            text: 'Eliminar cliente',
            textAlign: TextAlign.justify,
            //   style: TextoTheme.subtitleStyle2,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                TextDescription(text: '¿Está seguro de eliminar el cliente?')
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.end,
          actions: <Widget>[
            TextButton(
              child: const Text(
                'No',
                style: TextStyle(
                  color: AppTheme.light,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
                child: const Text(
                  'Si ',
                  style: TextStyle(
                    color: AppTheme.blueBackground,
                  ),
                ),
                onPressed: () {
                  controladorDePedidos.eliminarCliente(id);
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }
}
