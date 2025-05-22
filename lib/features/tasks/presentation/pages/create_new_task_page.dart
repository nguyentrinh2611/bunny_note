import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../app/presentation/cubit/app_cubit.dart';
import '../../../../app/presentation/widgets/screen.dart';
import '../../../../core/widgets_catalog/btn/btn_default/btn_default.dart';
import '../../../../core/widgets_catalog/dialogs/hcm23_dialog.dart';
import '../../../../core/widgets_catalog/inputs/input_normal/input_normal.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../cubit/tasks_cubit.dart';

class CreateNewTaskPage extends StatefulWidget {
  static const String routeName = "/CreateNewTaskPage";

  const CreateNewTaskPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateNewTaskPage> createState() => _CreateNewTaskPageState();
}

class _CreateNewTaskPageState extends State<CreateNewTaskPage> {
  final TextEditingController startDateCtrl = TextEditingController();
  final TextEditingController dueDateCtrl = TextEditingController();

  late final _cubit = context.read<TasksCubit>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      builder: (context) {
        return Scaffold(
            appBar: AppBar(
              title: const Text(
                "New Task",
              ),
              elevation: 0,
            ),
            body: BlocConsumer<TasksCubit, TasksState>(
              listener: (context, state) {
                if (state is CreateNewTaskStateSuccess) {
                  showDialog(
                    context: context,
                    builder: (context) => HCM23Dialog(
                      title: 'Thông báo',
                      content: "Thêm mới bản ghi thành công",
                      backgroundColor: Colors.green.withOpacity(0.4),
                      titleTextStyle: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      contentTextStyle:
                          const TextStyle(fontSize: 16, color: Colors.white),
                      actions: [
                        CleanDialogActionButtons(
                          actionTitle: 'OK',
                          onPressed: () {
                            _cubit.doGetTasks(
                                userUid: context
                                        .read<AppCubit>()
                                        .state
                                        .authState
                                        .user
                                        ?.uid ??
                                    "");
                            Navigator.of(context).popUntil(
                                ModalRoute.withName(HomePage.routeName));
                          },
                        ),
                      ],
                    ),
                  );
                } else if (state is CreateNewTaskStateFailure) {
                  showDialog(
                    context: context,
                    builder: (context) => HCM23Dialog(
                      title: 'Error',
                      content: "Có lỗi xảy ra, vui lòng thử lại sau",
                      backgroundColor: Colors.red.withOpacity(0.4),
                      titleTextStyle: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      contentTextStyle:
                          const TextStyle(fontSize: 16, color: Colors.white),
                      actions: [
                        CleanDialogActionButtons(
                          actionTitle: 'OK',
                          onPressed: () {
                            Navigator.of(context).popUntil(
                                ModalRoute.withName(HomePage.routeName));
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is! CreateNewTaskState) {
                  return Container();
                } else {
                  startDateCtrl.text = DateFormat("dd/MM/yyyy")
                      .format(state.newTask.starttime!)
                      .toString();
                  dueDateCtrl.text = DateFormat("dd/MM/yyyy")
                      .format(state.newTask.duetime!)
                      .toString();
                  return Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 28,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Task title",
                                      style:
                                          TextStyle(color: Color(0XFF5D6B98)),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: InputNormal(
                                            placeholderText:
                                                "Enter task's title",
                                            valueTextStyle: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.zero,
                                            ),
                                            onChanged: (p0) {
                                              _cubit
                                                  .doChangeTaskTitle(p0 ?? "");
                                            },
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Focus(
                                        onFocusChange: (value) {
                                          if (!value) {
                                            _cubit.doChangeStartDate(
                                              startDateCtrl.text,
                                            );
                                          }
                                        },
                                        child: InputNormal(
                                          controller: startDateCtrl,
                                          labelText: "Start date",
                                          maxLines: 1,
                                          decoration: InputDecoration(
                                            prefixIcon: SvgPicture.asset(
                                              "assets/icons/ui_kit/bold/calendar.svg",
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Focus(
                                        onFocusChange: ((value) {
                                          if (!value) {
                                            _cubit.doChangeStartDate(
                                                startDateCtrl.text);
                                          }
                                        }),
                                        child: InputNormal(
                                          labelText: "Due date",
                                          maxLines: 1,
                                          controller: dueDateCtrl,
                                          decoration: InputDecoration(
                                            prefixIcon: SvgPicture.asset(
                                              "assets/icons/ui_kit/bold/calendar.svg",
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Description",
                                      style:
                                          TextStyle(color: Color(0XFF5D6B98)),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: InputNormal(
                                          placeholderText:
                                              "Enter task's description",
                                          minLines: 8,
                                          valueTextStyle: const TextStyle(
                                            color: Color(0XFF111322),
                                            fontSize: 14,
                                          ),
                                          decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.zero),
                                          onChanged: (p0) {
                                            _cubit.doChangeTaskDes(p0 ?? "");
                                          },
                                        ))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 24,
                        ),
                        child: BtnDefault(
                          onTap: () {
                            _cubit.doAddNewTask();
                          },
                          title: "ADD",
                        ),
                      ),
                    ],
                  );
                }
              },
            ));
      },
    );
  }
}
