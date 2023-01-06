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
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    final String? fotoPersona =cliente.fotoPersona;
    final Direccion? direccionPersona=cliente.direccionPersona;
    final String? celularPersona = celularTextoController.text;
    final String? fechaNaciPersona = fechaNacimientoTextoController.text;
    final String? estadoPersona = cliente.estadoPersona;
    final String idPerfil = cliente.idPerfil;
    final String contrasenaPersona = contrasenaTextoController.text;

//
    try {
      cargandoCliente.value = true;
      errorParaCorreo.value = null;
      //

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
          direccionPersona:direccionPersona,
          celularPersona: celularPersona,
          fechaNaciPersona: fechaNaciPersona,
          estadoPersona: estadoPersona);

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
 

}
