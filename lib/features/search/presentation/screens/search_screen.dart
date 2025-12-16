import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/utils/show_confirm_dialog.dart';
import 'package:clozii/features/search/core/constants/suggested_keywords.dart';
import 'package:clozii/features/search/presentation/providers/search_provider.dart';
import 'package:clozii/features/search/presentation/widgets/search_field.dart';
import 'package:clozii/features/search/presentation/widgets/search_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  // 카테고리 아이콘 리스트
  final List<Map<String, String>> _categoryIcons = [
    {'icon': 'assets/images/icons/desktop.png', 'label': 'Desktop'},
    {'icon': 'assets/images/icons/smartphone.png', 'label': 'Phone'},
    {'icon': 'assets/images/icons/sneakers.png', 'label': 'Shoes'},
    {'icon': 'assets/images/icons/basketball.png', 'label': 'Sports'},
    {'icon': 'assets/images/icons/weight.png', 'label': 'Fitness'},
    {'icon': 'assets/images/icons/sweater.png', 'label': 'Clothing'},
    {'icon': 'assets/images/icons/car.png', 'label': 'Vehicle'},
    {'icon': 'assets/images/icons/sofa.png', 'label': 'Furniture'},
    {'icon': 'assets/images/icons/guitar.png', 'label': 'Music'},
    {'icon': 'assets/images/icons/dog.png', 'label': 'Pet'},
  ];

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

        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(10.0),
          // child: FilterBar(),
          child: SizedBox.shrink(),
        ),
      ),
      body: content,
    );
  }

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

  Widget _buildSearchResults(String searchQuery) {
    // 검색 결과 표시 위젯
    return SearchResult(
      query: searchQuery,
    );
  }

  Widget _buildRecentSearches(List<String> recentSearches) {
    return CustomScrollView(
      slivers: [
        // 상단 여백
        const SliverToBoxAdapter(child: SizedBox(height: 24.0)),

        // 아이콘 그리드
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 0.8,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 6.0,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final category = _categoryIcons[index];
              return GestureDetector(
                onTap: () {
                  debugPrint('tapped ${category['label']}');
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withOpacity(0.1),
                        blurRadius: 10.0,
                        offset: Offset(0, 5.0),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          category['icon']!,
                          width: 24.0,
                          height: 24.0,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          category['label']!,
                          style: context.textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }, childCount: _categoryIcons.length),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 24.0)),

        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20.0,
                  offset: const Offset(0, -5.0),
                ),
              ],
            ),
            child: Column(
              children: [
                // 헤더
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
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

                const Divider(height: 1.0),

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
        ),
      ],
    );
  }

  Widget _buildSearchSuggestions(
      String searchQuery, List<String> recentSearches) {
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
