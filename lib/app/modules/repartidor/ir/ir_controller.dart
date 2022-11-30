import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/map_style.dart';
import 'package:gasjm/app/data/controllers/usuario_controller.dart';
import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:gasjm/app/data/repository/pedido_repository.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IrController extends GetxController {
  /* VARIABLES */

  //Repositorios

  final _pedidoRepository = Get.find<PedidoRepository>();
  final _personaRepository = Get.find<PersonaRepository>();

  //Para obtener datos del usuario conectado

  Rx<PersonaModel?> usuario = Rx(null);
  final _controladorUsuario = Get.find<UsuarioController>();
  //Google Maps
  late StreamSubscription<Position> _posicionStreamSubscripcion;
  GoogleMapController? _mapController;
  late bool _gpsEnabled;
  Position? _initialPosition;
  Position? get initialPosition => _initialPosition;
  CameraPosition get initialCameraPosition => CameraPosition(
      target: LatLng(
        _initialPosition!.latitude,
        _initialPosition!.latitude,
      ),
      zoom: 18);

  //Marcadores para el mapa del explorador

  final Map<MarkerId, Marker> _marcadoresParaExplorar = {};
  Set<Marker> get marcadoresParaIr => _marcadoresParaExplorar.values.toSet();

  final _controladorDelMarcador = StreamController<String>.broadcast();

  Stream<String> get onMarcadorTap => _controladorDelMarcador.stream;

  //Posiciones de los marcadores
  final posicionInicialRepartidor = const LatLng(-0.2053476, -79.4894387).obs;
  final posicionMarcadorRepartidor = const LatLng(-0.2053476, -79.4894387).obs;
  Position? _lastPosition;
  final _marcadorRepartidorId = const MarkerId("MakerIdRepartidor");
//
  RxString imagenUsuario = ''.obs;
  //
  /* METODOS PROPIOS */
  @override
  Future<void> onInit() async {
    super.onInit();

    Future.wait([_cargarFotoPerfil()]);
    _cargarDatosIniciales();
  }

  @override
  void onClose() {
    super.onClose();
    _controladorDelMarcador.close();
    _posicionStreamSubscripcion.cancel();
  }

/*METODO PARA CARGAR DATOS DE INICIO */
  Future<void> _cargarFotoPerfil() async {
    imagenUsuario.value =
        await _personaRepository.getImagenUsuarioActual() ?? '';
  }

  void _cargarDatosIniciales() {
    _getUsuarioActual();
    _getLocalizacionActual();
    _gpsEnabled = true;

    _initLocationUpdate();
  }

  /* METODOS PARA OBTENER DATOS DEL USUARIO */
  _getUsuarioActual() {
    usuario.value = _controladorUsuario.usuario.value;
    //   usuario.value = await _personaRepository.getUsuario();
  }

  /*METODO PARA  MANEJO DE PANTALLA POR NAVEGACION BOTTOM*/

  pantallaSeleccionadaOnTap(int index, BuildContext context) {
    if (index == 1) {
      return;
    }
    if (index == 0) {
      _cargarExplorarPage();
      return;
    }
    if (index == 2) {
      _cargarPedidosPage();
      return;
    }
  }

  _cargarExplorarPage() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      Get.offNamed(AppRoutes.inicioAdministrador);
    } catch (e) {
      //
    }
  }

  _cargarPedidosPage() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      Get.offNamed(AppRoutes.pedidos);
    } catch (e) {
      //
    }
  }

  /*METODOS  PARA MAPA EXPLORAR*/

  onMapaCreated(GoogleMapController controller) {
    //Cambiar el estilo de mapa
    controller.setMapStyle(estiloMapa);
    _mapController = controller;

    //Cargar marcadores
    _cargarMarcadorRepartidor();
    _cargarMarcadoresPedidos();
  }

