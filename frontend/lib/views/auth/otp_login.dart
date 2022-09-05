import 'package:employee_managment/component/main_button.dart';
import 'package:employee_managment/component/main_head_title.dart';
import 'package:employee_managment/component/main_text_field_icon.dart';
import 'package:employee_managment/controllers/auth/auth_provider.dart';
import 'package:flutter/material.dart';

import 'package:employee_managment/common/size.dart';
import 'package:employee_managment/common/theme.dart';
import 'package:provider/provider.dart';

class OTPLogin extends StatefulWidget {
  const OTPLogin({
    Key? key,
  }) : super(key: key);

  @override
  _OTPLoginState createState() => _OTPLoginState();
}

class _OTPLoginState extends State<OTPLogin> {
  bool isAdmin = true;
  @override
  Widget build(BuildContext context) {
    FrameSize.init(context: context);
    return Scaffold(
        body: Builder(
      builder: (ctx) => SizedBox(
        width: FrameSize.screenWidth,
        height: FrameSize.screenHeight,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: kPrimaryBlackColor,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                    ),
                  ]),
            ),
            Padding(
                padding: EdgeInsets.all(FrameSize.screenHeight > 770
                    ? 64
                    : FrameSize.screenHeight > 670
                        ? 32
                        : 16),
                child: Center(
                  child: Card(
                    elevation: 40,
                    child: Container(
                      height: FrameSize.screenHeight *
                          (FrameSize.screenHeight > 770
                              ? 0.5
                              : FrameSize.screenHeight > 670
                                  ? 0.6
                                  : 0.7),
                      width: 400,
                      color: kPrimaryLightColor,
                      child: Center(
                          child: Padding(
                              padding: const EdgeInsets.all(40),
                              child: Consumer<AuthProvider>(
                                  builder: (_, authProvider, __) {
                                return Form(
                                  key: authProvider.otpFormKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const MainHeadTitle(
                                          title: 'CONFIRM LOGIN'),
                                      const SizedBox(
                                        height: 32,
                                      ),
                                      MainTextField(
                                        hintText: 'OTP Code',
                                        icon: Icons.lock,
                                        textEditingController:
                                            authProvider.otpController,
                                        validatorText: "Enter otp code",
                                        prefixIconExist: true,
                                      ),
                                      const SizedBox(
                                        height: 64,
                                      ),
                                      const SizedBox(
                                        height: 32,
                                      ),
                                      MainButton(
                                          text: 'Confirm',
                                          onPressed: (() =>
                                              authProvider.otpConfirm(ctx)),
                                          isLoading: authProvider.loading),
                                      const SizedBox(
                                        height: 32,
                                      ),
                                    ],
                                  ),
                                );
                              }))),
                    ),
                  ),
                ))
          ],
        ),
      ),
    ));
  }
}
