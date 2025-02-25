import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/screens/policies_screen.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/wallet.png")),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 15),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/rect.png"),
                              scale: 1)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: Center(
                    child: Text(
                      'My Wallet',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 90, bottom: 10),
              child: CircleAvatar(
                backgroundColor: Colors.black,
                radius: 60,
                backgroundImage: AssetImage('assets/images/profile.jpg'),

              ),
            ),
            Text(
              " ₹ 1,00,000",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600, fontSize: 30),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/gpay.png",
                  width: 60,
                  height: 60,
                ),
                SizedBox(width: size.width * 0.09),
                Image.asset(
                  "assets/images/phonepay.png",
                  width: 35,
                  height: 35,
                )
              ],
            ),
            Container(
              width: size.width*0.4,
              height: size.height*0.05,
              decoration: BoxDecoration(color: Color(0xFF003B8F),
              borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  '+ Add Money',
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
            ),

            Expanded(
              child: DefaultTabController(
                length: 3, // Number of tabs
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8, // Fixed height for Column
                  child: Column(
                    children: [
              
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TabBar(
                          labelColor: Colors.blue,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Colors.blue,
                          indicatorWeight: 3,
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(width: 3.0, color: Colors.blue),
                            insets: EdgeInsets.symmetric(horizontal: 10.0),
                          ),
                          tabs: [
                            Tab(text: "All Transactions",),
                            Tab(text: "Money Added"),
                            Tab(text: "Money Spent"),
                          ],
                        ),
                      ),
              
                      Expanded(
                        child: TabBarView(
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: Colors.green.withOpacity(0.5)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 6,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        // ✅ Green Circular Icon with Arrow
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(Icons.arrow_upward, color: Colors.white),
                                        ),
                                        SizedBox(width: 12),

                                        // ✅ Transaction Details
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Added money via PhonePe",
                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                              ),
                                              SizedBox(height: 3),
                                              Text(
                                                "Mar 15, 2024 10:30",
                                                style: TextStyle(fontSize: 12, color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // ✅ Amount & Status Badge
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "+₹8000",
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.green),
                                            ),
                                            SizedBox(height: 5),
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                "Success",
                                                style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
//////////////////////////////
                                SizedBox(height: size.height * 0.01),
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: Colors.green.withOpacity(0.5)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 6,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        // ✅ Green Circular Icon with Arrow
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.red[900],
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(Icons.arrow_downward, color: Colors.white),
                                        ),
                                        SizedBox(width: 12),

                                        // ✅ Transaction Details
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Tractor booking advance",
                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                              ),
                                              SizedBox(height: 3),
                                              Text(
                                                "Mar 14, 2024 11:30",
                                                style: TextStyle(fontSize: 12, color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // ✅ Amount & Status Badge
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "-₹8000",
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.red[900]),
                                            ),
                                            SizedBox(height: 5),
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                "Success",
                                                style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.01),
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: Colors.green.withOpacity(0.5)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 6,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        // ✅ Green Circular Icon with Arrow
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(Icons.arrow_upward, color: Colors.white),
                                        ),
                                        SizedBox(width: 12),

                                        // ✅ Transaction Details
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Added money via Googlepay",
                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                              ),
                                              SizedBox(height: 3),
                                              Text(
                                                "Mar 16, 2024 12:30",
                                                style: TextStyle(fontSize: 12, color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // ✅ Amount & Status Badge
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "+₹8000",
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.green),
                                            ),
                                            SizedBox(height: 5),
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                "Success",
                                                style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),


                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  Center(child: Text("Money Added Content")),

                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  Center(child: Text("Money Spent Content")),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )



          ],
        ),
      ),
    );
  }
}
