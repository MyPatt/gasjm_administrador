import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/map_style.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PerfilController extends GetxController {
//Clave del formulario de resgistro de usuario
  final claveFormRegistrar = GlobalKey<FormState>();
  final claveFormContrasena = GlobalKey<FormState>();

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
  late PersonaModel _usuario;
  PersonaModel get usuario => _usuario;

  final _personaRepository = Get.find<PersonaRepository>();

//Listas observables de los clientes

  final RxList<PersonaModel> _listaClientes = <PersonaModel>[].obs;
  RxList<PersonaModel> get listaClientes => _listaClientes;

  final RxList<PersonaModel> _listaFiltradaClientes = <PersonaModel>[].obs;
  RxList<PersonaModel> get listaFiltradaClientes => _listaFiltradaClientes;

  //Existe algun error si o no
  final errorDeDatos = Rx<String?>(null);
  //Se cago si o no
  final cargandoDatos = RxBool(false);

  /* Variables para google maps */
  TextEditingController direccionAuxTextoController = TextEditingController();
  Direccion direccionPersona = Direccion(latitud: 0, longitud: 0);

  final Rx<LatLng> _posicionInicialCliente =
      const LatLng(-12.122711, -77.027475).obs;

  Rx<LatLng> get posicionInicialCliente => _posicionInicialCliente.value.obs;
  final Rx<LatLng> _posicionAuxCliente =
      const LatLng(-12.122711, -77.027475).obs;

  Rx<LatLng> get posicionAuxCliente => _posicionAuxCliente.value.obs;

  final Map<MarkerId, Marker> _marcadores = {};
  Set<Marker> get marcadores => _marcadores.values.toSet();

  late String id = 'MakerIdAdministrador';

  //USER IMAGE
  final picker = ImagePicker();
  Rx<File> pickedImage = Rx(new File(
                'assets/icons/profile.png'));

  /* METODOS PROPIOS */
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    Future.wait([_cargarDatosDelFormCliente()]);
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    cedulaTextoController.clear();
    nombreTextoController.clear();
    apellidoTextoController.clear();
    direccionTextoController.clear();
    fechaNacimientoTextoController.clear();
    celularTextoController.clear();
    correoElectronicoTextoController.clear();
    contrasenaTextoController.clear();
  }

  /* METODOS PARA CLIENTES */

  Future<void> _cargarDatosDelFormCliente() async {
    try {
      _usuario = (await _personaRepository.getUsuario())!;
      //
      cedulaTextoController.text = usuario.cedulaPersona;
      nombreTextoController.text = usuario.nombrePersona;
      apellidoTextoController.text = usuario.apellidoPersona;

      fechaNacimientoTextoController.text = usuario.fechaNaciPersona ?? '';
      celularTextoController.text = usuario.celularPersona ?? '';
      correoElectronicoTextoController.text = usuario.correoPersona ?? '';
      String direccion = await _getDireccionXLatLng(LatLng(
          usuario.direccionPersona?.latitud ?? 0,
          usuario.direccionPersona?.longitud ?? 0));
      direccionTextoController.text = direccion;

      _posicionInicialCliente.value = LatLng(
          usuario.direccionPersona?.latitud ?? 0,
          usuario.direccionPersona?.longitud ?? 0);
      contrasenaTextoController.text = usuario.contrasenaPersona;
    } on FirebaseException {
      Mensajes.showGetSnackbar(
          titulo: "Error",
          mensaje: "Se produjo un error inesperado.",
          icono: const Icon(
            Icons.error_outline_outlined,
            color: Colors.white,
          ));
    }
  }

