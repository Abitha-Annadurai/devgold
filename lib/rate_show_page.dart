import 'package:flutter/material.dart';

class RatePage extends StatefulWidget {
  const RatePage({Key? key}) : super(key: key);

  @override
  State<RatePage> createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  var state = ['Mumbai', 'Hydrabad', 'Bangalore', 'Mysoor', 'Delhi', 'Nellore', 'Vellore', 'Gujarat',
    'Kerela'];
  var previous = ['11.4%', 'Yesterday: 60300', 'Yesterday: 61000', 'Yesterday: 58900',
    'Yesterday: 62000', 'Yesterday: 58000', 'Yesterday: 58900', 'Yesterday: 62000', 'Yesterday: 58000'];
  var price = ['₹ 59700', '₹ 60000', '₹ 60200', '₹ 59700', '₹ 59700', '₹ 60000', '₹ 597000', '₹ 59700','₹ 60200', ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 23, right: 23, top: 23),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFDD835),  Colors.white,  Colors.white, Colors.white,],
          begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 60,
                        width: 110,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/logo.png'),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      CircleAvatar(radius: 30,)
                    ],
                  ),
                  Center(
                    child: Column(
                      children: [
                        Text('Latest Price in Chennai', style: TextStyle(fontSize: 15)),
                        Text('₹ 45454.50', style: TextStyle(fontSize: 39, fontWeight: FontWeight.bold)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_upward_outlined, color: Colors.green),
                            Text('11.4%', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,
                                color: Colors.green))
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor:  Color(0xFFFDD835),
                            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                            shape: StadiumBorder(),
                          ),
                          child: Text("Buy", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(itemBuilder: (BuildContext, index) {
                return Column(
                  children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(state[index], style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(price[index], style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text(previous[index], style: TextStyle(color: Colors.grey),),
                    ],
                  ),
                    Divider()
                  ],
                );
              },
                itemCount: state.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
