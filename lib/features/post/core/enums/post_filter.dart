import 'package:flutter/cupertino.dart';

enum PostFilter {
  all('All', false, null),
  price('Price', true, CupertinoIcons.chevron_down),
  shares('Shares', false, null),
  nearby('Nearby', false, null),
  category('Category', true, CupertinoIcons.arrow_up_right);

  final String displayName;
  final bool hasIcon;
  final IconData? iconData;
  const PostFilter(this.displayName, this.hasIcon, this.iconData);

  // 필터 → 카테고리 변환 (카테고리 필터인 경우)
  // PostCategory? toCategory() {
  // switch (this) {
  //   case PostFilter.all:
  //     return PostCategory.electronics;
  //   case PostFilter.fashion:
  //     return PostCategory.fashion;
  //   default:
  //     return null;
  // }
  // }

  // 필터가 카테고리 필터인지 확인
  // bool get isCategoryFilter => toCategory() != null;
}
