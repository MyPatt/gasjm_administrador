import 'dart:io';

import 'package:gasjm/app/data/models/vehiculo_model.dart';

abstract class VehiculoRepository {
  Future<void> insertVehiculo({required Vehiculo vehiculo, File? imagen});
  Future<List<Vehiculo>> getVehiculos();
  Future<void> deleteVehiculo({required String uid});
  Future<void> updateVehiculo({required Vehiculo vehiculo, File? imagen});
}
