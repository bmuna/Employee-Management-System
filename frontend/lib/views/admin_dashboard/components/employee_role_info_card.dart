import 'dart:math';

import 'package:employee_managment/common/size.dart';
import 'package:employee_managment/common/theme.dart';
import 'package:employee_managment/controllers/utils.dart';
import 'package:flutter/material.dart';

class EmployeeRoleInfoCard extends StatelessWidget {
  const EmployeeRoleInfoCard({
    Key? key,
    required this.fullName,
    required this.role,
    required this.date,
  }) : super(key: key);

  final String fullName, role, date;

  @override
  Widget build(BuildContext context) {
    FrameSize.init(context: context);
    String fullNameConverted = MainUtils.convertToTitleCase(fullName);
    String roleConverted = MainUtils.convertToTitleCase(role);
    const List<String> randomImages = [
      "assets/images/profile1.jpg",
      "assets/images/profile2.jpg",
      "assets/images/profile3.jpg",
    ];
    Random random = Random();
    int randomIndex = random.nextInt(randomImages.length);
    String randomImage = randomImages[randomIndex];
    return Container(
        margin: const EdgeInsets.only(top: FrameSize.defaultPadding),
        padding: const EdgeInsets.all(FrameSize.defaultPadding),
        decoration: BoxDecoration(
          border:
              Border.all(width: 2, color: kSecondaryColor.withOpacity(0.15)),
          borderRadius: const BorderRadius.all(
            Radius.circular(FrameSize.defaultPadding),
          ),
        ),
        child: Row(children: [
          CircleAvatar(
            radius: 20,
            child: SizedBox(
              height: 40,
              width: 40,
              child: ClipOval(
                  child: Image.asset(
                randomImage,
                fit: BoxFit.cover,
              )),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        fullNameConverted,
                        style: const TextStyle(
                            fontSize: 14,
                            color: kPrimaryBlackColor,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        roleConverted,
                        style: const TextStyle(
                            fontSize: 14,
                            color: kPrimaryBlackColor,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500),
                      )
                    ]),
                Text(date,
                    style: const TextStyle(
                        fontSize: 12,
                        color: kSubBlackColor,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300))
              ]))
        ]));
  }
}
