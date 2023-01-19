import 'package:gasjm/app/data/models/gasjm_model.dart';
import 'package:gasjm/app/data/models/horario_model.dart';
import 'package:gasjm/app/data/models/producto_model.dart';

abstract class GasJMRepository {
  Future<GasJm> getInformacionDistribuidora();
  Future<ProductoModel> getProducto();
  Future<HorarioModel> getHorarioPorIdDia({required int idDiaHorario});
  Future<List<HorarioModel>> getListaHorarios();
  Future<void> updateHorario(
      {required String uidHorario,
      required String horaApertura,
      required String horaCierre});
  Future<void> updateDatosDistribuidora({required String field, required dato});
  Future<void> updateDatosProducto({required String field, required dato});
}
