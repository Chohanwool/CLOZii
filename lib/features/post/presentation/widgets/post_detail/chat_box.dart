// core
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/widgets/custom_button.dart';

// feature
import 'package:clozii/features/post/presentation/widgets/post_detail/chat_field.dart';

// package
import 'package:flutter/material.dart';

class ChatBox extends StatelessWidget {
  const ChatBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: context.colors.shadow)),
      ),
      child: Row(
        children: [
          // ... 아이콘, TextField, Send 버튼
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border_outlined, size: 30.0),
          ),
          const Expanded(child: ChatField()),
          const SizedBox(width: 8.0),
          CustomButton(text: 'Send', onTap: () {}, width: 80.0, height: 45.0),
          const SizedBox(width: 8.0),
        ],
      ),
    );
  }
}
