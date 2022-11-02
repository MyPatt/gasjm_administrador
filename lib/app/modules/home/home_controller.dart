import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/data/models/category_model.dart';
import 'package:gasjm/app/data/models/puntos_model.dart';
import 'package:gasjm/app/data/repository/pedido_repository.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt isSelectedIndex = 0.obs;
  RxInt indiceDeFechaSeleccionada = 0.obs;

  //
  Rx<DateTime> fechaInicial = DateTime.now().obs;
  RxString get selectedDate => (fechaInicial.value.day.toString() +
          '/' +
          fechaInicial.value.month.toString() +
          '/' +
          fechaInicial.value.year.toString())
      .obs;
//
  final _personaRepository = Get.find<PersonaRepository>();
  RxString imagenUsuario = ''.obs;

  //Variables para el chart de Pedidos
  final RxList<PedidoPuntos> _pedidoPuntos = <PedidoPuntos>[].obs;
  RxList<PedidoPuntos> get pedidoPuntos => _pedidoPuntos;
  //   final List<PricePoint> points;
  final _pedidoRepository = Get.find<PedidoRepository>();
//
  final RxList<int> _listaCantidadesModulos = <int>[0, 0, 0, 0].obs;
  // final RxList<int> _listaCantidadesModulos = <int>[].obs;

  RxList<int> get listaCantidadesModulos => _listaCantidadesModulos;
  /* METODOS PROPIOS */
  @override
  Future<void> onInit() async {
    super.onInit();
    Future.wait([
      _cargarFotoPerfil(),
      _getCantidadesPorHorasDelDia(DateTime.now()),
      _obtenerCantidadTotalXCategoria()
    ]);
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  /* METODOS  */
  Future<void> _cargarFotoPerfil() async {
    imagenUsuario.value =
        await _personaRepository.getImagenUsuarioActual() ?? '';
  }

//Metodo para actualizar el indice de la categoria del dashboard [pedido,cliente,repartidor,vehiculo]

  seleccionarIndiceDeCategoria(int index) {
    isSelectedIndex.value = index;
  }

//Metodo para actualizar el indice de la fecha seleccionada para mostrar el grafico estadistico [dia,semana,mes,calendario]
  seleccionarIndiceDeFecha(int index) {
    indiceDeFechaSeleccionada.value = index;

    switch (indiceDeFechaSeleccionada.value) {
      case 0:
        _getCantidadesPorHorasDelDia(DateTime.now());
        //
        break;
      case 1:
        _getCantidadesPorDiasDeLaSemana();
        //
        break;
      case 2:
        _getCantidadesPorDiasDelMes();
        break;
      case 3:
        _getCantidadesPorHorasDelDia(fechaInicial.value);
        break;
      default:
    }
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? d = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      helpText: "Seleccione una fecha".toUpperCase(),
      cancelText: "Cancelar",
      confirmText: "Aceptar",
      initialDate: fechaInicial.value,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime.now(),
    );

    if (d != null) {
      fechaInicial.value = d;
    }
  }

  void navegarDashboard() {
    switch (isSelectedIndex.value) {
      case 0:
        Get.toNamed(AppRoutes.detail,
            arguments: categoriasModulos[isSelectedIndex.value]);
        break;
      case 1:
        Get.toNamed(AppRoutes.cliente,
            arguments: categoriasModulos[isSelectedIndex.value]);
        break;
      case 2:
        Get.toNamed(AppRoutes.repartidor,
            arguments: categoriasModulos[isSelectedIndex.value]);
        break;
      case 3:
        Get.toNamed(AppRoutes.vehiculo,
            arguments: categoriasModulos[isSelectedIndex.value]);
        break;
      default:
    }
  }

/* OBTENER DATOS PARA MODULOS*/

//Obtener el total de c/u modulo
  Future<void> _obtenerCantidadTotalXCategoria() async {
    int total = 0;
    //
    total = await _pedidoRepository.getCantidadPedidosPorfield(
        field: "idEstadoPedido", dato: "estado3");
    _listaCantidadesModulos[0] = total;
    //_listaCantidadesModulos.add(total);
    //

    total = await _personaRepository.getCantidadClientesPorfield(
        field: "idPerfil", dato: "cliente");
   // _listaCantidadesModulos.add(total);
    _listaCantidadesModulos[1] = total;

    //
    total = await _personaRepository.getCantidadClientesPorfield(
        field: "idPerfil", dato: "repartidor");
    //_listaCantidadesModulos.add(total);
    _listaCantidadesModulos[2] = total;

    //TODO: IMPLEMNTAR VEHICULOS MODULO
    //_listaCantidadesModulos.add(1);
    _listaCantidadesModulos[3] = 1;

    print("0000000000000000000000000");
    print(_listaCantidadesModulos.value);
  }
/* CHART DE PEDIDOS */

