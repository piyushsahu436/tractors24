// Container(
// height: 200, // Adjust height as needed
// child: Stack(
// children: [
// // Background Image Container
//
// Positioned(
// top: 200,
// child: Container(
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.start,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// "Search Details:",
// style: GoogleFonts.anybody(
// fontSize: 16, fontWeight: FontWeight.w500),
// )
// ],
// ),
// ),
// ),
// ),
// Positioned(
// top: 90,
// left: 16,
// right: 16,
// child: Container(
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(8.0),
// boxShadow: [
// BoxShadow(
// color: Colors.black.withOpacity(0.1), // Soft shadow
// blurRadius: 10,
// spreadRadius: 2,
// offset: const Offset(2, 4), // Slight bottom shadow
// ),
// ],
// ),
// child: const TextField(
// decoration: InputDecoration(
// hintText: 'Name',
// prefixIcon: Icon(Icons.search),
// border: InputBorder.none,
// contentPadding: EdgeInsets.all(16),
// ),
// ),
// ),
// ),
//
// // Location TextField
// Positioned(
// top: 147, // Adjust these values
// left: 16,
// right: 16,
// child: Container(
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(8.0),
// boxShadow: [
// BoxShadow(
// color: Colors.black.withOpacity(0.1), // Soft shadow
// blurRadius: 10,
// spreadRadius: 2,
// offset: const Offset(2, 4), // Slight bottom shadow
// ),
// ],
// ),
// child: const TextField(
// decoration: InputDecoration(
// hintText: 'Location',
// prefixIcon: Icon(Icons.location_on),
// border: InputBorder.none,
// contentPadding: EdgeInsets.all(16),
// ),
// ),
// ),
// ),
// // Second plain container
// ],
// ),
// ),