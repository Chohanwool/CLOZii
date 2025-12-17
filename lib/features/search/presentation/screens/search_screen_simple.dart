import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/utils/show_confirm_dialog.dart';
import 'package:clozii/core/widgets/filter_bar.dart';
import 'package:clozii/features/search/core/constants/suggested_keywords.dart';
import 'package:clozii/features/search/presentation/providers/search_provider.dart';
import 'package:clozii/features/search/presentation/widgets/search_result.dart';
import 'package:clozii/features/search/presentation/widgets/search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreenSimple extends ConsumerStatefulWidget {
  const SearchScreenSimple({super.key});

  @override
  ConsumerState<SearchScreenSimple> createState() => _SearchScreenSimpleState();
}

class _SearchScreenSimpleState extends ConsumerState<SearchScreenSimple> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchProvider);

    Widget content = buildContent(searchState);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false, // 자동 뒤로 가기 버튼 제거
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 60.0,
        titleSpacing: 24.0,

        title: SearchField(
          controller: _searchController,
          focusNode: _focusNode,
          onTap: () {
            ref.read(searchProvider.notifier).setHasSubmitted(false);
          },
          onChanged: (value) {
            ref.read(searchProvider.notifier).updateSearchQuery(value);
            ref.read(searchProvider.notifier).setHasSubmitted(false);
          },
          onSubmitted: (value) {
            if (value.isEmpty) return;
            ref.read(searchProvider.notifier).addRecentSearch(value);
            ref.read(searchProvider.notifier).setHasSubmitted(true);
          },
        ),

        elevation: 6.0, // 앱바 그림자 높이
        scrolledUnderElevation: 6.0, // 스크롤 시에도 동일한 elevation 유지
        shadowColor: Colors.black.withOpacity(0.2), // 앱바 그림자 색상

        shape: const RoundedRectangleBorder(
          side: BorderSide(color: AppColors.borderLight),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0),
          ),
        ),

        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(searchState.hasSubmitted ? 60.0 : 10.0),
          child: searchState.hasSubmitted
              ? const FilterBar()
              : const SizedBox.shrink(),
        ),
      ),
      body: content,
    );
  }

  // 화면 콘텐츠 빌드 메서드
  Widget buildContent(SearchState state) {
    if (state.hasSubmitted) {
      return _buildSearchResults(state.searchQuery);
    }

    if (state.searchQuery.isEmpty) {
      return _buildRecentSearches(state.recentSearches);
    }

    return _buildSearchSuggestions(
      state.searchQuery,
      state.recentSearches,
    );
  }

  // 검색 결과 표시 위젯
  Widget _buildSearchResults(String searchQuery) {
    // 검색 결과 표시 위젯
    return SearchResult(
      query: searchQuery,
    );
  }

  // 최근 검색어 표시 위젯
  Widget _buildRecentSearches(List<String> recentSearches) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              // 헤더
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 12.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Searches',
                      style: context.textTheme.labelLarge,
                    ),
                    TextButton(
                      onPressed: () async {
                        final result = await showConfirmDialog(
                          context: context,
                          title: 'Are you sure?',
                          messageBody:
                              'Once cleared, you will no longer be able to restore your search history.',
                          confirmButtonText: 'Clear',
                        );

                        if (result == true) {
                          ref
                              .read(searchProvider.notifier)
                              .clearRecentSearches();
                        }
                      },
                      child: Text(
                        'Clear All',
                        style: context.textTheme.labelLarge?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 리스트
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero, // ListView 기본 패딩 제거
                itemCount: recentSearches.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.only(
                      left: 16.0,
                      right: 8.0,
                    ),
                    leading: const Icon(CupertinoIcons.clock, size: 18.0),
                    title: Text(recentSearches[index]),
                    trailing: IconButton(
                      onPressed: () {
                        ref
                            .read(searchProvider.notifier)
                            .removeRecentSearch(index);
                      },
                      icon: const Icon(CupertinoIcons.xmark, size: 18.0),
                    ),
                    onTap: () {
                      _searchController.text = recentSearches[index];
                      _focusNode.unfocus();
                      ref
                          .read(searchProvider.notifier)
                          .selectRecentSearch(recentSearches[index]);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 검색 제안 표시 위젯
  Widget _buildSearchSuggestions(
    String searchQuery,
    List<String> recentSearches,
  ) {
    final recents = recentSearches
        .where(
          (recentSearch) =>
              recentSearch.toLowerCase().startsWith(searchQuery.toLowerCase()),
        )
        .toList();

    final suggestions = suggestedKeywords
        .where(
          (keyword) =>
              keyword.toLowerCase().startsWith(searchQuery.toLowerCase()) &&
              !recentSearches.contains(keyword),
        )
        .toList();

    final items = [...recents, ...suggestions];

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 12.0)),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return ListTile(
              dense: true,
              contentPadding: const EdgeInsets.only(left: 16.0, right: 16.0),
              leading: index < recents.length
                  ? const Icon(CupertinoIcons.clock, size: 18.0)
                  : const Icon(CupertinoIcons.search, size: 18.0),
              title: Text(items[index]),
              trailing: const Icon(CupertinoIcons.arrow_up_right, size: 18.0),
              onTap: () {
                _searchController.text = items[index];
                _focusNode.unfocus();
                ref
                    .read(searchProvider.notifier)
                    .selectRecentSearch(items[index]);
              },
            );
          }, childCount: items.length),
        ),
      ],
    );
  }
}
