// core
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';

// packages
import 'package:flutter/cupertino.dart';

class ImageSelector extends StatelessWidget {
  const ImageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.black26),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.camera_fill,
              size: 32.0,
              color: AppColors.black54,
            ),
            // 추가된 사진 개수 표시 - 10장까지 추가 가능
            Text(
              '0/10',
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
