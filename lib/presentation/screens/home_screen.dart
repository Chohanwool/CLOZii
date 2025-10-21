// features
import 'package:clozii/features/home/presentation/screens/tabs/chat_tab_screen.dart';
import 'package:clozii/features/home/presentation/screens/tabs/map_tab_screen.dart';
import 'package:clozii/features/home/presentation/screens/tabs/my_tab_screen.dart';

import 'package:clozii/features/post/presentation/screens/post_list_screen.dart';
import 'package:clozii/presentation/widgets/custom_bottom_navigation_bar.dart';

// packages
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  String _selectedRegion = '서울특별시';
  bool _isDropdownOpen = false;

  // 각 탭에 해당하는 화면들
  final List<Widget> _screens = [
    const PostListScreen(),
    const MapTabScreen(),
    const ChatTabScreen(),
    const MyTabScreen(),
  ];

  // 지역 목록
  final List<String> _regions = [
    '서울특별시',
    '부산광역시',
    '대구광역시',
    '인천광역시',
    '광주광역시',
    '대전광역시',
    '울산광역시',
    '세종특별자치시',
    '경기도',
    '강원도',
    '충청북도',
    '충청남도',
    '전라북도',
    '전라남도',
    '경상북도',
    '경상남도',
    '제주특별자치도',
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            titleSpacing: 24.0,
            title: GestureDetector(
              onTap: () {
                setState(() {
                  _isDropdownOpen = !_isDropdownOpen;
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_selectedRegion),
                  const SizedBox(width: 8),
                  Icon(
                    _isDropdownOpen
                        ? CupertinoIcons.chevron_up
                        : CupertinoIcons.chevron_down,
                    size: 28,
                  ),
                ],
              ),
            ),
            centerTitle: false,
            actionsPadding: const EdgeInsets.only(right: 16.0),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
                iconSize: 28,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.bell),
                iconSize: 28,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.heart),
                iconSize: 28,
              ),
            ],
          ),
          body: _screens[_currentIndex],
          bottomNavigationBar: CustomBottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        // 전체 화면 오버레이 (앱바와 바텀네비게이션바 포함)
        if (_isDropdownOpen)
          GestureDetector(
            onTap: () {
              setState(() {
                _isDropdownOpen = false;
              });
            },
            child: Container(
              color: Colors.black.withOpacity(0.3),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        // 드롭다운 메뉴
        if (_isDropdownOpen)
          Positioned(
            top: kToolbarHeight + MediaQuery.of(context).padding.top,
            left: 24,
            child: Container(
              height: 200, // 드롭다운 최대 높이 제한
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: _regions.map((region) {
                    final isSelected = region == _selectedRegion;
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        setState(() {
                          _selectedRegion = region;
                          _isDropdownOpen = false;
                        });
                      },
                      child: Container(
                        width: 150,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(context).primaryColor.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                region,
                                style: TextStyle(
                                  fontSize: isSelected ? 16 : 14,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: isSelected
                                      ? Theme.of(context).primaryColor
                                      : Colors.black,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                CupertinoIcons.checkmark_circle_fill,
                                color: Theme.of(context).primaryColor,
                                size: 16,
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
