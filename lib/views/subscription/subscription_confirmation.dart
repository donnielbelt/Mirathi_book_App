import 'package:flutter/material.dart';
import 'package:mirathi_book_app/views/auth/login.dart';

class SubscriptionConfirmationPage extends StatelessWidget {
  final String selectedPlan;
  final String price;
  final String duration;

  const SubscriptionConfirmationPage({
    required this.selectedPlan,
    required this.price,
    required this.duration,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Payment Information"),
        backgroundColor: Color(0xFFA24322),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Subscription Plan Selected:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              duration,
              style: const TextStyle(fontSize: 16, color: Color(0xFFA24322)),
            ),
            const SizedBox(height: 10),
            Text(
              "Price: $price",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFA24322)),
            ),
            const SizedBox(height: 20),
            const Text(
              "Choose Payment Method:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildPaymentOption("M-Pesa", "Dial *150*00# and follow instructions"),
            _buildPaymentOption("Tigo Pesa", "Dial *150*01# and follow instructions"),
            _buildPaymentOption("Airtel Money", "Dial *150*60# and follow instructions"),
            _buildPaymentOption("Halopesa", "Dial *150*88# and follow instructions"),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFA24322),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Subscription successful")),
                );

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: const Text(
                "DONE",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String method, String instruction) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(method, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(instruction),
        leading: Icon(Icons.payment, color: Color(0xFFA24322)),
      ),
    );
  }
}