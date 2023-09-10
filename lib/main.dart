import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:spot_holder/presentation/seller/add_new_parking.dart';
import 'package:spot_holder/presentation/seller/seller_homepage.dart';
import 'package:spot_holder/presentation/seller/seller_login.dart';
import 'package:spot_holder/presentation/seller/seller_navigation.dart';
import 'package:spot_holder/presentation/seller/seller_sign.dart';
import 'package:spot_holder/presentation/user/booking.dart';
import 'package:spot_holder/presentation/user/parking_spots_onMap.dart';
import 'package:spot_holder/presentation/user/user_homepage.dart';
import 'package:spot_holder/presentation/user/user_login.dart';
import 'package:spot_holder/presentation/user/user_navigation.dart';
import 'package:spot_holder/presentation/user/user_signup.dart';
import 'package:spot_holder/presentation/user/user_wallet.dart';
import 'package:spot_holder/provider/parking_list_provider.dart';
import 'package:spot_holder/provider/user_provider.dart';
import 'package:spot_holder/utils/routes/routes.dart';
import 'package:spot_holder/utils/utils.dart';

// GetIt getIt = GetIt.instance;
late Size mq;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // print(message.notification!.title);
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // getIt.registerLazySingleton<UsersRepository>(() => FirebaseUserRepository());
  runApp(
      // // MultiProvider(
      // //   providers: [
      // //     ChangeNotifierProvider(
      // //       create: (_) =>
      // //           UserProvider(usersRepository: getIt())..getUser(),
      // //     ),
      // //   ],
      //   child: const MyApp(),
      // ),
      const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => UserProvider()),
            
            ChangeNotifierProvider(create: (_) => ParkingListProvider()),
            // ChangeNotifierProvider(create: (_) => SellerProvider()),
            // ChangeNotifierProvider(create: (_) => AllSellerDataProvider()),
          ],
          child: MaterialApp(
            title: 'E-Mech',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            // home:utils.currentUserUid==null?SellerLogin():SellerNavigation(),
            // home:utils.currentUserUid==null?UserLogin():UserNavigation(),
            home: SellerLogin(),
            onGenerateRoute: Routes.onGenerateRoute,
          ),
        );
      },
      // child:
    );
  }
}
