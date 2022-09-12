import 'dart:math';

import 'package:employee_managment/common/size.dart';
import 'package:employee_managment/common/theme.dart';
import 'package:employee_managment/component/loading_widget.dart';
import 'package:employee_managment/component/no_data_widget.dart';
import 'package:employee_managment/controllers/main/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
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
              "Task List",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
            Consumer<UserProvider>(builder: (_, userProvider, __) {
              return userProvider.loadingTaskList
                  ? const LoadingWidget()
                  : userProvider.taskListResponse!.results.isEmpty
                      ? const NoDataWidget()
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              userProvider.taskListResponse!.results.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            String task = userProvider
                                .taskListResponse!.results[index].task;

                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: kSecondaryColor,
                                    radius: 10,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                        Icons.check,
                                        size: 15,
                                        color: kPrimaryLightColor,
                                      ),
                                      onPressed: null,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(task,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: kSubBlackColor,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400)),
                                  )
                                ],
                              ),
                            );
                          });
            })
          ],
        ),
      ),
    );
  }
}
