import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/controllers/autenticacion_controller.dart';

import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:gasjm/app/data/models/vehiculo_model.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:gasjm/app/data/repository/vehiculo_repository.dart';
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
  final repartidorTextoController = TextEditingController();

  final observacionTextoController = TextEditingController();

  //varialbe para el modo editable;
  bool vehiculoEditable = false;

  //Variable para visualizar el estado de carga de datos
  final cargandoVehiculo = false.obs;

  //Existe algun error si o no
  final errorParaDatosVehiculo = Rx<String?>(null);

  //Lista de repartidores
  List<PersonaModel> _listaRepartidores = <PersonaModel>[];
  List<PersonaModel> get listaRepartidores => _listaRepartidores;

  //Valor inicial de la lista de repartidores
  RxString indiceRepartidor = 'Sin repartidor'.obs;

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
    //Obtener lista de repartidores
    _cargarListaDeRepartidores();
    //
    Future.wait([_cargarDatosDelFormVehiculo()]);

    //
    /*   var aux = listaRepartidores
        .where((element) => element.uidPersona == vehiculo.idRepartidor)
        .first;

    print(aux.uidPersona);*/
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    //
    placaTextoController.dispose();
    marcaTextoController.dispose();
    modeloTextoController.dispose();
    anioTextoController.dispose();
    repartidorTextoController.dispose();
    observacionTextoController.dispose();
  }
  /* METODOS PARA VEHICULO */

  Future<void> _cargarDatosDelFormVehiculo() async {
    try {
      // obtner nombres de los repartidor
      /*   var aux = listaRepartidores
          .where((element) => element.uidPersona == vehiculo.idRepartidor)
          .first;
*/
      //
      indiceRepartidor.value = vehiculo.idRepartidor;
      //
      if (vehiculo.fotoVehiculo != null) {
        existeImagenPerfil.value = true;
      }

      //
      placaTextoController.text = vehiculo.placaVehiculo;
      marcaTextoController.text = vehiculo.marcaVehiculo;
      modeloTextoController.text = vehiculo.modeloVehiculo;
      anioTextoController.text = '${vehiculo.anioVehiculo}';
      /*   repartidorTextoController.text =
          '${aux.nombrePersona} ${aux.apellidoPersona}';*/
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
  }

  //Obtener lista de repartisores activos
  void _cargarListaDeRepartidores() async {
    try {
      final lista = (await _personaRepository.getNombresPorField(
          field: 'idPerfil', dato: 'repartidor'));
      final admin = (await _personaRepository.getNombresPorField(
          field: 'idPerfil', dato: 'administrador'));
      //
      lista.addAll(admin);
      //
      for (var i = 0; i < lista.length; i++) {
        //
        lista[i].nombreUsuario =
            '${lista[i].nombrePersona} ${lista[i].apellidoPersona}';
        //
        if (lista[i].uidPersona == vehiculo.idRepartidor) {
          repartidorTextoController.text = lista[i].nombreUsuario!;
        }
      }
      _listaRepartidores = lista;

      //
    } catch (e) {
      //
      Exception('Error al cargar repartidores.');
    }
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
  actualizarVehiculo(BuildContext context) async {
    //Obtener datos
    String idRepartidor = indiceRepartidor.value;
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

      Vehiculo vehiculoParaActualizar = Vehiculo(
          idVehiculo: vehiculo.idVehiculo,
          idRepartidor: idRepartidor,
          placaVehiculo: placaVehiculo,
          marcaVehiculo: marcaVehiculo,
          modeloVehiculo: modeloVehiculo,
          anioVehiculo: anioVehiculo,
          fotoVehiculo: vehiculo.fotoVehiculo,
          observacionVehiculo: observacionVehiculo);

      //En firebase
      _vehiculoRepository.updateVehiculo(
          vehiculo: vehiculoParaActualizar, imagen: pickedImage.value);

      //Mensaje de ingreso
      Mensajes.showGetSnackbar(
          titulo: 'Mensaje',
          mensaje: 'Vehículo actualizado con éxito.',
          icono: const Icon(
            Icons.save_outlined,
            color: Colors.white,
          ));

      //Testear
      await Future.delayed(const Duration(seconds: 1));
      //
     Navigator.pop(context);
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

  //Metodo para seleccionar repartidor
  seleccionarOpcionRepartidor(String? valor) {
    indiceRepartidor.value = valor!;

    var aux = listaRepartidores
        .where((element) => element.uidPersona == valor)
        .toList();
    repartidorTextoController.text = aux[0].nombreUsuario!;
  }
}
