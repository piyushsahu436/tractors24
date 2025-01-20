import 'package:flutter/material.dart';

class CarDetailsPage extends StatelessWidget {
  const CarDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // IconButton(
      //   icon: const Icon(Icons.favorite_border, color: Colors.redAccent),
      //   onPressed: () {},
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: SizedBox(height: size.height*0.37),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Container(
                    height: size.height*0.3,
                    decoration: const BoxDecoration(
                      image: DecorationImage(fit: BoxFit.fill,image: NetworkImage("https://img.freepik.com/premium-photo/yellow-sports-car-is-moving-along-road-sunset-background_1167344-16500.jpg"))
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Padding(
                            padding: EdgeInsets.only(top: 35,right: 15),
                            child: Row(mainAxisAlignment: MainAxisAlignment.end
                            ,children: [
                              Icon(Icons.share),
                              SizedBox(width: 15,),
                              Icon(Icons.favorite_border,color: Colors.redAccent,)
                            ],),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 15,right: 15),
                            child: Row(mainAxisAlignment: MainAxisAlignment.end,children: [
                              Icon(Icons.camera_alt_sharp,color: Colors.redAccent,),
                              Text("2"),
                            ],),
                          ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 225,left: 18,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: const DecorationImage(fit: BoxFit.fill,image: NetworkImage("https://t4.ftcdn.net/jpg/05/37/32/57/360_F_537325726_GtgjRiyc37BLPn9OmisBVVZec9frLaL0.jpg")),
                          border: Border.all(
                            color: Colors.white,
                            width: 2
                          ),
                        ),
                        height: size.height*0.10,
                        width: size.width*0.25,
                      ),
                     SizedBox(width: size.width*0.04,),

                     Container(
                        decoration: BoxDecoration(
                          image: const DecorationImage(fit: BoxFit.fill,image: NetworkImage("https://t4.ftcdn.net/jpg/05/37/32/57/360_F_537325726_GtgjRiyc37BLPn9OmisBVVZec9frLaL0.jpg")),
                          border: Border.all(
                              color: Colors.white,
                              width: 2
                          ),
                        ),
                        height: size.height*0.10,
                        width: size.width*0.25,
                      ),
                    ],
                  ),
                )
              ],
            ),
            // Title and price section
            Padding(
              padding: const EdgeInsets.only(top: 0,left: 15,right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Tata Tiago",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text("Posted on 16 Jan",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                      const Row(children: [
                        Text(
                          '₹ 4.50L',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Divider(indent: 5,height: 25,endIndent: 5,thickness: 3,),
                        Icon(Icons.location_on_outlined,color: Colors.black38,size: 22,),
                        Text(
                          'Indore',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      ]
                    ),
                    const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            side: BorderSide(color: Colors.blue.shade400,
                            width: 1.5),
                            disabledBackgroundColor: Colors.transparent,
                            foregroundColor: Colors.blue[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: const Text('Apply Loan'),
                        ),
                      ],
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(color: Colors.grey.shade400, width: 1.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.symmetric(
                                vertical: BorderSide(color: Colors.grey.shade400, width: 1.0),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.speed, color: Colors.black, size: size.longestSide * 0.035),
                                const SizedBox(height: 5),
                                const Text(
                                  "4,50,000",
                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "kms",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const VerticalDivider(color: Colors.grey, width: 1, thickness: 1),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.symmetric(
                                vertical: BorderSide(color: Colors.grey.shade400, width: 1.0),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.calendar_today, color: Colors.black, size: size.longestSide * 0.035),
                                const SizedBox(height: 5),
                                const Text(
                                  "2022",
                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "Model",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                        VerticalDivider(color: Colors.grey.shade400, width: 1, thickness: 1),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.symmetric(
                                vertical: BorderSide(color: Colors.grey.shade400, width: 1.0),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.person, color: Colors.black, size: size.longestSide * 0.035),
                                const SizedBox(height: 5),
                                const Text(
                                  "First",
                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "Owner",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                        VerticalDivider(color: Colors.grey.shade400, width: 1, thickness: 1),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.symmetric(
                                vertical: BorderSide(color: Colors.grey.shade400, width: 1.0),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.local_gas_station, color: Colors.black, size: size.longestSide * 0.035),
                                const SizedBox(height: 5),
                                const Text(
                                  "Petrol",
                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "Fuel Type",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                        VerticalDivider(color: Colors.grey.shade400, width: 1, thickness: 1),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.symmetric(
                                vertical: BorderSide(color: Colors.grey.shade400, width: 1.0),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.shield_outlined, color: Colors.black, size: size.longestSide * 0.030),
                                const SizedBox(height: 5),
                                const Text(
                                  "Active",
                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "Insurance\nTill 06-01-2026",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey.shade600, fontSize: 9),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Tabs
            const TabBarSection(),

            // Details
            const DetailsSection(),
            SizedBox(height: size.height*0.015,),
            const Padding(
              padding: EdgeInsets.only(left: 18.0,top: 15),
              child: Text("Buyer Guidelines",style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800
              ),),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 18.0,top: 15),
              child: Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                Icon(Icons.keyboard_double_arrow_right_rounded,color: Colors.redAccent),
                SizedBox(width: 14,),
                Text("Ask question to be clear on vehicle details")
              ],),
            ),
            const Padding(
              padding:EdgeInsets.only(left: 18.0,top: 15),
              child: Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                Icon(Icons.keyboard_double_arrow_right_rounded,color: Colors.redAccent),
                SizedBox(width: 14,),
                Text("Be aware of time & place when going for vehicle \n test-drive")
              ],),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 18.0,top: 15),
              child: Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                Icon(Icons.keyboard_double_arrow_right_rounded,color: Colors.redAccent,),
                SizedBox(width: 14,),
                Text("Report suspicious users to us")
              ],),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0,top: 15),
              child:  Row(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image(image: const AssetImage("assets/images/man.png"),height: size.height*0.2,),
                  Image(image: const AssetImage("assets/images/animetractor.png"),height: size.height*0.15,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TabBarSection extends StatelessWidget {
  const TabBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(text: 'Overview'),
              Tab(text: 'Features'),
              Tab(text: 'Specifications'),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class DetailsSection extends StatelessWidget {
  const DetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final details = [
      {'label': 'Year', 'value': '2022'},
      {'label': 'Owners', 'value': '1'},
      {'label': 'Insurance Expiry', 'value': 'Jan 2026'},
      {'label': 'Color', 'value': '-'},
      {'label': 'City', 'value': 'Indore'},
      {'label': 'Posted', 'value': '6 days ago'},
      {'label': 'Register Type', 'value': 'INDIVIDUAL'},
      {'label': 'Engine No.', 'value': '-'},
      {'label': 'Chassis No.', 'value': '-'},
      {'label': 'Fitness Validity', 'value': '-'},
      {'label': 'Permit Validity', 'value': '-'},
      {'label': 'Kms Driven', 'value': '450000'},
      {'label': 'Hypothecation', 'value': '-'},
      {'label': 'Tax Validity', 'value': '-'},
    ];

    return Column(
      children: details.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;

        return Container(
          color: index % 2 == 0 ? Colors.grey[200] : Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item['label']!,
                style: TextStyle(fontSize: 14,fontWeight: FontWeight.w800,color: Colors.grey[600]),
              ),
              Text(
                item['value']!,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
