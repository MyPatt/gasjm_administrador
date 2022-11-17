import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/map_style.dart';
import 'package:gasjm/app/data/repository/pedido_repository.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InicioController extends GetxController {
  /* VARIABLES */

  //Repositorios

  final _pedidoRepository = Get.find<PedidoRepository>();
  final _personaRepository = Get.find<PersonaRepository>();

  //Para obtener datos del usuario conectado

  //Google Maps
  late StreamSubscription<Position> _posicionStreamSubscripcion;
  GoogleMapController? _mapController;
  late bool _gpsEnabled;

  //Marcadores para el mapa del explorador

  final Map<MarkerId, Marker> _marcadoresParaExplorar = {};
  Set<Marker> get marcadoresParaExplorar =>
      _marcadoresParaExplorar.values.toSet();

  final _controladorDelMarcador = StreamController<String>.broadcast();

  Stream<String> get onMarcadorTap => _controladorDelMarcador.stream;

  //Posiciones de los marcadores
  final posicionInicialRepartidor = const LatLng(-0.2053476, -79.4894387).obs;
  final posicionMarcadorRepartidor = const LatLng(-0.2053476, -79.4894387).obs;

  Position? _lastPosition;

  //Marcador para el repartidor actual
  MarkerId _marcadorRepartidorId = const MarkerId("MakerIdRepartidor");
  late BitmapDescriptor iconoMarcadorRepartidor;
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
    //
    _gpsEnabled = true;
    Future.wait([
      _getUsuarioActual(),
      _getLocalizacionActual(),
      _cargarDatosParaMarcadorRepartidor(),
      _initLocationUpdate()
    ]);
  }

  /* METODOS PARA OBTENER CEDULA DEL USUARIO */
  Future<void> _getUsuarioActual() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final cedulaUsuarioActual = prefs.getString("cedula_usuario");
    _marcadorRepartidorId = MarkerId(cedulaUsuarioActual.toString());
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
    print("eeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    //Icono para el marcador pedido en espera
    BitmapDescriptor _marcadorPedido = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/icons/marcadorpedido.png",
    );

    //Icono para el marcador pedido aceptado
    BitmapDescriptor _marcadorPedido2 = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/icons/marcadorpedido2.png",
    );

    //Marcador auxiliar
    BitmapDescriptor auxMarcador = _marcadorPedido;

    //Obtener la lista de los pedidos en espera y aceptados
    final listaPedidos = await _pedidoRepository.getPedidosEnEsperaYAceptados();

    listaPedidos.forEach((elemento) async {
      final nombreCliente = await _personaRepository.getNombresPersonaPorCedula(
          cedula: elemento.idCliente);

      final id = _marcadoresParaExplorar.length.toString();

      final markerId = MarkerId(id);
      final posicion =
          LatLng(elemento.direccion.latitud, elemento.direccion.longitud);

      //Asignar el icono del marcador segun el tipo de estado del pedido
      if (elemento.idEstadoPedido == 'estado2') {
        auxMarcador = _marcadorPedido2;
      } else {
        auxMarcador = _marcadorPedido;
      }

      final marker = Marker(
          markerId: markerId,
          position: posicion,
          draggable: false,
          icon: auxMarcador,
          infoWindow: InfoWindow(
              title: nombreCliente,
              snippet:
                  'Para ${elemento.diaEntregaPedido.toLowerCase()},  ${elemento.cantidadPedido} cilindro/s de gas.',
              onTap: () {}));
      _marcadoresParaExplorar[markerId] = marker;
    });
  }

  //Obtener ubicacion

  Future<void> _getLocalizacionActual() async {
    bool servicioHbilitado;

    LocationPermission permiso;

    //Esta habilitado el servicio?
    servicioHbilitado = await Geolocator.isLocationServiceEnabled();
    if (!servicioHbilitado) {
      //si la ubicacion esta deshabilitado tieneactivarse
      //ya se muestra la ventana de bloc ubicacion  await Geolocator.openLocationSettings();
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
    //Posicion del repartidor
    posicionMarcadorRepartidor.value = posicionInicialRepartidor.value;
    BitmapDescriptor _iconoMarcadorRepartidor =
        await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/icons/camiongasjm.png",
    );

    final marker = Marker(
        markerId: _marcadorRepartidorId,
        position: posicionMarcadorRepartidor.value,
        draggable: false,
        icon: _iconoMarcadorRepartidor);

    _marcadoresParaExplorar[_marcadorRepartidorId] = marker;
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
          rotationParam: rotation,
        ) ??
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

  Future<void> _cargarDatosParaMarcadorRepartidor() async {
    //Icono del marcador
  }

  Future<void> _initLocationUpdate() async {
    bool inicializado = false;
    // await _posicionStreamSubscripcion.cancel();

    _posicionStreamSubscripcion = Geolocator.getPositionStream(
            desiredAccuracy: LocationAccuracy.high, distanceFilter: 5)
        .listen((posicion) async {
      _enviarPosicionDelRepartidorActual(posicion);

      if (!inicializado) {
        _setInitialPosition(posicion);
        inicializado = true;
      }
    }, onError: (e) {
      if (e is LocationServiceDisabledException) {
        _gpsEnabled = false;
        //update
      }
    });
  }

  void _setInitialPosition(Position position) {
    if (_gpsEnabled && posicionMarcadorRepartidor.value == null) {
      posicionMarcadorRepartidor.value =
          LatLng(position.latitude, position.longitude);
    }
  }
}
