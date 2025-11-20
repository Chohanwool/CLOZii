// core
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/features/post/presentation/providers/go_to_phrase/go_to_phrase_provider.dart';

// features

// packages
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoreOptionsModal extends ConsumerWidget {
  const MoreOptionsModal({
    super.key,
    required this.currentPhrase,
    required this.onEditButtonPressed,
  });

  final String currentPhrase;
  final ValueChanged<String> onEditButtonPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoActionSheet(
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          child: Text(
            '수정',
            style: context.textTheme.titleLarge!.copyWith(
              color: AppColors.info,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
            // 수정 로직
            onEditButtonPressed(currentPhrase);
          },
        ),
        CupertinoActionSheetAction(
          child: Text(
            '삭제',
            style: context.textTheme.titleLarge!.copyWith(
              color: AppColors.error,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
            // 삭제 로직
            ref.read(goToPhrasesProvider.notifier).removePhrase(currentPhrase);
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          '취소',
          style: context.textTheme.titleLarge!.copyWith(
            color: AppColors.warning,
            fontWeight: FontWeight.w400,
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
