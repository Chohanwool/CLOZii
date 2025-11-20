// core
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/features/post/presentation/providers/post_create/post_create_provider.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/modals/meeting_point_map_modal.dart';

// features

// packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MeetingPointSelector extends ConsumerWidget {
  const MeetingPointSelector({super.key});

  void _showMap(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: AppColors.white,
      builder: (BuildContext context) => Container(
        padding: EdgeInsets.only(top: kToolbarHeight),
        child: MeetingPointMapModal(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meetingLocation = ref.read(postCreateProvider).meetingLocation;

    return TextField(
      readOnly: true,
      onTap: () {
        _showMap(context);
      },
      decoration: InputDecoration(
        isDense: true,

        hint: Row(
          children: [
            Text('Select Meeting Point'),
            Icon(Icons.chevron_right),
            Spacer(),
          ],
        ),

        helper: meetingLocation != null
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check, color: AppColors.success, size: 18.0),
                  SizedBox(width: 8.0),
                  Expanded(child: Text(meetingLocation.detailAddress)),
                ],
              )
            : null,

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
