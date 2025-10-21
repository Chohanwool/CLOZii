// core
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/utils/number_format.dart';
import 'package:clozii/core/utils/show_uploaded_time.dart';
import 'package:clozii/core/widgets/custom_text_link.dart';

// feature
import 'package:clozii/features/post/domain/entities/post.dart';

// package
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PostDetailBody extends StatelessWidget {
  const PostDetailBody({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    // 본문 내용
    return SliverToBoxAdapter(
      // 본문 패딩 설정
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20.0,
          left: 16.0,
          right: 16.0,
          bottom: 65.0 + kToolbarHeight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 사용자 정보, 매너 온도 표시(예시) - CLOZii 만의 포인트 시스템 필요
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('사용자 정보', style: context.textTheme.titleLarge),
                Text('매너 온도', style: context.textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 10),

            // 구분선
            Divider(indent: 20, endIndent: 20),
            const SizedBox(height: 10),

            // 제목
            Text(post.title, style: context.textTheme.titleLarge),
            const SizedBox(height: 10),

            // 가격 또는 나눔 표시
            // Post 객체의 price 필드에 저장된 가격이 있다면 가격을 표시하고,
            // 없다면(null), 나눔 표시
            post.price != 0
                ? Text(
                    '\u20B1 ${formatPrice(post.price)}', //₱
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
            const SizedBox(height: 10.0),

            // 카테고리(링크 텍스트), 업로드 시간 표시
            // 카테고리 탭 시, 관련된 상품들만 필터링 된 페이지로 이동
            Row(
              children: [
                CustomTextLink(
                  linkText: 'Category',
                  linkTextStyle: context.textTheme.bodyLarge!.copyWith(
                    color: context.colors.scrim,
                    decoration: TextDecoration.underline,
                    decorationColor: context.colors.scrim,
                  ),
                  onTap: () {},
                ),
                Text(' · '),
                Text(
                  '${showUploadedTime(post.createdAt)} ago',
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: context.colors.scrim,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),

            // 게시글 내용
            Text(post.content, style: context.textTheme.bodyLarge),

            const SizedBox(height: 24.0),

            // 거래 희망 장소
            if (post.detailAddress != null &&
                post.meetingPointLat != null &&
                post.meetingPointLong != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Meeting Point :', style: context.textTheme.titleSmall),

                  // 사용자가 입력한 장소명 (예: 광교 고등학교 앞)
                  Row(
                    children: [
                      CustomTextLink(
                        linkText: post.detailAddress!,
                        onTap: () {},
                      ),

                      const SizedBox(width: 10.0),

                      Icon(CupertinoIcons.right_chevron, size: 16.0),
                    ],
                  ),

                  const SizedBox(height: 20.0),

                  // 지도 화면
                  Material(
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadiusGeometry.circular(16.0),
                    child: Container(
                      width: double.infinity,
                      height: 150.0,
                      color: Colors.grey,

                      // 구글 맵스
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            post.meetingPointLat!,
                            post.meetingPointLong!,
                          ),
                          zoom: 17.0,
                        ),
                        markers: {
                          Marker(
                            markerId: MarkerId('meetingPoint'),
                            position: LatLng(
                              post.meetingPointLat!,
                              post.meetingPointLong!,
                            ),
                          ),
                        },
                        myLocationButtonEnabled: false,
                      ),
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 20.0),

            // 관심수, 조회수 표시
            Row(
              children: [
                Text(
                  'Favorites ${post.favorites} · Views ${post.views}',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20.0),

            // 신고 링크
            CustomTextLink(
              linkText: 'Report this post',
              linkTextStyle: context.textTheme.bodyMedium!.copyWith(
                color: Colors.grey,
                decoration: TextDecoration.underline,
                decorationColor: Colors.grey,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
