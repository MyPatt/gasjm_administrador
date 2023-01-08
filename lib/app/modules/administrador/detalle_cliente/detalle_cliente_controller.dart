import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/models/estadopedido_model.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:gasjm/app/data/repository/pedido_repository.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:gasjm/app/modules/administrador/detalle_cliente/detalle_cliente_binding.dart';
import 'package:gasjm/app/modules/administrador/detalle_cliente/widgets/detalle/detalle_page.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class EditarClienteController extends GetxController {
//Clave del formulario de resgistro de usuario
  final claveFormRegistrar = GlobalKey<FormState>();

  //Variables para controladores de campos de texto del formulario
  final cedulaTextoController = TextEditingController();
  final nombreTextoController = TextEditingController();
  final apellidoTextoController = TextEditingController();
  final direccionTextoController = TextEditingController();
  final fechaNacimientoTextoController = TextEditingController();
  final celularTextoController = TextEditingController();
  final correoElectronicoTextoController = TextEditingController();
  final contrasenaTextoController = TextEditingController();
  //Variables para ocultar el texto de la contrasena
  final RxBool _contrasenaOculta = true.obs;
  RxBool get contrasenaOculta => _contrasenaOculta;
  late PersonaModel _cliente;
  PersonaModel get cliente => _cliente;

//
  final _pedidosRepository = Get.find<PedidoRepository>();
  final _personaRepository = Get.find<PersonaRepository>();

  final cargandoCliente = true.obs;

//Listas observables de los clientes

  //Existe algun error si o no
  final errorParaCorreo = Rx<String?>(null);
//varialbe para el modo editable;
  bool clienteEditable = false;
  /* METODOS PROPIOS */
  @override
  void onInit() {
    var argumentos = Get.arguments;
    _cliente = argumentos[0] as PersonaModel;
    clienteEditable = argumentos[1] as bool;
    //
    Future.wait([_cargarDatosDelFormCliente()]);

    //
    cargarListaPedidosRealizadosPorCliente();

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    cedulaTextoController.dispose();
    nombreTextoController.dispose();
    apellidoTextoController.dispose();
    direccionTextoController.dispose();
    fechaNacimientoTextoController.dispose();
    celularTextoController.dispose();
    correoElectronicoTextoController.clear();
    contrasenaTextoController.dispose();
  }

  /* METODOS PARA CLIENTES */

  Future<void> _cargarDatosDelFormCliente() async {
    try {
      cargandoCliente.value = true;

      //
      cedulaTextoController.text = cliente.cedulaPersona;
      nombreTextoController.text = cliente.nombrePersona;
      apellidoTextoController.text = cliente.apellidoPersona;
      String direccion = await _getDireccionXLatLng(LatLng(
          cliente.direccionPersona?.latitud ?? 0,
          cliente.direccionPersona?.longitud ?? 0));
      direccionTextoController.text = direccion;
      fechaNacimientoTextoController.text = cliente.fechaNaciPersona ?? '';
      celularTextoController.text = cliente.celularPersona ?? '';
      correoElectronicoTextoController.text = cliente.correoPersona ?? '';
      contrasenaTextoController.text = cliente.contrasenaPersona;
      //} on FirebaseException catch (e) {
    } catch (e) {
      Mensajes.showGetSnackbar(
          titulo: "Error",
          mensaje: "Se produjo un error inesperado.",
          icono: const Icon(
            Icons.error_outline_outlined,
            color: Colors.white,
          ));
    }
    cargandoCliente.value = false;
  }

