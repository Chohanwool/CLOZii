import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/features/search/core/constants/suggested_keywords.dart';
import 'package:clozii/features/search/presentation/widgets/search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';

  final List<String> _recentSearches = [
    'Iphone',
    'Jordan',
    'Laptop',
    'Tablets',
    'Nike',
    'Adidas',
    'PlayStation 5',
    'Xbox Series X',
    'Nintendo Switch',
    'Starbucks Tumbler',
    'Sneakers',
    'Kimchi',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 검색 필드에 아무 것도 입력하지 않은 경우, 최근 검색어 목록을 표시
    // 검색 필드에 검색어를 입력한 경우, 검색 결과를 표시
    Widget content = _searchQuery.isEmpty
        ? _buildRecentSearches()
        : _buildSearchResults();

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
            setState(() {
              _searchQuery = value;
            });
          },
        ),

        elevation: 6.0, // 앱바 그림자 높이
        scrolledUnderElevation: 6.0, // 스크롤 시에도 동일한 elevation 유지
        shadowColor: Colors.black.withOpacity(0.4), // 앱바 그림자 색상

        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.borderLight),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0),
          ),
        ),

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10.0),
          // child: FilterBar(),
          child: const SizedBox.shrink(),
        ),
      ),
      body: content,
    );
  }

  Widget _buildRecentSearches() {
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
              childAspectRatio: 1.0,
              mainAxisSpacing: 12.0,
              crossAxisSpacing: 12.0,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
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
                child: Center(child: Icon(CupertinoIcons.car, size: 24.0)),
              );
            }, childCount: 10),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 24.0)),

        // Recent Searches 헤더
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Searches', style: context.textTheme.labelLarge),
                TextButton(
                  onPressed: () {
                    debugPrint('Clear All! - show confirmation dialog');
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
        ),

        // Recent Searches 리스트
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return ListTile(
              dense: true,
              contentPadding: EdgeInsets.only(left: 16.0, right: 8.0),
              leading: Icon(CupertinoIcons.clock, size: 18.0),
              title: Text(_recentSearches[index]),
              trailing: IconButton(
                onPressed: () {
                  debugPrint('delete this search record!');
                  setState(() {
                    _recentSearches.removeAt(index);
                  });
                },
                icon: Icon(CupertinoIcons.xmark, size: 18.0),
              ),
              onTap: () {
                debugPrint('tapped ${_recentSearches[index]}');
              },
            );
          }, childCount: _recentSearches.length),
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    final recentSearches = _recentSearches
        .where(
          (recentSearch) =>
              recentSearch.toLowerCase().startsWith(_searchQuery.toLowerCase()),
        )
        .toList();

    final suggestions = suggestedKeywords
        .where(
          (keyword) =>
              keyword.toLowerCase().startsWith(_searchQuery.toLowerCase()) &&
              !recentSearches.contains(keyword),
        )
        .toList();

    final items = [...recentSearches, ...suggestions];

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return ListTile(
              dense: true,
              contentPadding: EdgeInsets.only(left: 16.0, right: 8.0),
              leading: index < recentSearches.length
                  ? Icon(CupertinoIcons.clock, size: 18.0)
                  : Icon(CupertinoIcons.search, size: 18.0),
              title: Text(items[index]),
              onTap: () {
                debugPrint('tapped ${items[index]}');
              },
            );
          }, childCount: items.length),
        ),
      ],
    );
  }
}
