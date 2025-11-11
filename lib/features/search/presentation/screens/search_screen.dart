import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/widgets/filter_bar.dart';
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
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 검색 필드에 아무 것도 입력하지 않은 경우
    Widget content = _searchQuery.isEmpty
        ? _buildRecentSearches()
        : _buildSearchResults();

    return Scaffold(
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
          preferredSize: const Size.fromHeight(60.0),
          child: FilterBar(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [const SizedBox(height: 12.0), content]),
      ),
    );
  }

  Widget _buildRecentSearches() {
    return Column(
      children: [
        Padding(
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
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _recentSearches.length,
          itemBuilder: (context, index) {
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
          },
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

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
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
      },
    );
  }
}
