import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_managment/controllers/auth/auth_provider.dart';
import 'package:employee_managment/controllers/auth/local/local_persist_data.dart';
import 'package:employee_managment/controllers/utils.dart';
import 'package:flutter/material.dart';
import 'package:employee_managment/common/theme.dart';
import 'package:employee_managment/views/auth/login.dart';
import 'package:provider/provider.dart';

class SideMenuUser extends StatefulWidget {
  final TabController? tabController;

  const SideMenuUser({
    Key? key,
    this.tabController,
  }) : super(key: key);

  @override
  State<SideMenuUser> createState() => _SideMenuUserState();
}

class _SideMenuUserState extends State<SideMenuUser> {
  @override
  Widget build(BuildContext context) {
    // var authProvider = Provider.of<AuthProvider>(context, listen: false);
    // String email = authProvider.loginResponse!.users[0].email;
    // String fullName = MainUtils.convertToTitleCase(
    //     authProvider.loginResponse!.users[0].fullName);
    return Drawer(
      elevation: 40,
      backgroundColor: kPrimaryLightColor,
      child: ListView(shrinkWrap: true, children: <Widget>[
        DrawerHeader(
          child: Column(
            children: [
              CircleAvatar(
                  radius: 40,
                  backgroundColor: kSecondaryColor,
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: ClipOval(
                        child: CachedNetworkImage(
                      imageUrl:
                          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg",
                      imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                              ),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ))),
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )),
                  )),
              const SizedBox(height: 10),
              const Text("Brook Yonas",
                  style: TextStyle(
                    fontSize: 14,
                    color: kPrimaryBlackColor,
                    fontFamily: 'Poppins',
                  )),
              const Text(
                "brookyonas@gmail.com",
                style: TextStyle(
                    fontSize: 12,
                    color: kSubBlackColor,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        DrawerListTile(
            icon: Icons.home_filled,
            title: "Home",
            onPressed: () {
              widget.tabController!.animateTo(0);
            },
            tabController: widget.tabController!,
            index: 0),
        DrawerListTile(
            icon: Icons.exit_to_app,
            title: "Logout",
            onPressed: () async {
              logOutPopUp(context);
            },
            tabController: widget.tabController!,
            index: 1),
      ]),
    );
  }
}

void logOutPopUp(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: const Text('Logging outs...',
            style: TextStyle(
              fontSize: 16,
              color: kPrimaryBlackColor,
              fontFamily: 'Poppins',
            )),
        content: const SizedBox(
          height: 50,
          width: 400,
          child: Text("Are you sure you want to logout?",
              style: TextStyle(
                  fontSize: 18,
                  color: kPrimaryBlackColor,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300)),
        ),
        actions: [
          PopUpButton(
              color: kSubBlackColor,
              onPressed: () {
                Navigator.pop(context);
              },
              text: 'Cancel'),
          PopUpButton(
              color: kSecondaryColor,
              onPressed: () async {
                await LocalData.deleteUserType();
                LocalData.deleteUserToken().whenComplete(() => {
                      Navigator.pushNamed(context, '/ems/login')

                      // Navigator.pushAndRemoveUntil(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const Login()),
                      //     ModalRoute.withName("/login"))
                    });
              },
              text: 'Yes'),
        ],
      );
    },
  );
}

class PopUpButton extends StatelessWidget {
  const PopUpButton({
    Key? key,
    required this.text,
    required this.color,
    required this.onPressed,
  }) : super(key: key);
  final String text;
  final Color color;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 15,
              color: color,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500),
        ));
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.onPressed,
    required this.tabController,
    required this.index,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final VoidCallback onPressed;
  final TabController tabController;
  final int index;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon,
          color:
              tabController.index == index ? kSecondaryColor : kSubBlackColor),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          color: tabController.index == index
              ? kPrimaryBlackColor
              : kSubBlackColor,
          fontFamily: 'Poppins',
        ),
      ),
      selected: tabController.index == index ? true : false,
      onTap: onPressed,
    );
  }
}
