import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:innoitlabsmachintest/core/utils/responsive.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: responsive.wp(5),
            right: responsive.wp(5),
            bottom: responsive.hp(1),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: responsive.hp(0.5)),
              child: SalomonBottomBar(
                selectedItemColor: HexColor("15995E"),
                unselectedItemColor: HexColor("666666"),
                backgroundColor: Colors.transparent,
                currentIndex: currentIndex,
                onTap: onTap,
                items: [
                  _buildBottomBarItem(responsive, Icons.home, "Home"),
                  _buildBottomBarItem(responsive, Icons.shopping_cart, "Cart"),
                  _buildBottomBarItem(responsive, Icons.favorite, "Favourites"),
                  _buildBottomBarItem(
                      responsive, Icons.account_circle, "Account"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SalomonBottomBarItem _buildBottomBarItem(
      Responsive responsive, IconData icon, String title) {
    return SalomonBottomBarItem(
      icon: Icon(
        icon,
        size: responsive.sp(24),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: responsive.sp(12)),
      ),
    );
  }
}
