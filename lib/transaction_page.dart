import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Intro_screen.dart';

class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {

  List date = ['20.06.2023', '18.05.2023', '10.04.2023', '5.03.2023', '12.02.2023', '20.06.2023', '18.05.2023', '10.04.2023'];
  List price = ['₹ 70/gram', '₹ 97/gram', '₹ 70/gram', '₹ 90/gram', '₹ 50/gram', '₹ 70/gram', '₹ 97/gram', '₹ 70/gram'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 10,),
          Container(
            color: Color(0xFFFDD835),
            height: 160,
          child:Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: 110,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/logo.png'),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor:  Colors.white,
                             padding: EdgeInsets.only(left: 20,right: 20),
                              shape: StadiumBorder(),
                            ),
                            child: Text("Filter", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                          )

                        ],
                      ),
                      Column(
                        children: [
                          CircleAvatar(radius: 27,),
                          IconButton(onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            prefs.setBool("isLoggedIn", false);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                            IntroScreen()));
                          }, icon: Icon(Icons.logout, size: 16,))
                        ],
                      )

                    ],
                  ),
                ],
              ),
            ),

          ),
          Expanded(
            child: ListView.builder(itemBuilder: (BuildContext, index) {
              return ListTile(
                leading: Icon(Icons.shopping_cart, size: 40,),
                title: Text('Purchased Gold'),
                subtitle: Text(date[index]),
                trailing: Text(price[index], style: TextStyle(fontWeight: FontWeight.bold),),
              );
            },
              itemCount: date.length,
            ),
          ),
        ],
      ),
    );
  }
}
