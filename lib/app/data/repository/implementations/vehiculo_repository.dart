import 'dart:io';

import 'package:gasjm/app/data/models/vehiculo_model.dart';
import 'package:gasjm/app/data/providers/vehiculo_provider.dart';
import 'package:gasjm/app/data/repository/vehiculo_repository.dart';
import 'package:get/get.dart';

class VehiculoRepositoryImpl extends VehiculoRepository {
  final _provider = Get.find<VehiculoProvider>();
  @override
  Future<void> insertVehiculo({required Vehiculo vehiculo, File? imagen}) =>
      _provider.insertVehiculo(vehiculo: vehiculo, imagen: imagen);

  @override
  Future<List<Vehiculo>> getVehiculos() => _provider.getVehiculos();

  @override
  Future<void> deleteVehiculo({required String uid}) =>
      _provider.deleteVehiculo(uid: uid);

  @override
  Future<void> updateVehiculo({required Vehiculo vehiculo, File? imagen}) =>
      _provider.updateVehiculo(vehiculo: vehiculo);
}
