import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:tractors24/screens/dealer_dashboard/rto_screen.dart';




class CustomerInquiriesScreen extends StatefulWidget {
  @override
  _CustomerInquiriesScreenState createState() => _CustomerInquiriesScreenState();
}

class _CustomerInquiriesScreenState extends State<CustomerInquiriesScreen> {
  String selectedFilter = "All Enquiries"; // Default selected tab
  final List<String> filters = ["All Enquiries", "Pending", "Respond", "Closed"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 16),
            Center(
              child: Text(
                "Customer Inquiries",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: filters.map((filter) {
                  bool isSelected = selectedFilter == filter;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        filter,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Color(0xFF003DA5) : Color(0xFFB0B0B0),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: 10),

            // Inquiries List
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('inquiries').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  var inquiries = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: inquiries.length,
                    itemBuilder: (context, index) {
                      var inquiry = inquiries[index];
                      var data = inquiry.data() as Map<String, dynamic>;

                      String email = data['email'] ?? "No Email";
                      String mobile = data['mobile'] ?? "No Mobile";
                      String status = data['status'] ?? "Unknown";
                      Timestamp? createdAt = data['createdAt'];
                      String formattedDate = createdAt != null
                          ? DateFormat.yMMMd().add_jm().format(createdAt.toDate())
                          : "Invalid Date";

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Email Row
                                Row(
                                  children: [
                                    Icon(Icons.email, color: Colors.black),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        email,
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                      ),
                                    ),
                                    if (status.toLowerCase() == "pending")
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF003DA5),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          "Pending",
                                          style: TextStyle(color: Colors.white, fontSize: 12),
                                        ),
                                      ),
                                  ],
                                ),

                                SizedBox(height: 8),

                                // Mobile Row
                                Row(
                                  children: [
                                    Icon(Icons.phone, color: Colors.black),
                                    SizedBox(width: 8),
                                    Text(mobile),
                                  ],
                                ),

                                SizedBox(height: 8),

                                // Timestamp Row
                                Row(
                                  children: [
                                    Icon(Icons.access_time, color: Colors.black),
                                    SizedBox(width: 8),
                                    Text(formattedDate),
                                  ],
                                ),

                                SizedBox(height: 16),

                                // Respond Button
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Implement Respond Action
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF003DA5),
                                      padding: EdgeInsets.symmetric(vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      "Respond",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}