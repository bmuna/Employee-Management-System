import 'package:employee_managment/common/size.dart';
import 'package:employee_managment/common/theme.dart';
import 'package:employee_managment/component/loading_widget.dart';
import 'package:employee_managment/component/main_button.dart';
import 'package:employee_managment/component/main_head_title.dart';
import 'package:employee_managment/controllers/main/user_provider.dart';
import 'package:employee_managment/controllers/utils.dart';
import '../../models/users/list_of_role_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Task extends StatefulWidget {
  const Task({Key? key}) : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  Map<String, String? Function(String?)?> formFields = {
    'Task 1': (String? value) {
      return (value!.isEmpty) ? 'Enter task' : null;
    },
  };
  @override
  void initState() {
    super.initState();
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.userWithRole();
    userProvider.taskControllers.add(TextEditingController());
  }

  @override
  void dispose() {
    super.dispose();
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.taskControllers.clear();
    for (TextEditingController textcontrol in userProvider.taskControllers) {
      textcontrol.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    FrameSize.init(context: context);
    return Consumer<UserProvider>(builder: (_, userProvider, __) {
      return Center(
        child: userProvider.loading
            ? const LoadingWidget()
            : Card(
                elevation: 3,
                child: SingleChildScrollView(
                  child: Container(
                    height: FrameSize.screenHeight *
                        (FrameSize.screenHeight > 770
                            ? 0.5
                            : FrameSize.screenHeight > 670
                                ? 0.8
                                : 0.8),
                    width: 500,
                    color: Colors.white,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Form(
                        key: userProvider.taskFormKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const MainHeadTitle(title: 'Add Tasks'),
                              DropdownButtonFormField<String>(
                                value: userProvider.dropdownValue,
                                hint: const Text("Role"),
                                onChanged: (var newValue) {
                                  setState(() {
                                    userProvider.taskDropDown = newValue!;
                                  });
                                },
                                validator: (var value) {
                                  if (value?.isEmpty ?? true) {
                                    return 'Enter role';
                                  }
                                },
                                items: userProvider.listOfRoleRes!.result
                                    .map((Result value) {
                                  String role =
                                      MainUtils.convertToTitleCase(value.role);
                                  userProvider.roleId = value.id;
                                  return DropdownMenuItem<String>(
                                    value: role,
                                    child: Text(role),
                                  );
                                }).toList(),
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                          itemCount: formFields.length,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              children: [
                                                Expanded(
                                                  flex: 5,
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                      labelText: formFields.keys
                                                          .elementAt(index),
                                                    ),
                                                    onSaved: (String? value) {},
                                                    controller: userProvider
                                                        .taskControllers[index],
                                                    validator: formFields[
                                                        formFields.keys
                                                            .elementAt(index)],
                                                  ),
                                                ),
                                                index == formFields.length - 1
                                                    ? FloatingActionButton
                                                        .small(
                                                        elevation: 3,
                                                        backgroundColor:
                                                            kSecondaryColor,
                                                        onPressed: () {
                                                          setState(() {
                                                            userProvider
                                                                .taskControllers
                                                                .add(
                                                                    TextEditingController());

                                                            formFields.addAll({
                                                              'Task ${formFields.length + 1}':
                                                                  (String?
                                                                      value) {
                                                                return (value!
                                                                        .isEmpty)
                                                                    ? 'Enter task'
                                                                    : null;
                                                              },
                                                            });
                                                          });
                                                        },
                                                        child: const Icon(
                                                          Icons.add,
                                                          color:
                                                              kPrimaryLightColor,
                                                        ),
                                                      )
                                                    : FloatingActionButton
                                                        .small(
                                                        elevation: 1,
                                                        backgroundColor:
                                                            kSubBlackColor,
                                                        onPressed: () {
                                                          setState(() {
                                                            userProvider
                                                                .taskControllers
                                                                .removeAt(
                                                                    index);

                                                            formFields.remove(
                                                                formFields.keys
                                                                    .elementAt(
                                                                        index));
                                                          });
                                                        },
                                                        child: const Icon(
                                                          Icons.remove,
                                                          color:
                                                              kPrimaryLightColor,
                                                        ),
                                                      )
                                              ],
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              )),
                              MainButton(
                                  text: 'Submit',
                                  isLoading: userProvider.buttonLoading,
                                  onPressed: () =>
                                      userProvider.addTask(context)),
                              const SizedBox(
                                height: 32,
                              ),
                            ]),
                      ),
                    )),
                  ),
                )),
      );
    });
  }
}
