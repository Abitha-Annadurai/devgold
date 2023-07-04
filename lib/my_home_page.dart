import 'package:devgold/rate_show_page.dart';
import 'package:devgold/transaction_page.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final pageController = PageController(initialPage: 0);
  int currentSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: 2,
        controller: pageController,
        itemBuilder: (BuildContext context, index) {
          return _getPagesAtIndex(index);
        },
        onPageChanged: (int index) {
          setState(() {
            currentSelected = index;
          });
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      currentIndex: currentSelected,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: 20,),
          label: 'Home',),
        BottomNavigationBarItem(
          icon: Icon(Icons.wallet, size: 20,),
          label: 'Transaction',),
      ],
      onTap: (int index) {
        setState(() {
          currentSelected = index;
          pageController.animateToPage(
            currentSelected,
            curve: Curves.bounceInOut,
            duration: const Duration(milliseconds: 500),
          );
        });
      },
    );
  }

  Widget _getPagesAtIndex(index) {
    switch (index) {
      case 0:
        return RatePage();
      case 1:
        return Transaction();
      default:
        return const CircularProgressIndicator();
    }
  }

}
