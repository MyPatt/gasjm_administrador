import 'package:gasjm/app/data/controllers/pedido_controller.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:get/get.dart';

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

    controladorDePedidos.cargarListaPedidosParaAdministrador(0);
    controladorDePedidos.cargarListaPedidosParaAdministrador(1);
    controladorDePedidos.cargarListaPedidosParaAdministrador(2);
    controladorDePedidos.cargarListaPedidosParaAdministrador(3);

    super.onInit();
  }

  /* METODOS  */
  Future<void> _cargarFotoPerfil() async {
    imagenUsuario.value =
        await _personaRepository.getImagenUsuarioActual() ?? '';
  }
}
