// core
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';

// features
import 'package:clozii/features/post_old/provider/go_to_phrases_provider.dart';

// packages
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoreOptionsModal extends ConsumerWidget {
  const MoreOptionsModal({
    super.key,
    required this.currentPhrase,
    required this.onAddPhraseModal,
  });

  final String currentPhrase;
  final ValueChanged<String> onAddPhraseModal;

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
            onAddPhraseModal(currentPhrase);
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
