import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AboutScreen extends StatefulWidget
{
  @override
  State<AboutScreen> createState() => _AboutScreenState();
}




class _AboutScreenState extends State<AboutScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(

        children: [

          //image
           Container(
            height: 230,
            child: Center(
              child: Image.asset(
                "images/car2.gif",
                width: 260,
              ),
            ),
          ),

          Column(
            children: [

              //company name
              const Text(
                "Quicki Taxi",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              //about you & your company - write some info
              const Text(
                "This app has been developed by Group 32, "
                "This is the world number 1 ride sharing app.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),

              const SizedBox(
                height: 10,
              ),



              const SizedBox(
                height: 40,
              ),

              //close
              ElevatedButton(
                onPressed: ()
                {
                  SystemNavigator.pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ),
                child: const Text(
                  "Close",
                  style: TextStyle(color: Colors.white),
                ),
              ),

            ],
          ),

        ],

      ),
    );
  }
}
