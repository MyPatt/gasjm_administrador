import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gasjm/app/data/models/vehiculo_model.dart'; 
import 'package:path/path.dart' as path;

class VehiculoProvider {
  //Instancia de firestore
  final _firestoreInstance = FirebaseFirestore.instance;
  //Instancia de storage
  FirebaseStorage get _storageInstance => FirebaseStorage.instance;

  //REGISTRAR nuevo vehiculo
  Future<void> insertVehiculo(
      {required Vehiculo vehiculo, File? imagen}) async {
      final resultado =
        await _firestoreInstance.collection('vehiculo').add(vehiculo.toMap());

    await _firestoreInstance
        .collection("vehiculo")
        .doc(resultado.id)
        .update({"idVehiculo": resultado.id});

    //Insertar la imagen del vehiculo
    if (imagen != null) {
     
      final imagePath =
          'vehiculo/${resultado.id}/fotovehiculo${path.extension(imagen.path)}';

      final storageRef = _storageInstance.ref(imagePath);
      await storageRef.putFile(imagen);
      final url = await storageRef.getDownloadURL();
      _firestoreInstance
          .collection("vehiculo")
          .doc(resultado.id)
          .update({"fotoVehiculo": url});
    }
  }


   //Obtener lista de vehiculas 

     Future<List<Vehiculo>> getVehiculos() async {
    final snapshot = await _firestoreInstance.collection('vehiculo').get();

    return (snapshot.docs)
        .map((item) => Vehiculo.fromMap(item.data()))
        .toList();
  }

  //Eliminar un vehiculo
  Future<void> deleteVehiculo({required String uid}) async {
    await _firestoreInstance.collection('vehiculo').doc(uid).delete();
  }
  
  //Actualizar
  Future<void> updateVehiculo(
      {required Vehiculo vehiculo, File? imagen}) async {
    await _firestoreInstance
        .collection('vehiculo')
        .doc(vehiculo.idVehiculo)
        .update(vehiculo.toMap());
    if (imagen != null) {

      final imagePath =
          'vehiculo/${vehiculo.idVehiculo}/fotovehiculo${path.extension(imagen.path)}';
 
      final storageRef = _storageInstance.ref(imagePath);
      await storageRef.putFile(imagen);
      final url = await storageRef.getDownloadURL();
      _firestoreInstance
          .collection("vehiculo")
          .doc(vehiculo.idVehiculo)
          .update({"fotoVehiculo": url}); 
    } 
  }
}
