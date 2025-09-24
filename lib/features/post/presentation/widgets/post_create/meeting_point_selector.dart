import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/meeting_point_map_modal.dart';
import 'package:flutter/material.dart';

class MeetingPointSelector extends StatefulWidget {
  const MeetingPointSelector({super.key, required this.onAddressSelected});

  final ValueChanged<String> onAddressSelected;

  @override
  State<MeetingPointSelector> createState() => _MeetingPointSelectorState();
}

class _MeetingPointSelectorState extends State<MeetingPointSelector> {
  String _detailAddress = '';

  void _showMap() async {
    final detailAddress = await showModalBottomSheet(
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

    if (detailAddress != null && context.mounted) {
      setState(() {
        _detailAddress = detailAddress;
      });

      widget.onAddressSelected(detailAddress);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      onTap: () {
        _showMap();
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

        helper: _detailAddress.isNotEmpty
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check, color: AppColors.success, size: 18.0),
                  SizedBox(width: 8.0),
                  Expanded(child: Text(_detailAddress)),
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
