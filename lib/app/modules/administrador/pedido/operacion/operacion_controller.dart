import 'package:gasjm/app/data/controllers/pedido_controller.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:get/get.dart';

class OperacionPedidoController extends GetxController {
  final _personaRepository = Get.find<PersonaRepository>();
  //Variable  para imagen de perfil
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
  ///
  RxString indiceCategoriaSeleccionada = 'Fecha'.obs;
  
    final listaCategoriasDeOrdenamiento = [
    "Fecha",
    "Cantidad",
    "Dirección",
    "Cliente"
  ];

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
                    controladorDePedidos.listaPedidosCancelados
            .sort((a, b) => a.fechaHoraPedido.compareTo(b.fechaHoraPedido));
        break;
           case 'Cantidad':
        
        controladorDePedidos.listaPedidosEnEspera
            .sort((a, b) => a.cantidadPedido.compareTo(b.cantidadPedido));
        controladorDePedidos.listaPedidosAceptados
            .sort((a, b) => a.cantidadPedido.compareTo(b.cantidadPedido));
        controladorDePedidos.listaPedidosFinalizados
            .sort((a, b) => a.cantidadPedido.compareTo(b.cantidadPedido));
                controladorDePedidos.listaPedidosCancelados
            .sort((a, b) => a.cantidadPedido.compareTo(b.cantidadPedido));
        break;
          case 'Dirección':
        
        controladorDePedidos.listaPedidosEnEspera
            .sort((a, b) => a.direccionUsuario!.compareTo(b.direccionUsuario.toString()));
        controladorDePedidos.listaPedidosAceptados
            .sort((a, b) =>a.direccionUsuario!.compareTo(b.direccionUsuario.toString()));
        controladorDePedidos.listaPedidosFinalizados
            .sort((a, b) =>a.direccionUsuario!.compareTo(b.direccionUsuario.toString()));
                    controladorDePedidos.listaPedidosCancelados
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
