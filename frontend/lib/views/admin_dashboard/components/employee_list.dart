import 'package:data_table_2/data_table_2.dart';
import 'package:employee_managment/common/theme.dart';
import 'package:employee_managment/component/loading_widget.dart';
import 'package:employee_managment/component/no_data_widget.dart';
import 'package:employee_managment/controllers/main/user_provider.dart';
import 'package:employee_managment/controllers/utils.dart';
import 'package:employee_managment/models/users/response_model/user_response_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeList extends StatelessWidget {
  const EmployeeList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 500,
            child: Consumer<UserProvider>(builder: (_, userProvider, __) {
              return userProvider.loading
                  ? const LoadingWidget()
                  : DataTable2(
                      empty: const NoDataWidget(),
                      columnSpacing: 16,
                      scrollController: scrollController,
                      minWidth: 600,
                      sortColumnIndex: 2,
                      columns: const [
                        DataColumn(
                          label: Text("Full Name",
                              style: TextStyle(
                                fontSize: 16,
                                color: kPrimaryBlackColor,
                                fontFamily: 'Poppins',
                              )),
                        ),
                        DataColumn(
                          label: Text(
                            "Email",
                            style: TextStyle(
                              fontSize: 16,
                              color: kPrimaryBlackColor,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text("Phone Number",
                              style: TextStyle(
                                fontSize: 16,
                                color: kPrimaryBlackColor,
                                fontFamily: 'Poppins',
                              )),
                        ),
                      ],
                      rows: List.generate(
                        userProvider.userResponse!.users.length,
                        (index) => usersDataRow(
                            userProvider.userResponse!.users[index], index),
                      ),
                    );
            }),
          )
        ],
      ),
    );
  }
}

DataRow usersDataRow(User user, int index) {
  String fullNameConverted = MainUtils.convertToTitleCase(user.fullName);
  return DataRow(
    cells: [
      // DataCell(UserDataText(data: (index + 1).toString())),
      DataCell(UserDataText(data: fullNameConverted)),
      DataCell(UserDataText(data: user.email)),
      DataCell(UserDataText(data: user.phoneNumber)),
    ],
  );
}

class UserDataText extends StatelessWidget {
  const UserDataText({
    Key? key,
    required this.data,
  }) : super(key: key);

  final String data;
  @override
  Widget build(BuildContext context) {
    return Text(data,
        style: const TextStyle(
          fontSize: 14,
          color: kSubBlackColor,
          fontFamily: 'Poppins',
        ));
  }
}
