import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/utils/show_confirm_dialog.dart';
import 'package:clozii/features/search/core/constants/suggested_keywords.dart';
import 'package:clozii/features/search/presentation/widgets/search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreenSimple extends StatefulWidget {
  const SearchScreenSimple({super.key});

  @override
  State<SearchScreenSimple> createState() => _SearchScreenSimpleState();
}

class _SearchScreenSimpleState extends State<SearchScreenSimple> {
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
        shadowColor: Colors.black.withOpacity(0.2), // 앱바 그림자 색상

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
                          setState(() {
                            _recentSearches.clear();
                          });
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
                itemCount: _recentSearches.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.only(
                      left: 16.0,
                      right: 8.0,
                    ),
                    leading: const Icon(CupertinoIcons.clock, size: 18.0),
                    title: Text(_recentSearches[index]),
                    trailing: IconButton(
                      onPressed: () {
                        debugPrint('delete this search record!');
                        setState(() {
                          _recentSearches.removeAt(index);
                        });
                      },
                      icon: const Icon(CupertinoIcons.xmark, size: 18.0),
                    ),
                    onTap: () {
                      debugPrint('tapped ${_recentSearches[index]}');
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
        const SliverToBoxAdapter(child: SizedBox(height: 12.0)),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return ListTile(
              dense: true,
              contentPadding: EdgeInsets.only(left: 16.0, right: 16.0),
              leading: index < recentSearches.length
                  ? Icon(CupertinoIcons.clock, size: 18.0)
                  : Icon(CupertinoIcons.search, size: 18.0),
              title: Text(items[index]),
              trailing: Icon(CupertinoIcons.arrow_up_right, size: 18.0),
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
