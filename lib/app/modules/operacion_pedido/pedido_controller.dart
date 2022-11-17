
import 'package:gasjm/app/data/controllers/pedido_controller.dart'; 
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
 

class OperacionPedidoController extends GetxController { 
  final _personaRepository = Get.find<PersonaRepository>();
//
  RxString imagenUsuario = ''.obs;

  //Pedidos en espera

  final RxList<PedidoModel> _listaPedidosEnEspera = <PedidoModel>[].obs;
  RxList<PedidoModel> get listaPedidosEnEspera => _listaPedidosEnEspera;
  //Pedidos aceptados

  final RxList<PedidoModel> _listaPedidosAceptados = <PedidoModel>[].obs;
  RxList<PedidoModel> get listaPedidosAceptados => _listaPedidosAceptados;

  //Pedidos finalizados

  final RxList<PedidoModel> _listaPedidosFinalizados = <PedidoModel>[].obs;
  RxList<PedidoModel> get listaPedidosFinalizados => _listaPedidosFinalizados;
//Pedidos cancelados

  final RxList<PedidoModel> _listaPedidosCancelados = <PedidoModel>[].obs;
  RxList<PedidoModel> get listaPedidosCancelados => _listaPedidosCancelados;

  ///pARA EL DETALLE del pedido
  RxInt currentStep = 0.obs;
  RxBool activeStep1 = true.obs;
  RxBool activeStep2 = false.obs;

  ///
  final PedidoController controladorDePedidos = Get.put(PedidoController());

  ///
  @override
  void onInit() {
    Future.wait([
      _cargarFotoPerfil(),
    ]);

    controladorDePedidos.cargarListaPedidos(0);
    controladorDePedidos.cargarListaPedidos(1);
    controladorDePedidos.cargarListaPedidos(2);
    controladorDePedidos.cargarListaPedidos(3);

    super.onInit();
  }

  /* METODOS  */
  Future<void> _cargarFotoPerfil() async {
    imagenUsuario.value =
        await _personaRepository.getImagenUsuarioActual() ?? '';
  }

  Future<String> _getNombresCliente(String cedula) async {
    final nombre =
        await _personaRepository.getNombresPersonaPorCedula(cedula: cedula);
    return nombre ?? 'Usuario';
  }

  Future<String> _getDireccionXLatLng(LatLng posicion) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(posicion.latitude, posicion.longitude);
    Placemark lugar = placemark[0];

//
    return _getDireccion(lugar);
  }

  String _getDireccion(Placemark lugar) {
    //
    if (lugar.subLocality?.isEmpty == true) {
      return lugar.street.toString();
    } else {
      return '${lugar.street}, ${lugar.subLocality}';
    }
  }
}
