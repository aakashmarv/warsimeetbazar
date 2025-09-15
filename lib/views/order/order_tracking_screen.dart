import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  // Dummy order status
  final List<String> orderStages = [
    "Pending",
    "Packed",
    "Out for Delivery",
    "Delivered"
  ];
  int currentStage = 2; // 0-based index (Out for Delivery)

  // Dummy delivery boy location
  final LatLng deliveryBoyLocation = LatLng(28.6139, 77.2090); // Delhi
  final LatLng restaurantLocation = LatLng(28.6270, 77.2190);
  final LatLng userLocation = LatLng(28.6350, 77.2100);

  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Tracking"),
        backgroundColor: Colors.green[700],
      ),
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.02),

          // Order Status Indicator
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(orderStages.length, (index) {
                bool isActive = index <= currentStage;
                return Column(
                  children: [
                    CircleAvatar(
                      radius: screenWidth * 0.04,
                      backgroundColor: isActive ? Colors.green : Colors.grey[300],
                      child: Icon(
                        isActive ? Icons.check : Icons.circle,
                        color: Colors.white,
                        size: screenWidth * 0.05,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      orderStages[index],
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: isActive ? Colors.black : Colors.grey,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),

          SizedBox(height: screenHeight * 0.03),

          // Google Map
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: deliveryBoyLocation,
                zoom: 14,
              ),
              onMapCreated: (controller) => mapController = controller,
              markers: {
                Marker(
                  markerId: const MarkerId('deliveryBoy'),
                  position: deliveryBoyLocation,
                  infoWindow: const InfoWindow(title: 'Delivery Boy'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueGreen),
                ),
                Marker(
                  markerId: const MarkerId('restaurant'),
                  position: restaurantLocation,
                  infoWindow: const InfoWindow(title: 'Restaurant'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed),
                ),
                Marker(
                  markerId: const MarkerId('user'),
                  position: userLocation,
                  infoWindow: const InfoWindow(title: 'Your Location'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueBlue),
                ),
              },
              polylines: {
                Polyline(
                  polylineId: const PolylineId('route'),
                  points: [restaurantLocation, deliveryBoyLocation, userLocation],
                  color: Colors.green,
                  width: 4,
                ),
              },
            ),
          ),

          SizedBox(height: screenHeight * 0.02),

          // Order Summary / Info
          SafeArea(
            top: false, // don't add padding to top
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Estimated Delivery: Today 7:00 PM",
                        style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        "Delivery Boy: John Doe\nContact: +91 9876543210",
                        style: TextStyle(fontSize: screenWidth * 0.035),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
        ],
      ),
    );
  }
}
