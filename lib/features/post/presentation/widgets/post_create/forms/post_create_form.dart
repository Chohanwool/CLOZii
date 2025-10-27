import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/widgets/custom_button.dart';
import 'package:clozii/features/post/core/enums/trade_type.dart';
import 'package:clozii/features/post/presentation/provider/post_create_provider.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/fields/content_field.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/fields/price_field.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/fields/title_field.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/image_select_section.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/selectors/meeting_point_selector.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/selectors/trade_type_selector.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostCreateForm extends ConsumerStatefulWidget {
  const PostCreateForm({super.key});

  @override
  ConsumerState<PostCreateForm> createState() => _PostCreateFormState();
}

class _PostCreateFormState extends ConsumerState<PostCreateForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = ref.read(postCreateProvider).title;
    _contentController.text = ref.read(postCreateProvider).content;
    _priceController.text = ref.read(postCreateProvider).price.toString();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postCreateState = ref.watch(postCreateProvider);
    final postCreateNotifier = ref.read(postCreateProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),

        // 사진 선택 섹션 (ImageSelector + 선택된 사진 미리보기)
        ImageSelectSection(selectedImages: postCreateState.selectedImages),
        const SizedBox(height: 40.0),

        // 제목 입력 필드
        Text(
          'Title',
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10.0),
        PostTitleField(controller: _titleController),
        const SizedBox(height: 40.0),

        // 본문 입력 필드
        Text(
          'Content',
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10.0),
        ContentField(controller: _contentController),
        const SizedBox(height: 10.0),

        // 자주 쓰는 문구 버튼
        CustomButton(
          text: 'My Go-To Phrases',
          onTap: postCreateNotifier.showGoToPhrases,
          width: 160.0,
          height: 40.0,
        ),
        const SizedBox(height: 40.0),

        // 가격 / 판매 방법 선택
        Text(
          'Price',
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10.0),
        TradeTypeSelector(
          onSelected: (type) {
            ref.read(postCreateProvider.notifier).setTradeType(type);
          },
          selected: postCreateState.tradeType,
        ),
        const SizedBox(height: 16.0),
        PriceField(
          controller: _priceController,
          isForSale: postCreateState.tradeType == TradeType.sell,
        ),
        const SizedBox(height: 40.0),

        // 거래 희망 장소 선택
        Text(
          'Meeting Point',
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10.0),
        MeetingPointSelector(),

        const SizedBox(height: kBottomNavigationBarHeight * 2),
      ],
    );
  }
}
