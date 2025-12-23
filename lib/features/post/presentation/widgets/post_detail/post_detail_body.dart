// core
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/utils/show_uploaded_time.dart';
import 'package:clozii/core/widgets/card_container.dart';
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 사용자 정보
          CardContainer(
            topLeftRadius: 0,
            topRightRadius: 0,
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.backgroundSecondary,
                    ),
                    child:
                        const Icon(Icons.person, size: 24, color: Colors.grey),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Kiko Junior', style: context.textTheme.titleSmall),
                      Text(
                        'Sta. Rosa, Laguna',
                        style: context.textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(
                    CupertinoIcons.chevron_right,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),

          // 게시글 정보
          CardContainer(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 제목
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 나눔 태그
                    if (post.price == 0)
                      Container(
                        margin: const EdgeInsets.only(top: 6.0),
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: context.colors.primary,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          'Share',
                          style: context.textTheme.labelLarge!.copyWith(
                            color: context.colors.onPrimary,
                          ),
                        ),
                      ),

                    // 나눔 태그 뒤 여백
                    if (post.price == 0) const SizedBox(width: 10.0),

                    // 제목
                    Expanded(
                      child: Text(
                        post.title,
                        style: context.textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // 카테고리
                //   - 카테고리 탭 시, 관련된 상품들만 필터링 된 페이지로 이동
                Row(
                  children: [
                    // 카테고리 아이콘
                    const Icon(
                      CupertinoIcons.square_list,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 10.0),

                    // 카테고리 링크
                    CustomTextLink(
                      linkText: post.category.displayName,
                      linkTextStyle: context.textTheme.bodyLarge!.copyWith(
                        color: AppColors.textSecondary,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.textSecondary,
                      ),
                      onTap: () {},
                    ),
                  ],
                ),

                // 업로드 시간
                Row(
                  children: [
                    // 업로드 시간 아이콘
                    const Icon(
                      CupertinoIcons.time,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 10.0),

                    // 업로드 시간 텍스트
                    Text(
                      '${showUploadedTime(post.createdAt ?? DateTime.now())} ago',
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // 게시글 컨테이너
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 24.0,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    // border: Border.all(
                    //   color: context.colors.onSecondaryContainer,
                    // ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),

                  // 게시글 내용
                  child: Text(post.content, style: context.textTheme.bodyLarge),
                ),

                const SizedBox(height: 20.0),

                // 즐겨찾기 수 / 조회수 / 채팅 수
                Row(
                  children: [
                    // TODO: 채팅 수 표시
                    Text(
                      'Likes ${post.favorites}   ·   Views ${post.views}   ·   Chats 0',
                      style: context.textTheme.bodyMedium,
                    ),
                  ],
                ),

                const SizedBox(height: 10.0),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // 거래 희망 장소 카드
          if (post.meetingLocation != null)
            CardContainer(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // 거래희망장소 아이콘
                          const Icon(
                            CupertinoIcons.map_pin_ellipse,
                            size: 16,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 4.0),

                          // 거래희망장소 텍스트
                          Text(
                            'Meeting Point',
                            style: context.textTheme.bodyLarge!.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          // 거래희망장소 링크
                          CustomTextLink(
                            linkText: post.meetingLocation!.detailAddress,
                            onTap: () {},
                          ),
                          const SizedBox(width: 10.0),

                          // 거래희망장소 링크 뒤 아이콘 ( > )
                          const Icon(CupertinoIcons.right_chevron, size: 16.0),
                        ],
                      ),
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
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: AppColors.border),
                      ),

                      // 구글 맵스
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            post.meetingLocation!.latitude,
                            post.meetingLocation!.longitude,
                          ),
                          zoom: 17.0,
                        ),
                        markers: {
                          Marker(
                            markerId: const MarkerId('meetingPoint'),
                            position: LatLng(
                              post.meetingLocation!.latitude,
                              post.meetingLocation!.longitude,
                            ),
                          ),
                        },

                        // 내 위치 버튼 비활성화
                        myLocationButtonEnabled: false,
                        // 줌 제스처 비활성화
                        zoomGesturesEnabled: false,
                        // 스크롤 제스처 비활성화
                        scrollGesturesEnabled: false,
                        // 회전 제스처 비활성화
                        rotateGesturesEnabled: false,
                        // 기울임 제스처 비활성화
                        tiltGesturesEnabled: false,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20.0),

                  // 신고 링크 링크
                  CustomTextLink(
                    linkText: 'Report this post',
                    linkTextStyle: context.textTheme.bodyMedium!.copyWith(
                      color: AppColors.textSecondary,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.textSecondary,
                    ),
                    onTap: () {},
                  ),

                  // 페이지 하단 여백 - 없으면 네비게이션 바 때문에 다른 UI 가 가려질 수 있음
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
