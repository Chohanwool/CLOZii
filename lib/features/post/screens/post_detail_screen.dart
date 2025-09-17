import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/utils/number_format.dart';
import 'package:clozii/core/utils/show_uploaded_time.dart';
import 'package:clozii/features/post/data/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            foregroundColor: context.colors.onPrimary,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  PageView(
                    children: [
                      ...post.imageUrls.map(
                        (url) => Image.network(url, fit: BoxFit.cover),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Builder(
                      builder: (context) => Container(
                        height:
                            MediaQuery.of(context).padding.top + kToolbarHeight,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black38, Colors.transparent],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(CupertinoIcons.arrowshape_turn_up_right_fill),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('UserData', style: context.textTheme.titleLarge),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Divider(indent: 20, endIndent: 20),
                  const SizedBox(height: 10),
                  Text(post.title, style: context.textTheme.titleLarge),
                  const SizedBox(height: 10),
                  post.price != null
                      ? Text(
                          '\u20B1 ${formatPrice(post.price!)}', //₱
                          style: context.textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      : Row(
                          children: [
                            Text(
                              'SHARES',
                              style: context.textTheme.titleLarge!.copyWith(
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
                  const SizedBox(height: 10),
                  Text(
                    showUploadedTime(post.createdAt),
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: context.colors.scrim,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (post.content != null)
                    Text(post.content!, style: context.textTheme.bodyLarge),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
