import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/helper/network_info.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/view/screens/addProduct/add_product_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/chat/inbox_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/home/home_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/order/order_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/profile/profile_view_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageController _pageController = PageController();
  int _pageIndex = 0;
  List<Widget> _screens;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _screens = [
      HomeScreen(callback: () {
        setState(() {
          _setPage(1);
        });
      }),
      OrderScreen(),
    ];

    NetworkInfo.checkConnectivity(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: ColorResources.HINT_TEXT_COLOR,
          showUnselectedLabels: true,
          currentIndex: _pageIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            _barItem(Icons.home, getTranslated('home', context), 0),
            _barItem(Icons.shopping_bag, getTranslated('my_order', context), 1),
            _barItem(Icons.control_point, getTranslated('add_product', context), 2),
            _barItem(Icons.message, getTranslated('message', context), 3),
            _barItem(Icons.account_box_sharp, getTranslated('profile', context), 4),
          ],
          onTap: (int index) {
            if (index == 2) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => AddProductScreen()));
            } else if (index == 3) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => InboxScreen()));
            } else if (index == 4) {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (con) => ProfileScreenView()
                  // builder: (con) => MenuBottomSheet()
                  );
            } else {
              setState(() {
                _setPage(index);
              });
            }
          },
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[index];
          },
        ),
      ),
    );
  }

  BottomNavigationBarItem _barItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(icon,
              color: index == _pageIndex
                  ? Theme.of(context).primaryColor
                  : ColorResources.HINT_TEXT_COLOR,
              size: 25),
        ],
      ),
      label: label,
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}
