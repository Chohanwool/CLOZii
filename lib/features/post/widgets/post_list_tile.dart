import 'package:clozii/core/theme/context_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostListTile extends StatelessWidget {
  const PostListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: ListTile(
            title: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Center(child: Text('Image')),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.width / 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Post Title', style: context.textTheme.titleSmall),
                        Text(
                          'address · 10mins ago',
                          style: context.textTheme.bodyLarge!.copyWith(
                            color: Colors.black45,
                          ),
                        ),
                        Text(
                          '\u20B1 500.0', //₱
                          style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
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
