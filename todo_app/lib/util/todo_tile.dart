import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String TaskName;
  final bool TaskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  TodoTile(
      {super.key,
      required this.TaskName,
      required this.TaskCompleted,
      required this.onChanged,
      required this.deleteFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, right: 25, left: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: Colors.yellow, borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              // Checkbox

              Checkbox(
                value: TaskCompleted,
                splashRadius: 18,
                onChanged: onChanged,
                activeColor: Colors.black,
              ),

              // Task title
              Text(
                TaskName,
                style: TextStyle(
                    decoration: TaskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
