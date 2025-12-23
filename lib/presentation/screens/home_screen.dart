import 'package:clozii/core/data/models/tab_page_config.dart';
import 'package:clozii/core/providers/location_provider.dart';
import 'package:clozii/core/providers/location_service_provider.dart';
import 'package:clozii/core/utils/show_alert_dialog.dart';
import 'package:clozii/core/utils/show_confirm_dialog.dart';
import 'package:flutter/material.dart';

// features
import 'package:clozii/features/post/presentation/widgets/post_list/post_list_app_bar.dart';
import 'package:clozii/features/post/presentation/widgets/post_list/post_list_region_dropdown.dart';
import 'package:clozii/presentation/screens/tabs/chat_tab_screen.dart';
import 'package:clozii/presentation/screens/tabs/map_tab_screen.dart';
import 'package:clozii/presentation/screens/tabs/my_tab_screen.dart';
import 'package:clozii/features/post/presentation/screens/post_list_screen.dart';
import 'package:clozii/features/search/presentation/screens/search_screen.dart';

// presentation
import 'package:clozii/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:clozii/presentation/widgets/chat_tab_app_bar.dart';
import 'package:clozii/presentation/widgets/map_tab_app_bar.dart';
import 'package:clozii/presentation/widgets/my_tab_app_bar.dart';

// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with WidgetsBindingObserver {
  int _currentIndex = 0;
  bool _checkingPermission = true;
  bool _awaitingSettings = false; // 설정 화면으로 보냈는지 표시

  // 각 탭에 해당하는 화면들
  late final List<TabPageConfig> _tabs = [
    TabPageConfig(
      appBar: PostListAppBar(onSearchTap: _navigateToSearchScreen),
      body: const PostListScreen(),
    ),
    const TabPageConfig(
      appBar: MapTabAppBar(),
      body: MapTabScreen(),
    ),
    const TabPageConfig(
      appBar: ChatTabAppBar(),
      body: ChatTabScreen(),
    ),
    const TabPageConfig(
      appBar: MyTabAppBar(),
      body: MyTabScreen(),
    ),
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
  }

  @override
  Widget build(BuildContext context) {
    final activeTab = _tabs[_currentIndex];

    return Stack(
      children: [
        Scaffold(
          appBar: activeTab.appBar,
          body: _checkingPermission ? const Column() : activeTab.body,
          bottomNavigationBar: CustomBottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        if (_currentIndex == 0) const PostListRegionDropdown(),
      ],
    );
  }
}