//Cargar los pedidos en espera y aceptados
  Future<void> _cargarMarcadoresPedidos() async {
    //Icono para el marcador pedido en espera
    BitmapDescriptor _marcadorPedido = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/icons/marcadorpedido.png",
    );

    //Obtener la lista de los pedidos en espera y aceptados

    final listaPedidosAceptados =
        await _pedidoRepository.getPedidosPorDosQueries(
            field1: "idEstadoPedido",
            dato1: "estado2",
            field2: "diaEntregaPedido",
            dato2: "Ahora");

    listaPedidosAceptados?.forEach((elemento) async {
      final nombreCliente = await _personaRepository.getNombresPersonaPorCedula(
          cedula: elemento.idCliente);

      final id = _marcadoresParaExplorar.length.toString();

      final markerId = MarkerId(id);
      final posicion =
          LatLng(elemento.direccion.latitud, elemento.direccion.longitud);

      final marker = Marker(
          markerId: markerId,
          position: posicion,
          draggable: false,
          icon: _marcadorPedido,
          infoWindow: InfoWindow(
              title: nombreCliente,
              snippet:
                  'Para ${elemento.diaEntregaPedido.toLowerCase()},  ${elemento.cantidadPedido} cilindro/s de gas.',
              onTap: () {}));
      _marcadoresParaExplorar[markerId] = marker;
    });
  }

  //Obtener ubicacion
  _getLocalizacionActual() async {
    bool servicioHbilitado;

    LocationPermission permiso;

    //Esta habilitado el servicio?
    servicioHbilitado = await Geolocator.isLocationServiceEnabled();
    if (!servicioHbilitado) {
      //si la ubicacion esta deshabilitado tieneactivarse
      await Geolocator.openLocationSettings();
      return Future.error('Servicio de ubicación deshabilitada.');
    }
    permiso = await Geolocator.checkPermission();
    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
      if (permiso == LocationPermission.denied) {
        //Si la ubicacion sigue dehabilitado mostrar sms
        return Future.error('Permiso de ubicación denegado.');
      }
    }
    if (permiso == LocationPermission.deniedForever) {
      //Permiso denegado por siempre
      return Future.error('Permiso de ubicación denegado de forma permanente.');
    }

    //Al obtener el permiso de ubicacion se accede a las coordenadas de la posicion
    _posicionStreamSubscripcion =
        Geolocator.getPositionStream().listen((Position posicion) {
      posicionInicialRepartidor.value =
          LatLng(posicion.latitude, posicion.longitude);
    });
  }

  //Cargar el marcador del repartidor con la ubicacion actual
  _cargarMarcadorRepartidor() async {
    //Icono del marcador
    BitmapDescriptor _marcadorRepartidor =
        await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/icons/camiongasjm.png",
    );

    //Posicion del repartidor
    posicionMarcadorRepartidor.value = posicionInicialRepartidor.value;

    final marker = Marker(
        markerId: _marcadorRepartidorId,
        position: posicionMarcadorRepartidor.value,
        draggable: false,
        icon: _marcadorRepartidor);

    _marcadoresParaExplorar[_marcadorRepartidorId] = marker;
  }

  Future<void> _initLocationUpdate() async {
    bool inicializado = false;
    // await _posicionStreamSubscripcion.cancel();

    _posicionStreamSubscripcion =
        Geolocator.getPositionStream().listen((posicion) async {
      _enviarPosicionDelRepartidorActual(posicion);

      if (!inicializado) {
        _setInitialPosition(posicion);
        inicializado = true;
      }

      if (_mapController != null) {
        final zoom = await _mapController!.getZoomLevel();
        final cameraUpdate = CameraUpdate.newLatLngZoom(
            LatLng(posicion.latitude, posicion.longitude), zoom);
        _mapController!.animateCamera(cameraUpdate);
      }
    });
  }

  void _enviarPosicionDelRepartidorActual(Position posicion) async {
    double rotation = 0;
    if (_lastPosition != null) {
      rotation = Geolocator.bearingBetween(_lastPosition!.latitude,
          _lastPosition!.longitude, posicion.latitude, posicion.longitude);
    }
    //
    final marcador = _marcadoresParaExplorar[_marcadorRepartidorId];

    BitmapDescriptor _iconoMarcadorRepartidor =
        await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/icons/camiongasjm.png",
    );

    Marker marcadorActualizado = marcador?.copyWith(
            positionParam: LatLng(posicion.latitude, posicion.longitude),
            iconParam: _iconoMarcadorRepartidor,
            anchorParam: const Offset(0.5, 0.7),
            rotationParam: rotation) ??
        Marker(
            markerId: _marcadorRepartidorId,
            icon: _iconoMarcadorRepartidor,
            anchor: const Offset(0.5, 0.7),
            rotation: rotation);

    _marcadoresParaExplorar[_marcadorRepartidorId] = marcadorActualizado;

    _lastPosition = posicion;

    posicionMarcadorRepartidor.value =
        LatLng(posicion.altitude, posicion.longitude);
  }

  void _setInitialPosition(Position position) {
    if (_gpsEnabled && _initialPosition == null) {
      _initialPosition = position;
    }
  }
}
//TODO: Mostrar el resto de repartidores opcional
