import 'package:employee_managment/common/theme.dart';
import 'package:employee_managment/common/user_type_enum.dart';
import 'package:employee_managment/controllers/auth/local/local_persist_data.dart';
import 'package:employee_managment/router/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 3000), () async {
      var userType = await LocalData.retrieveUserType();
      var adminToken = await LocalData.retrieveAdminToken();
      var userToken = await LocalData.retrieveUserToken();

      print('ttty: ${userType}, ${adminToken}, {userToken}');

      if (userType == UserType.admin.name) {
        if (adminToken != null) {
          if (!mounted) return;
          Navigator.pushNamed(context, RoutesName.dashboardadmin);
        } else {
          if (!mounted) return;
          Navigator.pushNamed(context, RoutesName.login);
        }
      } else if (userType == UserType.user.name) {
        if (userToken != null) {
          if (!mounted) return;
          Navigator.pushNamed(context, RoutesName.dashboarduser);
        } else {
          if (!mounted) return;
          Navigator.pushNamed(context, RoutesName.login);
        }
      } else {
        if (!mounted) return;
        Navigator.pushNamed(context, RoutesName.login);
      }
    });
    return const Scaffold(
        body: SpinKitDoubleBounce(
      color: kSecondaryColor,
      size: 70.0,
    ));
  }
}
