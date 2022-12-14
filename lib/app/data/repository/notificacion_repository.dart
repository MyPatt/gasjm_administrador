 
import 'package:gasjm/app/data/models/notificacion_model.dart'; 

abstract class NotificacionRepository {
  Future<void> insertNotificacion({required Notificacion notificacionModel});
  Future<List<Notificacion>?> getNotificaciones();
}
