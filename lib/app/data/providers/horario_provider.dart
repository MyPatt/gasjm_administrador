import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gasjm/app/data/models/gasjm_model.dart';
import 'package:gasjm/app/data/models/horario_model.dart';
import 'package:gasjm/app/data/models/producto_model.dart';

class GasJMProvider {
  //Instancia de firestore
  final _firestoreInstance = FirebaseFirestore.instance;
  /*INFORMACION */

  //Retorna info de la distribuidora
  Future<GasJm> getInformacionDistribuidora() async {
    final snapshot = await _firestoreInstance.collection("distribuidora").get();

    return GasJm.fromMap(snapshot.docs.first.data());
  }
  //Retorna info del producto

  Future<ProductoModel> getProducto() async {
    final snapshot = await _firestoreInstance.collection('producto').get();

    return ProductoModel.fromMap(snapshot.docs.first.data());
  }

  /*HORARIOS */
  //Obtener lista de los horarios de todos los dias
  Future<List<HorarioModel>> getListaHorarios() async {
    final resultado = await _firestoreInstance.collection('horario').get();

    return (resultado.docs)
        .map((item) => HorarioModel.fromJson(item.data()))
        .toList();
  }

  //Retorna los datos del horario de atencion por id eje:1 =lunes
  Future<HorarioModel> getHorarioPorIdDia({required int idDiaHorario}) async {
    final snapshot = await _firestoreInstance
        .collection("horario")
        .where("idDiaHorario", isEqualTo: idDiaHorario)
        .get();

    return HorarioModel.fromJson(snapshot.docs.first.data());
  }
  //Actualizar el horario

  Future<void> updateHorario(
      {required String uidHorario,
      required String horaApertura,
      required String horaCierre}) async {
    await _firestoreInstance
        .collection('horario')
        .doc(uidHorario)
        .update({"aperturaHorario": horaApertura, "cierreHorario": horaCierre});
  }
}
