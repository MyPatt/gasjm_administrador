import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/controllers/autenticacion_controller.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';

import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

class RegistrarPersonaController extends GetxController {
  final _personaRepository = Get.find<PersonaRepository>();

////Variables
  //Obtener imagen usuario actual
  RxString imagenPerfil = Get.find<AutenticacionController>().imagenUsuario;

  //Clave del formulario de resgistro de vehiculo
  final claveFormRegistrarPersona = GlobalKey<FormState>();
  //Variables para controladores de campos de texto del formulario
  //Variables para ocultar el texto de la contrasena
  final RxBool _contrasenaOculta = true.obs;
  RxBool get contrasenaOculta => _contrasenaOculta;

  //Variables para controladores de campos de texto del formulario
  final cedulaTextoController = TextEditingController();
  final nombreTextoController = TextEditingController();
  final apellidoTextoController = TextEditingController();
  final correoElectronicoTextoController = TextEditingController();
  final fechaNacimientoTextoController = TextEditingController();
  final celularTextoController = TextEditingController();

  final contrasenaTextoController = TextEditingController();

  //Variable para visualizar el estado de carga de datos
  final cargandoPersona = false.obs;

  //Existe algun error si o no
  final errorParaDatosPersona = Rx<String?>(null);

  //Variable para foto del vehiculo
  final picker = ImagePicker();
  Rx<File?> pickedImage = Rx(null);
  //
  String perfil = '';
  /* METODOS PROPIOS */
  @override
  void onInit() {
    //
    perfil = Get.arguments;
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    //
    cedulaTextoController.dispose();
    nombreTextoController.dispose();
    apellidoTextoController.dispose();
    correoElectronicoTextoController.dispose();
    fechaNacimientoTextoController.dispose();
    celularTextoController.dispose();
    contrasenaTextoController.dispose();
  }

  /* METODOS PARA CLIENTES */

  //Metodo que obtiene imagen de galeria para el vehiculo

  Future<void> cargarImagen() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setImage(File(pickedImage.path));
    }
  }

  void setImage(File imageFile) async {
    pickedImage.value = imageFile;

    //  emit(state.copyWith(pickedImage: imageFile));
  }

  //Visualizar texto de lacontrasena
  void mostrarContrasena() {
    _contrasenaOculta.value = _contrasenaOculta.value ? false : true;
  }

//Metodo para registrar

  Future<void> registrarPersona(BuildContext context) async {
    //Obtener datos
    final cedula = cedulaTextoController.text;
    final nombre = nombreTextoController.text;
    final apellido = apellidoTextoController.text;
    final correo = correoElectronicoTextoController.text;
    final fechaNacimiento = fechaNacimientoTextoController.text;
    final celular = celularTextoController.text;
    final contrasena = contrasenaTextoController.text;

    //
    try {
      cargandoPersona.value = true;
      errorParaDatosPersona.value = null;
      //
      //
      LocationData location = await Location.instance.getLocation();
      Direccion direccionPersona = Direccion(
          latitud: location.latitude ?? 0.0,
          longitud: location.longitude ?? 0.0);

      //Guardar en model
      PersonaModel usuarioDatos = PersonaModel(
          cedulaPersona: cedula,
          nombrePersona: nombre,
          apellidoPersona: apellido,
          correoPersona: correo,
          fechaNaciPersona: fechaNacimiento,
          celularPersona: celular,
          estadoPersona: "activo",
          idPerfil: perfil,
          contrasenaPersona: contrasena,
          direccionPersona: direccionPersona);

      //En firebase
      await _personaRepository.insertPersona(
          persona: usuarioDatos, imagen: pickedImage.value);

      //Mensaje de ingreso
      Mensajes.showGetSnackbar(
          titulo: 'Mensaje',
          mensaje: 'Se registro con éxito.',
          icono: const Icon(
            Icons.waving_hand_outlined,
            color: Colors.white,
          ));
    
    //
        Future.delayed(const Duration(seconds: 1));
      //
      Navigator.pop(context);
      //
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorParaDatosPersona.value = 'La contraseña es demasiado débil';
      } else if (e.code == 'email-already-in-use') {
        errorParaDatosPersona.value =
            'La cuenta ya existe para ese correo electrónico';
      } else {
        errorParaDatosPersona.value = "Se produjo un error inesperado.";
      }
    } catch (e) {
        errorParaDatosPersona.value = "Inténtelo de nuevo más tarde.";

      //Exception('FooException');
      /*  Mensajes.showGetSnackbar(
          titulo: 'Alerta',
          mensaje:
              'Ha ocurrido un error, por favor inténtelo de nuevo más tarde.',
          duracion: const Duration(seconds: 4),
          icono: const Icon(
            Icons.error_outline_outlined,
            color: Colors.white,
          ));*/
    }
    cargandoPersona.value = false;
  }

  //
  Future<void> seleccionarFechaDeNacimiento(BuildContext context) async {
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
}
