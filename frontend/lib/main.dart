import 'package:employee_managment/common/theme.dart';
import 'package:employee_managment/config.dart';
import 'package:employee_managment/controllers/auth/auth_provider.dart';
import 'package:employee_managment/controllers/main/user_provider.dart';
import 'package:employee_managment/controllers/widget/menu_controller.dart';
import 'package:employee_managment/router/routes_name.dart';
import 'package:employee_managment/router/router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Flurorouter.setupRouter();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
          ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
          ChangeNotifierProvider<MenuControllerAdmin>(
              create: (_) => MenuControllerAdmin()),
          ChangeNotifierProvider<MenuControllerUser>(
              create: (_) => MenuControllerUser()),
        ],
        builder: (context, builder) {
          return MaterialApp(
            title: Config.appName,
            theme: ThemeData(
                primaryColor: kPrimaryLightColor,
                scaffoldBackgroundColor: kbgColor,
                textTheme: const TextTheme(
                    titleMedium: TextStyle(color: kPrimaryBlackColor))),
            debugShowCheckedModeBanner: false,
            initialRoute: RoutesName.otp,
            onGenerateRoute: Flurorouter.router.generator,
          );
        });
  }
}