//
  Future<void> seleccionaFechaNacimiento(BuildContext context) async {
    DateTime? fechaNacimiento = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppTheme.blueBackground,
              onPrimary: Colors.white,
              onSurface: AppTheme.blueDark,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: AppTheme.blueBackground,
                // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      locale: const Locale(
        'es',
      ),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      firstDate: DateTime(DateTime.now().year - 65),
      lastDate: DateTime(DateTime.now().year - 18),
      initialDate: DateTime(DateTime.now().year - 20),
    );

    if (fechaNacimiento != null) {
      fechaNacimientoTextoController.text = fechaNacimiento.day.toString() +
          '/' +
          fechaNacimiento.month.toString() +
          '/' +
          fechaNacimiento.year.toString();
      //

    }
  }

  //
  //Visualizar texto de lacontrasena
  void mostrarContrasena() {
    _contrasenaOculta.value = _contrasenaOculta.value ? false : true;
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

  //
  //Metodo para actualizar datos

  Future<void> actualizarCliente() async {
    //Obtener datos
    final String cedulaPersona = cedulaTextoController.text;
    final String nombrePersona = nombreTextoController.text;
    final String apellidoPersona = apellidoTextoController.text;
    final String? correoPersona = correoElectronicoTextoController.text;

    final String? fotoPersona = cliente.fotoPersona;
    final Direccion? direccionPersona = cliente.direccionPersona;
    final String? celularPersona = celularTextoController.text;
    final String? fechaNaciPersona = fechaNacimientoTextoController.text;
    final String? estadoPersona = cliente.estadoPersona;
    final String idPerfil = cliente.idPerfil;
    final String contrasenaPersona = contrasenaTextoController.text;

    try {
      cargandoCliente.value = true;
      errorParaCorreo.value = null;
      //
      File? pickedImage;
      //Guardar en model
      PersonaModel usuarioDatos = PersonaModel(
          uidPersona: cliente.uidPersona,
          cedulaPersona: cedulaPersona,
          nombrePersona: nombrePersona,
          apellidoPersona: apellidoPersona,
          idPerfil: idPerfil,
          contrasenaPersona: contrasenaPersona,
          correoPersona: correoPersona,
          fotoPersona: fotoPersona,
          direccionPersona: direccionPersona,
          celularPersona: celularPersona,
          fechaNaciPersona: fechaNaciPersona,
          estadoPersona: estadoPersona);

//En firebase
      await _personaRepository.updatePersona(
          persona: usuarioDatos, image: pickedImage);

      //

      //Mensaje de ingreso
      Mensajes.showGetSnackbar(
          titulo: 'Mensaje',
          mensaje: '¡Se actualizo con éxito!',
          icono: const Icon(
            Icons.save_outlined,
            color: Colors.white,
          ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorParaCorreo.value = 'La contraseña es demasiado débil';
      } else if (e.code == 'email-already-in-use') {
        errorParaCorreo.value =
            'La cuenta ya existe para ese correo electrónico';
      } else {
        errorParaCorreo.value =
            "Ha ocurrido un error, por favor inténtelo de nuevo más tarde.";
      }
    } catch (e) {
      errorParaCorreo.value =
          "Ha ocurrido un error, por favor inténtelo de nuevo más tarde.";
    }
    cargandoCliente.value = false;
  }

  ///////////
  //
  RxBool cargandoDetalle = false.obs;
  final Rx<EstadoDelPedido> _estadoPedido1 = EstadoDelPedido(
          idEstado: "null", fechaHoraEstado: Timestamp.now(), idPersona: "")
      .obs;
  final Rx<EstadoDelPedido> _estadoPedido3 = EstadoDelPedido(
          idEstado: "null", fechaHoraEstado: Timestamp.now(), idPersona: "")
      .obs;
  Rx<EstadoDelPedido> get estadoPedido1 => _estadoPedido1;
  Rx<EstadoDelPedido> get estadoPedido3 => _estadoPedido3;
  //El estadoPedido2 se usa por el repartidor
  Future<void> cargarDetalle(PedidoModel pedido) async {
    _cargarPaginaDetalle(pedido);
    //Limpiar datos
    _estadoPedido1.value = EstadoDelPedido(
        idEstado: "null", fechaHoraEstado: Timestamp.now(), idPersona: "");
    _estadoPedido3.value = EstadoDelPedido(
        idEstado: "null", fechaHoraEstado: Timestamp.now(), idPersona: "");
//
    try {
      cargandoDetalle.value = true;
      //
      var aux1 = await _pedidosRepository.getEstadoPedidoPorField(
          uid: pedido.idPedido, field: "estadoPedido1");
      var aux3 = await _pedidosRepository.getEstadoPedidoPorField(
          uid: pedido.idPedido, field: "estadoPedido3");

      if (aux1 != null) {
        aux1.nombreEstado = await _getNombreEstado(aux1.idEstado);
        aux1.nombreUsuario = await _personaRepository.getNombresPersonaPorUid(
            uid: aux1.idPersona);
        _estadoPedido1.value = aux1;
      }

      if (aux3 != null) {
        aux3.nombreEstado = await _getNombreEstado(aux3.idEstado);
        aux3.nombreUsuario = await _personaRepository.getNombresPersonaPorUid(
            uid: aux3.idPersona);
        _estadoPedido3.value = aux3;
      }

      //

    } catch (e) {
      Exception("Error al cargar detalle del pedido");
    }
    cargandoDetalle.value = false;
  }

  void _cargarPaginaDetalle(PedidoModel pedido) {
    Get.to(
        DetalleHistorial(
          pedido: pedido,
          cargandoDetalle: cargandoDetalle,
          formatoHoraFecha: formatoHoraFecha,
          estadoPedido1: estadoPedido1,
          estadoPedido3: estadoPedido3,
        ),
        binding: EditarClienteBinding(),
        routeName: 'detalle');
  }

  String formatoHoraFecha(Timestamp fecha) {
    String formatoFecha = DateFormat.yMd("es").format(fecha.toDate());
    String formatoHora = DateFormat.Hm("es").format(fecha.toDate());
    return "$formatoHora $formatoFecha";
  }

  //Metodo para encontrar el  nombre del estado
  Future<String> _getNombreEstado(String idEstado) async {
    final nombre =
        await _pedidosRepository.getNombreEstadoPedidoPorId(idEstado: idEstado);
    return nombre ?? 'Pedido';
  }

  final cargandoPedidos = true.obs;

  //Pedidos realizado

  final RxList<PedidoModel> _listaPedidosRealizados = <PedidoModel>[].obs;

  RxList<PedidoModel> get listaPedidosRealizados => _listaPedidosRealizados;

  //Obtener fecha de los pedidos
  final RxList<Timestamp> _listaFechas = <Timestamp>[].obs;
  RxList<Timestamp> get listaFechas => _listaFechas;

//
  //Metodo para cargarLista de los pedidos para el administrador
  Future<void> cargarListaPedidosRealizadosPorCliente() async {
    try {
      cargandoPedidos.value = true;
      //Obtener uid del usuario actual
      String _idCliente = cliente.uidPersona!;
      String _nombreCliente = _personaRepository.nombreUsuarioActual;

      //Guardar en una var auxilar la lista
      var lista = await _pedidosRepository.getListaPedidosPorField(
              field: "idCliente", dato: _idCliente) ??
          [];
      //

      //Obtener datos del usuario y guardar
      for (var i = 0; i < lista.length; i++) {
        //  final nombre = await _getNombresCliente(lista[i].idCliente);
        final direccion = await _getDireccionXLatLng(
            LatLng(lista[i].direccion.latitud, lista[i].direccion.longitud));
        final estado = await _getNombreEstado(lista[i].idEstadoPedido);

        lista[i].nombreUsuario = _nombreCliente;
        lista[i].direccionUsuario = direccion;
        lista[i].estadoPedidoUsuario = estado;
        //
      }
      //
      var listFechasAux = lista.map((e) => e.fechaHoraPedido).toList();
//

      _listaFechas.value = listFechasAux;

      //La lista auxilaiar asignale a la lista observable
      _listaPedidosRealizados.value = lista;
    } on FirebaseException {
      Mensajes.showGetSnackbar(
          titulo: 'Alerta',
          mensaje:
              'Ha ocurrido un error, por favor inténtelo de nuevo más tarde.',
          icono: const Icon(
            Icons.error_outline_outlined,
            color: Colors.white,
          ));
    }
    cargandoPedidos.value = false;
  }
}
