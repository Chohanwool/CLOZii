import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';
import 'package:flutter/material.dart';

class MeetingPointSelector extends StatefulWidget {
  const MeetingPointSelector({super.key});

  @override
  State<MeetingPointSelector> createState() => _MeetingPointSelectorState();
}

class _MeetingPointSelectorState extends State<MeetingPointSelector> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      onTap: () {
        debugPrint('onTap');
      },
      decoration: InputDecoration(
        isDense: true,

        hint: Row(
          children: [Text('Select Meeting Point'), Icon(Icons.chevron_right)],
        ),

        // 필드 활성화 시 테두리 색 지정 - 사실상 기본 테두리 색
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.black54),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.black54),
        ),
      ),
    );
  }
}
