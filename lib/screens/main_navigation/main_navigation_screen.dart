import 'package:flutter/material.dart';
import 'package:assignment_btf/constant/app_colors.dart';
import 'package:assignment_btf/screens/tasks/tasks_screen.dart';
import 'package:assignment_btf/screens/news/news_screen.dart';
import 'package:assignment_btf/screens/profile/profile_screen.dart';
import 'package:get/get.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final RxInt _currentIndex = 0.obs;

  final List<Widget> _screens = [
    const TasksScreen(),
    const NewsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Obx(
        () => IndexedStack(index: _currentIndex.value, children: _screens),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color:
                    (isDark
                            ? AppColors.instance.dark900
                            : AppColors.instance.dark500)
                        .withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex.value,
            onTap: (index) => _currentIndex.value = index,
            type: BottomNavigationBarType.fixed,
            backgroundColor: isDark
                ? AppColors.instance.dark800
                : AppColors.instance.white50,
            selectedItemColor: AppColors.instance.primary,
            unselectedItemColor: isDark
                ? AppColors.instance.dark300
                : AppColors.instance.dark200,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.task_alt_outlined),
                activeIcon: Icon(Icons.task_alt),
                label: 'Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.article_outlined),
                activeIcon: Icon(Icons.article),
                label: 'News',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
