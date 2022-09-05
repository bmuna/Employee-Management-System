import 'package:employee_managment/common/size.dart';
import 'package:employee_managment/component/loading_widget.dart';
import 'package:employee_managment/component/no_data_widget.dart';
import 'package:employee_managment/controllers/main/user_provider.dart';
import 'package:employee_managment/controllers/utils.dart';
import 'package:employee_managment/views/admin_dashboard/components/employee_role_info_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeRole extends StatefulWidget {
  const EmployeeRole({
    Key? key,
  }) : super(key: key);

  @override
  State<EmployeeRole> createState() => _EmployeeRoleState();
}

class _EmployeeRoleState extends State<EmployeeRole> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).userWithRole();
  }

  @override
  Widget build(BuildContext context) {
    FrameSize.init(context: context);
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(FrameSize.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Employee role",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
            Consumer<UserProvider>(builder: (_, userProvider, __) {
              return userProvider.loading
                  ? const LoadingWidget()
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: userProvider.userWithRoleRes!.result.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        DateTime dbDate = userProvider
                            .userWithRoleRes!.result[index].createdAt;
                        String fullName = userProvider
                            .userWithRoleRes!.result[index].fullName;

                        String role =
                            userProvider.userWithRoleRes!.result[index].role;
                        String date = MainUtils.dbDateChanger(dbDate);
                        return userProvider.userWithRoleRes!.result.isEmpty
                            ? const NoDataWidget()
                            : EmployeeRoleInfoCard(
                                fullName: fullName,
                                role: role,
                                date: date,
                              );
                      });
            })
          ],
        ),
      ),
    );
  }
}
