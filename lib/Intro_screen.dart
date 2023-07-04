import 'package:devgold/register_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  
  late PageController _pageController;
  bool isLastPage = false;
  
  @override
  void initState(){
    super.initState();
    _pageController = PageController(initialPage: 0);
  }
  
  @override
  void dispose(){
    super.dispose();
    _pageController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              onPageChanged: (index){
                setState(() {
                  isLastPage = index == 2;
                });
              },
              itemCount: picture.length,
              controller: _pageController,
                itemBuilder: (context, index) => BoardScreen(
                  image: picture[index].image,
                )),

            Positioned(
              bottom: 30,
              right: 20,
              child: isLastPage ?
              TextButton(onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showHome', true);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Register()));
              },
                  child: Text('Get Started', style: TextStyle(
                    color: Colors.black,
                      fontWeight: FontWeight.bold, fontSize: 20),))
             : IconButton(
                onPressed: (){
                  _pageController.nextPage(
                      duration: Duration(microseconds: 500),
                      curve: Curves.ease);
                },
                icon: Icon(Icons.arrow_forward_ios_outlined),
              ),
            ),


          ],
        ),
      ),
    );
  }
}

class Onboard {
  final String image;
  Onboard({ required this.image});
}

final List<Onboard> picture = [
  Onboard(image: 'assets/1.jpeg'),
  Onboard(image: 'assets/2.jpeg'),
  Onboard(image: 'assets/3.jpeg')
];
class BoardScreen extends StatelessWidget {
  const BoardScreen({super.key, required this.image});

  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.fill
        )
      ),
    );
  }
}