//Obtener cantidad de pedidos por horas del dia actual
  Future<void> _getCantidadesPorHorasDelDia(DateTime fecha) async {
    //Obtener el numero de la hora actual
    final numeroHoraActual = fecha.hour;
//
    _pedidoPuntos.clear();
    //(Horario de atenciom de 6 am a 20 pm)
    //Si la hora actual es menor 6  mostrar la primera hora en 0
    if (numeroHoraActual < 6) {
      //  for (var i = 0; i < 2; i++) {
      for (var i = 0; i < 15; i++) {
        _pedidoPuntos.add(PedidoPuntos(x: i, y: 0));
      }
    } else if (numeroHoraActual > 20) {
      //Si la hora actual es mayor a 20 mostrar los pedidos de 6 a 20 horas
      //<15(20-6=14) horas del dia de atencion, por cada hora consultar en firebase la cantidad de pedidos
      for (var i = 0; i < 15; i++) {
        var hora = Timestamp.fromDate(DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day, (6 + i)));
        var cantidadXHora =
            await _pedidoRepository.getCantidadPedidosPorHora(fechaHora: hora);
        _pedidoPuntos.add(PedidoPuntos(x: i, y: cantidadXHora));
      }
    } else {
      //Si la hora esta entre 6 y 20 horas mostrar los datos hasta la hora actual
      int p = numeroHoraActual - 5;

      // for (var i = 0; i < p; i++) {
      for (var i = 0; i < 15; i++) {
        if (i >= p) {
          _pedidoPuntos.add(PedidoPuntos(x: i, y: 0));
        } else {
          var hora = Timestamp.fromDate(DateTime(DateTime.now().year,
              DateTime.now().month, DateTime.now().day, (6 + i)));
          var cantidadXHora = await _pedidoRepository.getCantidadPedidosPorHora(
              fechaHora: hora);
          _pedidoPuntos.add(PedidoPuntos(x: i, y: cantidadXHora));
        }
      }
    }
  }

//Metodo de obtener pedidos por cada dia del mes
  Future<void> _getCantidadesPorDiasDelMes() async {
    DateTime fechaActual = DateTime.now();
    //numerod del dia del mes
    final diaMes = fechaActual.day;

    //Obtener el total de dias del mes actual
    var cantidadDias = DateTime(fechaActual.year, fechaActual.month + 1, 0).day;
//
    _pedidoPuntos.clear();

    //Obtener pedidos de todos los dias del mes desde firestore
    for (var i = 0; i < cantidadDias; i++) {
      var cantidadXDia = 0;
      //caso de superar la fecha actual el pedido es0
      if (i >= diaMes) {
        //consulta
        cantidadXDia = 0;
      } else {
        //ir sumando los dias
        var fecha = Timestamp.fromDate(
            DateTime(fechaActual.year, fechaActual.month, (i + 1)));
        //consulta desde firestore
        cantidadXDia = await _pedidoRepository.getCantidadPedidosPorPorDias(
            fechaDia: fecha);
      }

      //agregar a la lista
      _pedidoPuntos.add(PedidoPuntos(x: i, y: cantidadXDia));
    }
  }

/////////////////////////
  Future<void> _getCantidadesPorDiasDeLaSemana() async {
    DateTime fechaActual = DateTime.now();
    //numerod del dia de la semana
    final diaSemana = fechaActual.weekday;

    //Obtener la fecha del dia lunes de la semana actual
    var dia = (DateTime.now().day - diaSemana + 1);
//
    _pedidoPuntos.clear();
    //Obtener caantidad de toda la semana(7dias) desde firestore
    for (var i = 0; i < 7; i++) {
      //ir sumando los dias
      var fecha = Timestamp.fromDate(
          DateTime(fechaActual.year, fechaActual.month, (dia + i)));
      var cantidadXDia = 0;
      if (i <= diaSemana) {
        //consulta
        cantidadXDia = await _pedidoRepository.getCantidadPedidosPorPorDias(
            fechaDia: fecha);
      }

      //agregar a la lista
      _pedidoPuntos.add(PedidoPuntos(x: i, y: cantidadXDia));
    }
  }

  /*METODO PARA  MANEJO DE PANTALLA POR NAVEGACION BOTTOM*/

  pantallaSeleccionadaOnTap(int index) {
    if (index == 0) {
      return;
    }
    if (index == 1) {
      _cargarIrPage();
      return;
    }
    if (index == 2) {
      _cargarPedidosPage();
      return;
    }
  }

  _cargarIrPage() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      Get.offNamed(AppRoutes.ir);
    } catch (e) {
      throw Exception(
          "Ha ocurrido un error, por favor inténtelo de nuevo más tarde.");
    }
  }

  _cargarPedidosPage() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      Get.offNamed(AppRoutes.pedidos);
      throw Exception(
          "Ha ocurrido un error, por favor inténtelo de nuevo más tarde.");
    } catch (e) {}
  }
}
