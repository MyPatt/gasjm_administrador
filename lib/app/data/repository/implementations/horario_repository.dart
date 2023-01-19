import 'package:gasjm/app/data/models/gasjm_model.dart';
import 'package:gasjm/app/data/models/horario_model.dart';
import 'package:gasjm/app/data/models/producto_model.dart';
import 'package:gasjm/app/data/providers/horario_provider.dart';
import 'package:gasjm/app/data/repository/horario_repository.dart';
import 'package:get/get.dart'; 

class GasJMRepositoryImpl extends GasJMRepository {
  final _provider = Get.find<GasJMProvider>();
  @override
  Future<GasJm> getInformacionDistribuidora() =>
      _provider.getInformacionDistribuidora();
  @override
  Future<ProductoModel> getProducto() => _provider.getProducto();
  @override
  Future<HorarioModel> getHorarioPorIdDia({required int idDiaHorario}) =>
      _provider.getHorarioPorIdDia(idDiaHorario: idDiaHorario);

  @override
  Future<List<HorarioModel>> getListaHorarios() => _provider.getListaHorarios();

  @override
  Future<void> updateHorario(
          {required String uidHorario,
          required String horaApertura,
          required String horaCierre}) =>
      _provider.updateHorario(
          uidHorario: uidHorario,
          horaApertura: horaApertura,
          horaCierre: horaCierre);
  @override
  Future<void> updateDatosDistribuidora(
          {required String field, required dato}) =>
      _provider.updateDatosDistribuidora(field: field, dato: dato);
  @override
  Future<void> updateDatosProducto({required String field, required dato}) =>
      _provider.updateDatosProducto(field: field, dato: dato);
}
