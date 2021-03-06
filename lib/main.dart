import 'package:firestoreCRUDapp/providers/product_provider.dart';
import 'package:firestoreCRUDapp/screens/product_screen.dart';
import 'package:firestoreCRUDapp/services/firestore_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestoreCRUDapp/utils/PushNotificationManager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initial firebase
  await Firebase.initializeApp();
  // initial firebaseMessenger
  PushNotificationManager().initFirebaseMessaging();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fireStoreService = FirestoreService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        StreamProvider(create: (context) => fireStoreService.getProducts()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Firestore CRUD',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: ProductScreen(),
      ),
    );
  }
}
