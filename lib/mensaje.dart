
/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _lastMessage = "";

  _MyHomePageState() {
    // subscribe to the message stream fed by foreground message handler
    _messageStreamController.listen((message) {
      setState(() {
        if (message.notification != null) {
          _lastMessage = 'Received a notification message:'
              '\n\nTitle=${message.notification?.title},'
              '\n\nBody=${message.notification?.body},'
              '\n\nData=${message.data}';
        } else {
          _lastMessage = 'Received a data message: ${message.data}';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Last message from Firebase Messaging:',
                style: Theme.of(context).textTheme.titleLarge),
            Text(_lastMessage, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
*/
/*import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app.dart';
import 'package:gasjm/app/core/utils/dependency_injection.dart';
import 'package:gasjm/app/data/repository/authenticacion_repository.dart';
import 'package:gasjm/app/data/repository/implementations/authenticacion_repository.dart';

import 'package:gasjm/app/modules/ubicacion/blocs/gps/gps_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

// TODO: Add stream controller
import 'package:rxdart/rxdart.dart';

// used to pass messages from event handler to the UI
final _messageStreamController = BehaviorSubject<RemoteMessage>();
// TODO: Define the background message handler
//mientras la aplicación está en segundo plano
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.title}');
    print('Message notification: ${message.notification?.body}');
  }
}

Future<void> main() async {
  //Inicializar Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //Inyectando implentacion del repositorio de autenticacion
  Get.put<AutenticacionRepository>(AutenticacionRepositoryImpl());

//Agregar Providers y Repositories
  DependencyInjection.load();
///////////////////
  // TODO: Request permission
  //settings   indica si el usuario ha concedido permiso
  final messaging = FirebaseMessaging.instance;

  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (kDebugMode) {
    print('Permission granted: ${settings.authorizationStatus}');
  }
  // TODO: Register with FCM
  //getToken devuelve un token de registro que puede ser utilizado por el servidor de aplicaciones o el entorno del servidor
  //cOftmMesSHK-Tj_1kCkOs-:APA91bGmKjMQjXtDFEwtzVxZF8jjrGa4F0mjkUylQr9DuFWhYDEEsO4aCG39icSDgTENEYijJ0_c1181LOMX_QQsoHnLPEr9ghY_dcOAr8nQJET_2UgbtPVpzRLkIH0NEKt_67y3wmy2
  String? token = await messaging.getToken();

  if (kDebugMode) {
    print('Registration Token=$token');
  }
  // TODO: Set up foreground message handler
  //Escuchar los mensajes en primer plano
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) {
      print('Handling a foreground message: ${message.messageId}');
      print('Message data: ${message.data}');
      print('Message notification: ${message.notification?.title}');
      print('Message notification: ${message.notification?.body}');
    }

    _messageStreamController.sink.add(message);
  });
  // TODO: Set up background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

///////////////////

  //Para obtener estado del GPS
  runApp( MyHomePage(title: "title"));
  /*MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => GpsBloc(),
      ),
    ],
   child: MyApp(),

  ));*/
}

////
///

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _lastMessage = "";

  _MyHomePageState() {
    // subscribe to the message stream fed by foreground message handler
    _messageStreamController.listen((message) {
      setState(() {
        if (message.notification != null) {
          _lastMessage = 'Received a notification message:'
              '\n\nTitle=${message.notification?.title},'
              '\n\nBody=${message.notification?.body},'
              '\n\nData=${message.data}';
        } else {
          _lastMessage = 'Received a data message: ${message.data}';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SizedBox(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Last message from Firebase Messaging:',
                  style: Theme.of(context).textTheme.titleLarge),
              Text(_lastMessage, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ),
    );
  }
}
*/