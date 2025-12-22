import 'package:clozii/features/post/core/enums/post_filter.dart';

const List<PostFilter> homePostFilters = [
  PostFilter.all,
  PostFilter.category,
  PostFilter.shares,
  PostFilter.nearby,
  // PostFilter.priceAsc,
  // PostFilter.priceDesc,
  // PostFilter.priceRange,
];

const List<PostFilter> searchPostFilters = [
  PostFilter.all,
  PostFilter.shares,
  PostFilter.nearby,
  PostFilter.priceAsc,
  PostFilter.priceDesc,
  // PostFilter.priceRange,
];
