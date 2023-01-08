import 'package:gasjm/app/data/controllers/pedido_controller.dart'; 
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:get/get.dart';

class PedidosController extends GetxController {
  /* VARIABLES*/

  final _personaRepository = Get.find<PersonaRepository>();

  //Lista para filtrar los pedidos por dias

  List<String> dropdownItemsDeFiltro = [
    "Todos",
    "Ahora",
    "Mañana",
  ];
  RxString valorSeleccionadoItemDeFiltro = 'Todos'.obs;
  RxString valorSeleccionadoItemDeFiltroAceptados = 'Todos'.obs;

//Varaible para imagen del usuario observable
  RxString imagenUsuario = ''.obs;
  //
  ///
  final PedidoController controladorDePedidos = Get.put(PedidoController());

  ///
  /* METODOS PROPIOS */
  @override
  Future<void> onInit() async {
    super.onInit();

    Future.wait([_cargarFotoPerfil()]);
    /* cargarListaPedidosEnEspera();
    valorSeleccionadoItemDeOrdenamiento.value = dropdownItemsDeOrdenamiento[0];
    valorSeleccionadoItemDeOrdenamientoAceptados.value =
        dropdownItemsDeOrdenamiento[0];
    valorSeleccionadoItemDeFiltro.value = dropdownItemsDeFiltro[0];
    valorSeleccionadoItemDeFiltroAceptados.value = dropdownItemsDeFiltro[0];*/
    //cargarListaPedidosAceptados();
    //0 en espera
    //1 aceptados
    //2 finalizados

    controladorDePedidos.cargarListaPedidosParaRepartidor(0);
    controladorDePedidos.cargarListaPedidosParaRepartidor(1);
    controladorDePedidos.cargarListaPedidosParaRepartidor(2);
  }

  /* METODOS PARA PEDIDOS EN ESPERA */
  Future<void> _cargarFotoPerfil() async {
    imagenUsuario.value =
        await _personaRepository.getImagenUsuarioActual() ?? '';
  }

  RxString indiceCategoriaSeleccionada = 'Fecha'.obs;
  final listaCategoriasDeOrdenamiento = [
    "Fecha",
    "Cantidad",
    "Dirección",
    "Cliente"
  ];

//Metodo para ordenar
  seleccionarOpcionDeOrdenamiento(String? valor) {
 
    indiceCategoriaSeleccionada.value = valor!;

    //
    switch (valor) {
      case 'Fecha':
        
        controladorDePedidos.listaPedidosEnEspera
            .sort((a, b) => a.fechaHoraPedido.compareTo(b.fechaHoraPedido));
        controladorDePedidos.listaPedidosAceptados
            .sort((a, b) => a.fechaHoraPedido.compareTo(b.fechaHoraPedido));
        controladorDePedidos.listaPedidosFinalizados
            .sort((a, b) => a.fechaHoraPedido.compareTo(b.fechaHoraPedido));
        break;
           case 'Cantidad':
        
        controladorDePedidos.listaPedidosEnEspera
            .sort((a, b) => a.cantidadPedido.compareTo(b.cantidadPedido));
        controladorDePedidos.listaPedidosAceptados
            .sort((a, b) => a.cantidadPedido.compareTo(b.cantidadPedido));
        controladorDePedidos.listaPedidosFinalizados
            .sort((a, b) => a.cantidadPedido.compareTo(b.cantidadPedido));
        break;
          case 'Dirección':
        
        controladorDePedidos.listaPedidosEnEspera
            .sort((a, b) => a.direccionUsuario!.compareTo(b.direccionUsuario.toString()));
        controladorDePedidos.listaPedidosAceptados
            .sort((a, b) =>a.direccionUsuario!.compareTo(b.direccionUsuario.toString()));
        controladorDePedidos.listaPedidosFinalizados
            .sort((a, b) =>a.direccionUsuario!.compareTo(b.direccionUsuario.toString()));
        break;
                  case 'Cliente':
        
        controladorDePedidos.listaPedidosEnEspera
            .sort((a, b) => a.nombreUsuario!.compareTo(b.nombreUsuario.toString()));
        controladorDePedidos.listaPedidosAceptados
            .sort((a, b) => a.nombreUsuario!.compareTo(b.nombreUsuario.toString()));
        controladorDePedidos.listaPedidosFinalizados
            .sort((a, b) =>a.nombreUsuario!.compareTo(b.nombreUsuario.toString()));
        break;
    }
  }
}
