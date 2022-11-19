import 'package:gasjm/app/data/controllers/pedido_controller.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:get/get.dart';

class PedidosController extends GetxController {
  /* VARIABLES*/

  final _personaRepository = Get.find<PersonaRepository>();

  final cargandoPedidosEnEspera = true.obs;
  final cargandoPedidosAceptados = true.obs;

  //RxList<PedidoModel> dataGame = <PedidoModel>[].obs;
  final RxList<PedidoModel> _listaPedidosEnEspera = <PedidoModel>[].obs;
  RxList<PedidoModel> get listaPedidosEnEspera => _listaPedidosEnEspera;

  final RxList<PedidoModel> _listaFiltradaPedidosEnEspera = <PedidoModel>[].obs;
  RxList<PedidoModel> get listaFiltradaPedidosEnEspera =>
      _listaFiltradaPedidosEnEspera;

  final RxList<PedidoModel> _listaPedidosAceptados = <PedidoModel>[].obs;
  RxList<PedidoModel> get listaPedidosAceptados => _listaPedidosAceptados;

  final RxList<PedidoModel> _listaFiltradaPedidosAceptados =
      <PedidoModel>[].obs;
  RxList<PedidoModel> get listaFiltradaPedidosAceptados =>
      _listaFiltradaPedidosAceptados;

  //:TODO Pedidos aceptados (filtro diseno)

  //Lista para ordenar los pedidos por diferentes categorias

  List<String> dropdownItemsDeOrdenamiento = [
    "Ordenar por fecha",
    "Ordenar por cantidad",
    "Ordenar por tiempo",
    "Ordenar por dirección",
    "Ordenar por cliente"
  ];
  RxString valorSeleccionadoItemDeOrdenamiento = 'Ordenar por'.obs;
  RxString valorSeleccionadoItemDeOrdenamientoAceptados = 'Ordenar por'.obs;
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

    controladorDePedidos.cargarListaPedidosParaRepartidor(0);
    controladorDePedidos.cargarListaPedidosParaRepartidor(1);
  }

  /* METODOS PARA PEDIDOS EN ESPERA */
  Future<void> _cargarFotoPerfil() async {
    imagenUsuario.value =
        await _personaRepository.getImagenUsuarioActual() ?? '';
  }
/*
  void cargarListaPedidosEnEspera() async {
    try {
      cargandoPedidosEnEspera.value = true;
      final lista = (await _pedidosRepository.getPedidosPorField(
              field: 'idEstadoPedido', dato: 'estado1')) ??
          [];

      //
      for (var i = 0; i < lista.length; i++) {
        final nombre = await _getNombresCliente(lista[i].idCliente);
        final direccion = await _getDireccionXLatLng(
            LatLng(lista[i].direccion.latitud, lista[i].direccion.longitud));
        lista[i].nombreUsuario = nombre;
        lista[i].direccionUsuario = direccion;
      }

      _listaPedidosEnEspera.value = lista;
      //Cargar la lista filtrada al inicio todos
//      _listaFiltradaPedidosEnEspera.value = _listaPedidosEnEspera;
      cargarListaFiltradaDePedidosEnEspera();
    } on FirebaseException {
      Mensajes.showGetSnackbar(
          titulo: "Error",
          mensaje: "Se produjo un error inesperado.",
          icono: const Icon(
            Icons.error_outline_outlined,
            color: Colors.white,
          ));
    }
    cargandoPedidosEnEspera.value = false;
  }
*/
  /*Future<String> _getNombresCliente(String cedula) async {
    final nombre =
        await _personaRepository.getNombresPersonaPorCedula(cedula: cedula);
    return nombre ?? 'Usuario';
  }*/
}
