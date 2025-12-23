// core
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/utils/number_format.dart';
import 'package:clozii/core/utils/show_uploaded_time.dart';

// feature
import 'package:clozii/features/post/application/dto/post_summary.dart';

// package
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostListTile extends StatelessWidget {
  const PostListTile({super.key, required this.post, required this.onTap});

  final PostSummary post;
  final ValueChanged<PostSummary> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.0,
            offset: const Offset(0, 5.0),
          ),
        ],
      ),
      child: ListTile(
        onTap: () => onTap(post),
        title: Row(
          children: [
            Material(
              borderRadius: BorderRadius.circular(12.0),
              clipBehavior: Clip.hardEdge,
              child: Container(
                width: MediaQuery.of(context).size.width / 4,
                height: MediaQuery.of(context).size.width / 4,
                decoration: const BoxDecoration(color: Colors.black26),
                child: post.thumbnailUrl != null
                    ? CachedNetworkImage(
                        fadeInDuration: Duration.zero,
                        fadeOutDuration: Duration.zero,
                        placeholderFadeInDuration: Duration.zero,
                        imageUrl: post.thumbnailUrl!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: AppColors.background,
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: AppColors.gray300,
                          child: const Icon(Icons.error, color: Colors.white),
                        ),
                      )
                    : Container(color: AppColors.gray300),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.width / 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.titleSmall,
                    ),
                    Text(
                      '${showUploadedTime(post.createdAt ?? DateTime.now())} ago',
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: Colors.black45,
                      ),
                    ),
                    post.price != 0
                        ? Text(
                            '\u20B1 ${formatPrice(post.price)}', //₱
                            style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : Row(
                            children: [
                              Text(
                                'SHARES',
                                style: context.textTheme.bodyLarge!.copyWith(
                                  color: context.colors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 4.0),
                              Icon(
                                Icons.favorite,
                                size: 16,
                                color: context.colors.primary,
                              ),
                            ],
                          ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.favorite_outline,
                          size: 16,
                          color: Colors.black26,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '10',
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: Colors.black38,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        const Icon(
                          CupertinoIcons.bubble_left,
                          size: 16,
                          color: Colors.black26,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '10',
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: Colors.black38,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
