import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/utils/show_confirm_dialog.dart';
import 'package:clozii/features/search/core/constants/suggested_keywords.dart';
import 'package:clozii/features/search/presentation/providers/search_provider.dart';
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchProvider);

    // 검색 필드에 아무 것도 입력하지 않은 경우, 최근 검색어 목록을 표시
    // 검색 필드에 검색어를 입력한 경우, 검색 결과를 표시
    Widget content = searchState.searchQuery.isEmpty
        ? _buildRecentSearches(searchState.recentSearches)
        : _buildSearchResults(
            searchState.searchQuery,
            searchState.recentSearches,
          );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false, // 자동 뒤로 가기 버튼 제거
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 60.0,
        titleSpacing: 24.0,

        title: SearchField(
          controller: _searchController,
          onChanged: (value) {
            ref.read(searchProvider.notifier).updateSearchQuery(value);
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

        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(10.0),
          // child: FilterBar(),
          child: SizedBox.shrink(),
        ),
      ),
      body: content,
    );
  }

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
                        debugPrint('delete this search record!');
                        ref
                            .read(searchProvider.notifier)
                            .removeRecentSearch(index);
                      },
                      icon: const Icon(CupertinoIcons.xmark, size: 18.0),
                    ),
                    onTap: () {
                      ref
                          .read(searchProvider.notifier)
                          .addRecentSearch(recentSearches[index]);
                      debugPrint('tapped ${recentSearches[index]}');
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

  Widget _buildSearchResults(String searchQuery, List<String> recentSearches) {
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
                ref.read(searchProvider.notifier).addRecentSearch(items[index]);
                debugPrint('tapped ${items[index]}');
              },
            );
          }, childCount: items.length),
        ),
      ],
    );
  }
}
