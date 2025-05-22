// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:s_c/features/register/domain/entities/task.dart';

class TaskCard extends StatefulWidget {
  final SCTask task;
  final Color color;
  final void Function() viewTask;
  final void Function() deleteTask;

  const TaskCard({
    Key? key,
    required this.task,
    required this.color,
    required this.viewTask,
    required this.deleteTask,
  }) : super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool isSelecting = false;

  void openMenu() async {
    setState(() {
      isSelecting = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        isSelecting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: openMenu,
      onTap: widget.viewTask,
      child: Row(
        children: [
          _buildLeading(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.task.title ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.task.description ?? "",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${DateFormat("hh:mm a").format(widget.task.starttime ?? DateTime.now())} - ${DateFormat("hh:mm a").format(widget.task.duetime ?? DateTime.now())}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isSelecting)
            SizedBox(
              width: 40,
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      widget.deleteTask.call();
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }

  Widget _buildLeading() {
    return Container(
      width: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        DateFormat("hh:mm a").format(widget.task.starttime ?? DateTime.now()),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
