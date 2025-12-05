// core
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/widgets/custom_button.dart';
import 'package:clozii/features/post/presentation/providers/post_create/post_create_provider.dart';

// features
import 'package:clozii/features/post/presentation/widgets/post_create/modals/detail_address_modal.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/meeting_point_map.dart';

// packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MeetingPointMapModal extends ConsumerStatefulWidget {
  const MeetingPointMapModal({super.key});

  @override
  ConsumerState<MeetingPointMapModal> createState() =>
      _MeetingPointMapModalState();
}

class _MeetingPointMapModalState extends ConsumerState<MeetingPointMapModal> {
  LatLng? _currentLatLng;
  bool _showSavedAddress = true; // 저장된 주소 표시 여부
  String? _initialDetailAddress; // 화면 진입 시점의 주소 스냅샷

  @override
  void initState() {
    super.initState();
    // 화면 진입 시점의 주소를 로컬 상태로 저장 (reactive하지 않음)
    _initialDetailAddress =
        ref.read(postCreateProvider).meetingLocation?.detailAddress;
  }

  void _onCameraIdle(LatLng currentLatLng) {
    _currentLatLng = currentLatLng;
  }

  void _onCameraMove() {
    // 지도가 움직이면 저장된 주소 숨김
    if (_showSavedAddress) {
      setState(() {
        _showSavedAddress = false;
      });
    }
  }

  void _showDetailAddressModal(BuildContext context) async {
    final detailAddress = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      builder: (context) => DetailAddressModal(currentLatLng: _currentLatLng!),
    );

    if (detailAddress != null) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 키보드가 올라와도 UI가 움직이지 않도록 설정
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Drag and locate the marker \nto where you want to meet the buyer.',
                  style: context.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Choose an accessible, visible location \nfor a safe transaction.',
                  style: context.textTheme.bodyLarge,
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),

          // Map
          Expanded(
            child: Stack(
              children: [
                MeetingPointMap(
                  onCameraIdle: _onCameraIdle,
                  onCameraMove: _onCameraMove,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 48.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_initialDetailAddress != null && _showSavedAddress)
                          Container(
                            width: double.infinity,
                            height: 80.0,
                            decoration: BoxDecoration(
                              boxShadow: [
                                const BoxShadow(
                                  color: AppColors.gray200,
                                  blurRadius: 10.0,
                                  offset: Offset(0, 10.0),
                                ),
                              ],
                              color: AppColors.white70,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Center(
                              child: Text(
                                _initialDetailAddress!,
                                style: context.textTheme.titleLarge,
                              ),
                            ),
                          ),
                        const SizedBox(height: 16.0),
                        CustomButton(
                          text: 'Save',
                          onTap: () => _showDetailAddressModal(context),
                          height: 50.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
