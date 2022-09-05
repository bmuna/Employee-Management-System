import 'package:employee_managment/common/size.dart';
import 'package:employee_managment/component/main_button.dart';
import 'package:employee_managment/component/main_head_title.dart';
import 'package:employee_managment/component/main_text_field_icon.dart';
import 'package:employee_managment/component/main_text_field_no_icon.dart';
import 'package:employee_managment/controllers/main/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Role extends StatefulWidget {
  const Role({Key? key}) : super(key: key);

  @override
  State<Role> createState() => _RoleState();
}

class _RoleState extends State<Role> {
  @override
  void dispose() {
    super.dispose();
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.roleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FrameSize.init(context: context);

    return Consumer<UserProvider>(builder: (_, userProvider, __) {
      return Center(
          child: Card(
        elevation: 3,
        child: Container(
          height: FrameSize.screenHeight *
              (FrameSize.screenHeight > 770
                  ? 0.5
                  : FrameSize.screenHeight > 670
                      ? 0.5
                      : 0.6),
          width: 500,
          color: Colors.white,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(40),
            child: Form(
              key: userProvider.roleFormKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const MainHeadTitle(title: 'Add Roles'),
                    MainTextFieldNoIcon(
                      hintText: 'Title',
                      prefixIconExist: false,
                      textEditingController: userProvider.roleController,
                      validatorText: "Enter role",
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    MainButton(
                        text: 'Submit',
                        isLoading: userProvider.buttonLoading,
                        onPressed: () => userProvider.addRole(context)),
                    const SizedBox(
                      height: 32,
                    ),
                  ]),
            ),
          )),
        ),
      ));
    });
  }
}