//
  Future<void> selectDate(BuildContext context) async {
    DateTime? fechaNacimiento = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      helpText: "Seleccione una fecha".toUpperCase(),
      cancelText: "Cancelar",
      confirmText: "Aceptar",
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
  void onChangedIdentificacion(valor) {
    if (valor.length > 9) {
      cedulaTextoController.text = valor;
    }
  }

  //
  //Visualizar texto de lacontrasena
  void mostrarContrasena() {
    _contrasenaOculta.value = _contrasenaOculta.value ? false : true;
  }

  Future<String> _getDireccionXLatLng(LatLng posicion) async {
    print(posicion);
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

  Future<void> guardarCliente() async {
    //Obtener datos
    final String cedulaPersona = cedulaTextoController.text;
    final String nombrePersona = nombreTextoController.text;
    final String apellidoPersona = apellidoTextoController.text;
    final String? correoPersona = correoElectronicoTextoController.text;
    final String? fotoPersona = '';

    final String? celularPersona = celularTextoController.text;
    final String? fechaNaciPersona = fechaNacimientoTextoController.text;
    //final String? estadoPersona = cliente.estadoPersona;
    final String idPerfil = usuario.idPerfil;
    final String contrasenaPersona = contrasenaTextoController.text;

//
    try {
      cargandoDatos.value = true;
      errorDeDatos.value = null;
      //

      //Guardar en model
      PersonaModel usuarioDatos = PersonaModel(
          uidPersona: usuario.uidPersona,
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
          estadoPersona: usuario.estadoPersona);

//En firebase
      await _personaRepository.updatePersona(persona: usuarioDatos);

      //

      //Mensaje de ingreso
      Mensajes.showGetSnackbar(
          titulo: 'Mensaje',
          mensaje: '¡Se actualizo con éxito!',
          icono: const Icon(
            Icons.save_outlined,
            color: Colors.white,
          ));

      //
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorDeDatos.value = 'La contraseña es demasiado débil';
      } else if (e.code == 'email-already-in-use') {
        errorDeDatos.value = 'La cuenta ya existe para ese correo electrónico';
      } else {
        errorDeDatos.value = "Se produjo un error inesperado.";
      }
    } catch (e) {
      Mensajes.showGetSnackbar(
          titulo: 'Alerta',
          mensaje:
              'Ha ocurrido un error, por favor inténtelo de nuevo más tarde.',
          duracion: const Duration(seconds: 4),
          icono: const Icon(
            Icons.error_outline_outlined,
            color: Colors.white,
          ));
    }
    cargandoDatos.value = false;
  }

  /* ACTUALIZAR DIRECCION - GOOGLE MAP*/

  void onMapaCreado(GoogleMapController controller) {
    controller.setMapStyle(estiloMapa);
    // _agregarMarcadorCliente();
    // notifyListeners();
  }

  Future<void> agregarMarcadorCliente() async {
    final markerId = MarkerId(id);

    final marker = Marker(
        markerId: markerId,
        position: _posicionAuxCliente.value,
        draggable: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(
            AppTheme.blueBackground.blue.toDouble())
        // icon: _marcadorCliente,
        );

    _marcadores[markerId] = marker;
  }

  void onCameraMove(CameraPosition position) async {
    _posicionAuxCliente.value = position.target;

    final markerId = MarkerId(id);
    final marker = _marcadores[markerId];

    Marker updatedMarker = marker?.copyWith(
            positionParam: position.target,
            iconParam: BitmapDescriptor.defaultMarkerWithHue(
                AppTheme.blueBackground.blue.toDouble())) ??
        Marker(
          markerId: markerId,
        );

    _marcadores[markerId] = updatedMarker;
  }

  void getMovimientoCamara() async {
    List<Placemark> placemark = await placemarkFromCoordinates(
        _posicionAuxCliente.value.latitude, _posicionAuxCliente.value.longitude,
        localeIdentifier: "en_US");
    direccionAuxTextoController.text = placemark[0].name!;
  }

  seleccionarNuevaDireccion() {
    direccionTextoController.text = direccionAuxTextoController.text;
    _posicionInicialCliente.value = _posicionAuxCliente.value;
    direccionPersona = Direccion(
        latitud: posicionInicialCliente.value.latitude,
        longitud: posicionInicialCliente.value.longitude);

    ///
    Get.back();
  }

  cargarDireccionActual() {
    _posicionAuxCliente.value = posicionInicialCliente.value;
    print(_posicionInicialCliente.value);
    print(_posicionAuxCliente.value);
    Get.toNamed(AppRoutes.direccion);
  }

  Future<void> cargarImagen() async {
     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
  
    print("********");
    print(pickedImage?.name);
    print(pickedImage?.path);
    if (pickedImage != null) {
      setImage(File(pickedImage.path));
 
    }
  }

  void setImage(File imageFile) async {
    pickedImage.value = imageFile;
    //  emit(state.copyWith(pickedImage: imageFile));
  }
}
