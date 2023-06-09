// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../shared/shared_ui/btn/btn_default/btn_default.dart';
import '../../../shared/shared_ui/inputs/input_normal/input_normal.dart';

class TaskStageInput extends StatefulWidget {
  final void Function() onRemove;
  final void Function() onChecked;
  final void Function(String?) onChanged;
  const TaskStageInput({
    Key? key,
    required this.onRemove,
    required this.onChecked,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<TaskStageInput> createState() => _TaskStageInputState();
}

class _TaskStageInputState extends State<TaskStageInput> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: InputNormal(
            placeholderText: "Enter stage's description",
            controller: controller,
            minLines: 1,
            maxLines: 5,
            valueTextStyle: const TextStyle(
              color: Color(0XFF111322),
              fontSize: 14,
            ),
            onChanged: widget.onChanged,
            decoration: const InputDecoration(contentPadding: EdgeInsets.zero),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        BtnDefault(
          type: BtnDefaultType.secondary,
          width: 40,
          onTap: widget.onRemove,
          customChild: Icon(
            getTaskStageIcon(controller.text),
            size: 16,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        BtnDefault(
          type: BtnDefaultType.secondary,
          width: 40,
          onTap: widget.onChecked,
          customChild: Icon(
            getTaskCheckedIcon(controller.text),
            size: 16,
          ),
        ),
      ],
    );
  }

  IconData getTaskStageIcon(String text) {
    return Icons.remove;
  }

  IconData getTaskCheckedIcon(String text) {
    return Icons.check;
  }
}
