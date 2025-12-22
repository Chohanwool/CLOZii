import 'package:clozii/core/providers/location_provider.dart';
import 'package:clozii/core/providers/location_service_provider.dart';
import 'package:clozii/core/utils/show_alert_dialog.dart';
import 'package:clozii/core/utils/show_confirm_dialog.dart';
import 'package:clozii/features/search/presentation/screens/search_screen_simple.dart';
import 'package:clozii/features/search/presentation/providers/home/home_state_provider.dart';
import 'package:flutter/material.dart';

// core
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/widgets/filter_bar.dart';
import 'package:clozii/features/post/core/constants/post_filter_sets.dart';

// features
import 'package:clozii/presentation/screens/tabs/chat_tab_screen.dart';
import 'package:clozii/presentation/screens/tabs/map_tab_screen.dart';
import 'package:clozii/presentation/screens/tabs/my_tab_screen.dart';
import 'package:clozii/features/post/presentation/screens/post_list_screen.dart';
import 'package:clozii/features/search/presentation/screens/search_screen.dart';

// presentation
import 'package:clozii/presentation/widgets/custom_bottom_navigation_bar.dart';

// packages
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with WidgetsBindingObserver {
  int _currentIndex = 0;
  String _selectedRegion = 'Sta.Rosa';
  bool _isDropdownOpen = false;
  bool _checkingPermission = true;
  bool _awaitingSettings = false; // 설정 화면으로 보냈는지 표시

  // 각 탭에 해당하는 화면들
  final List<Widget> _screens = [
    const PostListScreen(),
    const MapTabScreen(),
    const ChatTabScreen(),
    const MyTabScreen(),
  ];

  // 지역 목록
  final List<String> _regions = [
    'Sta.Rosa',
    'Calamba',
    'Cabuyao',
    'Tagaytay',
    'Makati',
    'Alabang',
    'Binan',
    'Quezon City',
    'Mandaluyong',
    'Parañaque',
    'Pasay',
    'Pasig',
    'San Juan',
    'Taguig',
    'Valenzuela',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeLocation();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // 앱이 다시 활성화될 때 권한 재확인
    if (state == AppLifecycleState.resumed && _awaitingSettings) {
      _awaitingSettings = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _initializeLocation();
      });
    }
  }

  Future<void> _initializeLocation() async {
    // 위치 초기화 로직 추가 (예: 위치 권한 요청 및 현재 위치 가져오기)
    final locationState = ref.read(locationProvider);

    // 이미 위치가 있으면 스킵
    if (locationState.position != null) return;

    // 위치 가져오기
    await ref.read(locationProvider.notifier).fetchCurrentLocation();

    final updatedState = ref.read(locationProvider);

    if (updatedState.position != null) {
      debugPrint('✅ Location obtained: '
          'Lat: ${updatedState.position!.latitude}, '
          'Lng: ${updatedState.position!.longitude}');

      setState(() {
        _checkingPermission = false;
      });
      return;
    }

    // 권한 거부 시 처리
    if (updatedState.position == null && mounted) {
      final result = await showConfirmDialog(
        context: context,
        title: 'Location Access Denied',
        messageBody: 'Please allow location access to view nearby posts.',
        confirmButtonText: 'Go to Settings',
        cancelButtonText: 'Later',
      );

      if (result == true) {
        debugPrint('Navigating to app settings for location permission...');
        // 설정 화면으로 이동
        _awaitingSettings = true;
        await ref.read(locationServiceProvider).openAppSettings();
      } else {
        debugPrint('User chose to allow location access later.');
        setState(() {
          _checkingPermission = false;
        });
        showAlertDialog(
          context,
          'Location access was not granted, so nearby posts are unavailable.',
        );
      }
    }
  }

  void _navigateToSearchScreen() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const SearchScreen()));
    // ).push(MaterialPageRoute(builder: (context) => const SearchScreenSimple()));
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            toolbarHeight: 60.0,
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

            actionsPadding: const EdgeInsets.only(right: 16.0),
            actions: [
              IconButton(
                onPressed: _navigateToSearchScreen,
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

            bottom: _currentIndex == 0
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(60.0),
                    child: FilterBar(
                      filters: homePostFilters,
                      selectedFilter: homeState.selectedFilter,
                      onFilterSelected: (filter) {
                        ref
                            .read(homeProvider.notifier)
                            .updateSelectedFilter(filter);
                      },
                    ),
                  )
                : null,
          ),
          body: _checkingPermission ? const Column() : _screens[_currentIndex],
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
