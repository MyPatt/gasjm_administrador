import 'package:flutter/material.dart';
import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:gasjm/app/global_widgets/modal_alert.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:gasjm/app/global_widgets/imagen_usuario.dart';
import 'package:gasjm/app/modules/administrador/pedido/registrar/registrar_controller.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

class ContenidoLista extends StatelessWidget {
  const ContenidoLista({
    Key? key,
    required this.persona,
    required this.onPressed,
    required this.eliminarCliente,
    this.modoSeleccionarCliente = false,
  }) : super(key: key);
  final PersonaModel persona;
  final void Function()? onPressed;
  final void Function() eliminarCliente;
//Inicializado modoSel... en false, ya que significa  que es busqueda de clientes mas no seleccionar
  final bool? modoSeleccionarCliente;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        modoSeleccionarCliente == true
            ? _seleccionarCliente(context)
            : onPressed;
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              right: 8.0, left: 8.0, top: 0.0, bottom: 0.0),
          child: Row(children: [
            ImagenUsuario(urlfotoPerfil: persona.fotoPersona ?? ''),
            Column(
              children: [
                TextSubtitle(
                  text: '${persona.nombrePersona} ${persona.apellidoPersona}',
                  textAlign: TextAlign.justify,
                ),
                TextDescription(
                    text: persona.cedulaPersona, textAlign: TextAlign.justify),
              ],
            ),
            const Spacer(),
            //
            modoSeleccionarCliente == true
                ? IconButton(
                    onPressed: () => _seleccionarCliente(context),
                    icon: const Icon(
                      Icons.circle_outlined,
                      color: Colors.black38,
                      size: 20,
                    ),
                  )
                : Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.detalleCliente,
                              arguments: [persona, true, 'cliente']);
                        },
                        icon: const Icon(
                          Icons.mode_edit_outline_outlined,
                          color: Colors.black38,
                          size: 20,
                        ),
                      ),
                      IconButton(
                        onPressed: () => _showDialogoParaEliminar(
                            context, persona.uidPersona!),
                        icon: const Icon(
                          Icons.delete_outline_outlined,
                          color: Colors.black38,
                          size: 20,
                        ),
                      )
                    ],
                  )
          ]),
        ),
      ),
    );
  }

//
  _showDialogoParaEliminar(BuildContext context, String idPersona) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ModalAlert(
          onPressed: () => _eliminarPersona(context, idPersona),
          titulo: 'Eliminar cliente',
          mensaje: '¿Está seguro de eliminar?',
          icono: Icons.cancel_outlined,
        );
      },
    );
  }

//
  _eliminarPersona(BuildContext context, String id) {
    eliminarCliente();
    Navigator.of(context).pop();
  }

  //Metodo que se ejecuta para seleccionar el cliente, retorna datos del cliente
  //se ejecuta cuando se busca el cliente para registrar un pedido
  _seleccionarCliente(BuildContext context) {
    Get.find<RegistrarPedidoController>().clienteSeleccionadoNombres.value =
        persona.nombreUsuario!;
    print(Get.find<RegistrarPedidoController>().clienteSeleccionadoNombres);

    //
 Get.find<RegistrarPedidoController>().clienteSeleccionadoUid =
        persona.uidPersona!;
    print( Get.find<RegistrarPedidoController>()..clienteSeleccionadoUid);

    Navigator.pop(context);
  }
}
