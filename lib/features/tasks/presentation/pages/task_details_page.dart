// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_import
// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:s_c/app/domain/entities/sc_user.dart';
import 'package:s_c/app/presentation/cubit/app_cubit.dart';
import 'package:s_c/app/presentation/widgets/screen.dart';
import 'package:s_c/core/widgets_catalog/btn/btn_default/btn_default.dart';
import 'package:s_c/core/widgets_catalog/dialogs/hcm23_dialog.dart';
import 'package:s_c/core/widgets_catalog/inputs/input_normal/input_normal.dart';
import 'package:s_c/features/home/presentation/pages/home_page.dart';
import 'package:s_c/features/register/domain/entities/task.dart';
import 'package:s_c/features/tasks/presentation/cubit/tasks_cubit.dart';

String formatDueTime(String duetime) {
  DateTime? dueDateTime = DateTime.tryParse(duetime);
  if (dueDateTime == null) return "-";
  String formattedDueTime =
      DateFormat('hh:mm a, dd MMM yyyy').format(dueDateTime);
  return formattedDueTime;
}

class TaskDetailsArg {
  final String userId;
  final SCTask task;
  final List<SCTask> listTasks;
  TaskDetailsArg({
    required this.userId,
    required this.task,
    required this.listTasks,
  });
}

class TaskDetailsPage extends StatefulWidget {
  static String routeName = "/TaskDetailsPage";

  final TaskDetailsArg arg;
  const TaskDetailsPage({
    Key? key,
    required this.arg,
  }) : super(key: key);

  @override
  _TaskDetailsPageState createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  late TextEditingController titleController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();
  final TextEditingController startDateCtrl = TextEditingController();
  final TextEditingController dueDateCtrl = TextEditingController();
  bool isEdit = false;
  late final _cubit = context.read<TasksCubit>();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.arg.task.title ?? "";
    descriptionController.text = widget.arg.task.description ?? "";
    startDateCtrl.text = widget.arg.task.starttime.toString();
    dueDateCtrl.text = widget.arg.task.duetime.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Task Details"),
        ),
        body: isEdit ? _buildEditBody() : _buildViewBody(),
      );
    });
  }

  Widget _buildViewBody() {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        if (state is! EditTaskState) {
          return Container();
        }
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Task Title',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF5D6B98),
                            height: 20 / 14,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          state.task.title ?? "",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1D2939),
                            height: 30 / 20,
                          ),
                        ),
                        const SizedBox(height: 21),
                        const Text(
                          'Start Date',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF5D6B98),
                            height: 20 / 14,
                          ),
                        ),
                        Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.access_time,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                  formatDueTime(
                                      state.task.starttime.toString()),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    height: 18 / 14,
                                    color: Color(0xFF111322),
                                  )),
                              const Spacer(),
                            ]),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          'Due Date',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF5D6B98),
                            height: 20 / 14,
                          ),
                        ),
                        Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.access_time,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 8),
                              Text(formatDueTime(state.task.duetime.toString()),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    height: 18 / 14,
                                    color: Color(0xFF111322),
                                  )),
                              const Spacer(),
                              Container(
                                  height: 34,
                                  width: 95,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(3, 152, 85, 0.1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: const Text(
                                    'On Progress',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF039855),
                                      fontWeight: FontWeight.w500,
                                      height: 18 / 12,
                                    ),
                                  )),
                            ]),
                        const SizedBox(height: 27),
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF5D6B98),
                            height: 20 / 14,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          state.task.description ?? "",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 20 / 14,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const SizedBox(
                          height: 12,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: BtnDefault(
                  onTap: () {
                    setState(() {
                      isEdit = true;
                    });
                  },
                  title: 'EDIT TASK',
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEditBody() {
    return BlocConsumer<TasksCubit, TasksState>(
      listener: (context, state) {
        if (state is EditTaskSuccessState) {
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
                  onPressed: () async {
                    _cubit.doGetTasks(
                        userUid: context
                                .read<AppCubit>()
                                .state
                                .authState
                                .user
                                ?.uid ??
                            "");

                    Navigator.of(context)
                        .popUntil(ModalRoute.withName(HomePage.routeName));
                  },
                ),
              ],
            ),
          );
        } else if (state is EditTaskStateFailure) {
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
                    Navigator.of(context)
                        .popUntil(ModalRoute.withName(HomePage.routeName));
                  },
                ),
              ],
            ),
          );
        }
      },
      buildWhen: (previous, current) {
        return previous is EditTaskState &&
            current is EditTaskState &&
            previous.task != current.task;
      },
      builder: (context, state) {
        if (state is! EditTaskState) {
          return Container();
        } else {
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
                              style: TextStyle(color: Color(0XFF5D6B98)),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: InputNormal(
                                    controller: titleController,
                                    placeholderText: "Enter task's title",
                                    valueTextStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                    onChanged: (p0) {
                                      _cubit.doChangeCurrentTaskTitle(p0 ?? "");
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
                                  if (!value) {}
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
                                  if (!value) {}
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
                              style: TextStyle(color: Color(0XFF5D6B98)),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: InputNormal(
                                  controller: descriptionController,
                                  placeholderText: "Enter task's description",
                                  minLines: 8,
                                  valueTextStyle: const TextStyle(
                                    color: Color(0XFF111322),
                                    fontSize: 14,
                                  ),
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.zero),
                                  onChanged: (p0) {
                                    _cubit.doChangeCurrentTaskDes(p0 ?? "");
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
                    _cubit.doUpdateTask(state.task);
                  },
                  title: "DONE",
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
