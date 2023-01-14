import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/controllers/autenticacion_controller.dart';

import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:gasjm/app/data/models/vehiculo_model.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:gasjm/app/data/repository/vehiculo_repository.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DetalleVehiculoController extends GetxController {
  final _personaRepository = Get.find<PersonaRepository>();
  final _vehiculoRepository = Get.find<VehiculoRepository>();

////Variables
  //Obtener imagen usuaior actual
  RxString imagenPerfil = Get.find<AutenticacionController>().imagenUsuario;

  //Variable para guardar datos del vehiculo
  late Vehiculo _vehiculo;
  Vehiculo get vehiculo => _vehiculo;

  //
  //Clave del formulario de resgistro de vehiculo
  final claveFormRegistrarVehiculo = GlobalKey<FormState>();
  //Variables para controladores de campos de texto del formulario
  final placaTextoController = TextEditingController();
  final marcaTextoController = TextEditingController();
  final modeloTextoController = TextEditingController();
  final anioTextoController = TextEditingController();
  final observacionTextoController = TextEditingController();

  //varialbe para el modo editable;
  bool vehiculoEditable = false;

  //Variable para visualizar el estado de carga de datos
  final cargandoVehiculo = true.obs;

  //Existe algun error si o no
  final errorParaDatosVehiculo = Rx<String?>(null);

  //Lista de repartidores
  List<PersonaModel> _listaRepartidores = <PersonaModel>[];
  List<PersonaModel> get listaRepartidores => _listaRepartidores;

  //Valor inicial de la lista de repartidores dropdown

  //Variable para foto del vehiculo
  final picker = ImagePicker();
  Rx<File?> pickedImage = Rx(null);
  Rx<bool> existeImagenPerfil = false.obs;
  /* METODOS PROPIOS */
  @override
  void onInit() {
    //Obtner argumentos

    _vehiculo = Get.arguments[0];
    vehiculoEditable = Get.arguments[1];
    //
    print(vehiculo.idVehiculo);

    //
    Future.wait([_cargarDatosDelFormVehiculo()]);

    //Obtener lista de repartidores
    _cargarListaDeRepartidores();

    super.onInit();
  }

  /* METODOS PARA VEHICULO */

  Future<void> _cargarDatosDelFormVehiculo() async {
    try {
      cargandoVehiculo.value = true;

      // obtner nombres de los repartidor
 /*     var aux = listaRepartidores
          .where((element) => element.uidPersona == vehiculo.idRepartidor)
          .first;
*/
      //
          //
      if (vehiculo.fotoVehiculo != null) {
        existeImagenPerfil.value = true;
      }

      //
      //
      placaTextoController.text = vehiculo.placaVehiculo;
      marcaTextoController.text = vehiculo.marcaVehiculo;
      modeloTextoController.text = vehiculo.modeloVehiculo;
      anioTextoController.text = '${vehiculo.anioVehiculo}';
      observacionTextoController.text = vehiculo.observacionVehiculo ?? '';
    } catch (e) {
      Mensajes.showGetSnackbar(
          titulo: "Error",
          mensaje: "Se produjo un error inesperado.",
          icono: const Icon(
            Icons.error_outline_outlined,
            color: Colors.white,
          ));
    }
    cargandoVehiculo.value = false;
  }

  //Obtener lista de repartisores activos
  void _cargarListaDeRepartidores() async {
    try {
      final lista = (await _personaRepository.getNombresPorField(
          field: 'idPerfil', dato: 'repartidor'));

      //
      for (var i = 0; i < lista.length; i++) {
        lista[i].nombreUsuario =
            '${lista[i].nombrePersona} ${lista[i].apellidoPersona}';
      }
      _listaRepartidores = lista;
      //
    } catch (e) {
      //
      Exception('Error al cargar repartidores.');
    }
  }

  void cargarDetalleDelRepartidor(PersonaModel cliente) {
    Get.offNamed(AppRoutes.detalleCliente, arguments: cliente);
  }

//Registrar nuevo vehiculo
  registrarVehiculo() {
    //Obtener datos
    String idRepartidor = '';
    String placaVehiculo = placaTextoController.text;
    String marcaVehiculo = marcaTextoController.text;
    String modeloVehiculo = modeloTextoController.text;
    int anioVehiculo = int.parse(anioTextoController.text);
    String observacionVehiculo = observacionTextoController.text;

//
    try {
      cargandoVehiculo.value = true;
      errorParaDatosVehiculo.value = null;

      //Guardar en model

      Vehiculo vehiculo = Vehiculo(
          idRepartidor: idRepartidor,
          placaVehiculo: placaVehiculo,
          marcaVehiculo: marcaVehiculo,
          modeloVehiculo: modeloVehiculo,
          anioVehiculo: anioVehiculo,
          observacionVehiculo: observacionVehiculo);
      //En firebase
      _vehiculoRepository.insertVehiculo(
          vehiculo: vehiculo, imagen: pickedImage.value);

      //

      //Mensaje de ingreso
      Mensajes.showGetSnackbar(
          titulo: 'Mensaje',
          mensaje: 'Vehículo guardado',
          icono: const Icon(
            Icons.save_outlined,
            color: Colors.white,
          ));

      //
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
    cargandoVehiculo.value = false;
  }
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

//Actualizar datos de vehiculo
  actualizarVehiculo() {
    //Obtener datos
    String idRepartidor = '';
    String placaVehiculo = placaTextoController.text;
    String marcaVehiculo = marcaTextoController.text;
    String modeloVehiculo = modeloTextoController.text;
    int anioVehiculo = int.parse(anioTextoController.text);
    String observacionVehiculo = observacionTextoController.text;

    try {
      cargandoVehiculo.value = true;
      errorParaDatosVehiculo.value = null;

      Vehiculo vehiculo = Vehiculo(
          idRepartidor: idRepartidor,
          placaVehiculo: placaVehiculo,
          marcaVehiculo: marcaVehiculo,
          modeloVehiculo: modeloVehiculo,
          anioVehiculo: anioVehiculo,
          observacionVehiculo: observacionVehiculo);
      //En firebase
      _vehiculoRepository.insertVehiculo(
          vehiculo: vehiculo, imagen: pickedImage.value);

      //Mensaje de ingreso
      Mensajes.showGetSnackbar(
          titulo: 'Mensaje',
          mensaje: '¡Se actualizo con éxito!',
          icono: const Icon(
            Icons.save_outlined,
            color: Colors.white,
          ));
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
    cargandoVehiculo.value = false;
  }
}
