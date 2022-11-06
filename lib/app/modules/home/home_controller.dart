import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/data/models/categoria_model.dart';
import 'package:gasjm/app/data/models/puntos_model.dart';
import 'package:gasjm/app/data/repository/pedido_repository.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:gasjm/app/modules/home/widgets/modal_operaciones.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt indiceModuloSeleccionado = 0.obs;
  RxInt indiceDeFechaSeleccionada = 0.obs;
//
  RxString mensaje = "".obs;
  //
  DateTime fechaInicio =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  Rx<DateTime> fechaInicialCalendario =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .obs;
  RxString get fechaSeleccionadaString =>
      (fechaInicialCalendario.value.day.toString() +
              '/' +
              fechaInicialCalendario.value.month.toString() +
              '/' +
              fechaInicialCalendario.value.year.toString())
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
  //Estado de carga de dia
  final cargandoParaDia = RxBool(false);
  //Verficar si la lista no tien datos
  final totalCantidad = RxInt(0);
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
    indiceModuloSeleccionado.value = index;
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

      default:
    }
  }

  Future<void> seleccionarFechaDelCalendario(BuildContext context) async {
    DateTime? d = await showDatePicker(
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
                primary: Color.fromRGBO(33, 116, 212, 1),
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
      cancelText: "Cancelar",
      confirmText: "Aceptar",
      initialDate: fechaInicialCalendario.value,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime.now(),
    );

    if (d == null && fechaInicialCalendario.value == fechaInicio) {
      _getCantidadesPorHorasDelDia(fechaInicio);
      return;
    }
    if (d == null && fechaInicialCalendario.value != fechaInicio) {
      _getCantidadesPorDia(fechaInicialCalendario.value);
      return;
    }
    if (d != null) {
      fechaInicialCalendario.value = d;

      _getCantidadesPorDia(fechaInicialCalendario.value);
    }
  }

  void navegarDashboard() {
    switch (indiceModuloSeleccionado.value) {
      case 0:
        Get.toNamed(AppRoutes.operacionPedido,
            arguments: categoriasModulos[indiceModuloSeleccionado.value]);
        break;
      case 1:
        Get.toNamed(AppRoutes.cliente,
            arguments: categoriasModulos[indiceModuloSeleccionado.value]);
        break;
      case 2:
        Get.toNamed(AppRoutes.repartidor,
            arguments: categoriasModulos[indiceModuloSeleccionado.value]);
        break;
      case 3:
        Get.toNamed(AppRoutes.vehiculo,
            arguments: categoriasModulos[indiceModuloSeleccionado.value]);
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
  }

/* CHART DE PEDIDOS */
  Future<void> _getCantidadesPorDia(DateTime fecha) async {
    try {
      cargandoParaDia.value = true;
//Limpiar los puntos
      _pedidoPuntos.clear();
      totalCantidad.value = 0;
//Verificar si la fecha es disitina a la actual
      if (fecha != DateTime.now()) {
        for (var i = 0; i < 15; i++) {
          var hora = Timestamp.fromDate(
              DateTime(fecha.year, fecha.month, fecha.day, (6 + i)));

          var cantidadXHora = await _pedidoRepository.getCantidadPedidosPorHora(
              fechaHora: hora);
          _pedidoPuntos.add(PedidoPuntos(x: i, y: cantidadXHora));
          //Sumar la cantidad de Pedidos
          totalCantidad.value = (totalCantidad.value + cantidadXHora);
        }
      }
    } catch (e) {
      throw Exception(
          "Ha ocurrido un error, por favor inténtelo de nuevo más tarde.");
    }
    cargandoParaDia.value = false;
  }

//Obtener cantidad de pedidos por horas del dia actual
  Future<void> _getCantidadesPorHorasDelDia(DateTime fecha) async {
    //Obtener el numero de la hora actual
    final numeroHoraActual = fecha.hour;
    //
    try {
      cargandoParaDia.value = true;
      //Limpiar los puntos
      _pedidoPuntos.clear();
      totalCantidad.value = 0;
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
          var cantidadXHora = await _pedidoRepository.getCantidadPedidosPorHora(
              fechaHora: hora);
          _pedidoPuntos.add(PedidoPuntos(x: i, y: cantidadXHora));
          //
          totalCantidad.value = (totalCantidad.value + cantidadXHora);
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
            var cantidadXHora = await _pedidoRepository
                .getCantidadPedidosPorHora(fechaHora: hora);
            _pedidoPuntos.add(PedidoPuntos(x: i, y: cantidadXHora));
            //
            totalCantidad.value = (totalCantidad.value + cantidadXHora);
          }
        }
      }
    } catch (e) {
      throw Exception(
          "Ha ocurrido un error, por favor inténtelo de nuevo más tarde.");
    }
    cargandoParaDia.value = false;
    //
  }

//Metodo de obtener pedidos por cada dia del mes
  Future<void> _getCantidadesPorDiasDelMes() async {
    DateTime fechaActual = DateTime.now();
    //numerod del dia del mes
    final diaMes = fechaActual.day;

    //Obtener el total de dias del mes actual
    var cantidadDias = DateTime(fechaActual.year, fechaActual.month + 1, 0).day;
//
    try {
      cargandoParaDia.value = true;
      _pedidoPuntos.clear();
      totalCantidad.value = 0;
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
          //
          totalCantidad.value = (totalCantidad.value + cantidadXDia);
        }

        //agregar a la lista
        _pedidoPuntos.add(PedidoPuntos(x: i, y: cantidadXDia));
      }
    } catch (e) {
      throw Exception(
          "Ha ocurrido un error, por favor inténtelo de nuevo más tarde.");
    }
    cargandoParaDia.value = false;
  }

/////////////////////////
  Future<void> _getCantidadesPorDiasDeLaSemana() async {
    DateTime fechaActual = DateTime.now();
    //numerod del dia de la semana
    final diaSemana = fechaActual.weekday;

    //Obtener la fecha del dia lunes de la semana actual
    var dia = (DateTime.now().day - diaSemana + 1);
//
    try {
      cargandoParaDia.value = true;
      _pedidoPuntos.clear();
      totalCantidad.value = 0;
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
          //
          totalCantidad.value = (totalCantidad.value + cantidadXDia);
        }

        //agregar a la lista
        _pedidoPuntos.add(PedidoPuntos(x: i, y: cantidadXDia));
      }
    } catch (e) {
      throw Exception(
          "Ha ocurrido un error, por favor inténtelo de nuevo más tarde.");
    }
    cargandoParaDia.value = false;
  }

  /*METODO PARA  MANEJO DE PANTALLA POR NAVEGACION BOTTOM*/

  pantallaSeleccionadaOnTap(int index, BuildContext context) {
    if (index == 0) {
      _cargarPagina(Get.offNamed(AppRoutes.inicio));
      return;
    }
    if (index == 1) {
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            return const ModalOperaciones();
          });
      return;
    }
  }
  //Metodo para ir a una ruta

  _cargarPagina(Future? funcionRuta) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      funcionRuta;
    } catch (e) {
      throw Exception(
          "Ha ocurrido un error, por favor inténtelo de nuevo más tarde.");
    }
  }

//Metodo para cargar una pantalla a una ruta de  crud
  void seleccionarCategoriaParaOperacion(int index) {
    switch (index) {
      case 0:
        _cargarPagina(Get.offNamed(AppRoutes.operacionPedido));
        break;
      default:
    }
  }
}
