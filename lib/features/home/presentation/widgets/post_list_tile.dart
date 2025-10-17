import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/utils/number_format.dart';
import 'package:clozii/core/utils/show_uploaded_time.dart';
import 'package:clozii/features/post_old/data/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostListTile extends StatelessWidget {
  const PostListTile({super.key, required this.post, required this.onTap});

  final Post post;
  final ValueChanged<Post> onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: ListTile(
            onTap: () => onTap(post),
            title: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Image.network(
                    post.thumbnailImageUrls[0],
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.width / 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.title,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.titleSmall,
                        ),
                        Text(
                          'address · ${showUploadedTime(post.createdAt)} ago',
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
                                    style: context.textTheme.bodyLarge!
                                        .copyWith(
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
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
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
                            Icon(
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
        ),
        Divider(),
      ],
    );
  }
}
