// core
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';

// features
import 'package:clozii/features/post_old/provider/go_to_phrases_provider.dart';

// packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GoToPhraseModal extends StatefulWidget {
  const GoToPhraseModal({
    super.key,
    required this.onAddButtonPressed,
    required this.onMoreOptionsPressed,
    required this.onPhraseSelected,
  });

  final ValueChanged<String?> onAddButtonPressed;
  final ValueChanged<String> onMoreOptionsPressed;
  final ValueChanged<String> onPhraseSelected;

  @override
  State<GoToPhraseModal> createState() => _GoToPhraseModalState();
}

class _GoToPhraseModalState extends State<GoToPhraseModal> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Drag Handle
        Divider(
          thickness: 4.0,
          color: AppColors.black12,
          indent: 150.0,
          endIndent: 150.0,
        ),

        // 자주 쓰는 문구 타이틀 / 추가 버튼
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('My Go-To Phrases', style: context.textTheme.titleLarge),

            // 추가 버튼
            TextButton(
              onPressed: () => widget.onAddButtonPressed(null),
              style: TextButton.styleFrom(
                iconSize: 26.0,
                textStyle: context.textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                ),
              ),
              child: const Row(children: [Icon(Icons.add), Text('Add')]),
            ),
          ],
        ),

        const SizedBox(height: 10.0),
        const Divider(),

        // Consumer로 감싸서 상태 변화를 실시간으로 감지
        Expanded(
          child: Consumer(
            builder: (context, ref, child) {
              final goToPhrases = ref.watch(goToPhrasesProvider);

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  goToPhrases.isEmpty
                      ? Center(
                          child: Text(
                            'Try adding some go-to phrases.',
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: AppColors.black54,
                            ),
                          ),
                        )
                      // 자주 쓰는 문구 - ListTile
                      : Expanded(
                          child: ListView.builder(
                            itemCount: goToPhrases.length,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,

                                    title: Text(goToPhrases[index]),
                                    onTap: () => widget.onPhraseSelected(
                                      goToPhrases[index],
                                    ),

                                    // 더보기 버튼
                                    trailing: IconButton(
                                      onPressed: () =>
                                          widget.onMoreOptionsPressed(
                                            goToPhrases[index],
                                          ),
                                      icon: Icon(Icons.more_vert),
                                    ),
                                  ),
                                  const Divider(),
                                ],
                              );
                            },
                          ),
                        ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
