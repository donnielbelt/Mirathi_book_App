import 'package:flutter/material.dart';
import 'package:mirathi_book_app/views/auth/login.dart';
import 'package:mirathi_book_app/views/home/Navigation.dart';
import 'package:mirathi_book_app/views/subscription/subscription_confirmation.dart';

class SubscriptionPage extends StatefulWidget {
  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  int _selectedPlan = 0;

  final List<Map<String, String>> _plans = [
    {"title": "1 month subscription service for one month", "price": "1500.00 TZS"},
    {"title": "2 months subscription service for three months", "price": "2000.00 TZS"},
    {"title": "3 months subscription service for six months", "price": "2500.00 TZS"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Color(0xFFA24322)),
              onPressed: () {},
            ),
            const SizedBox(height: 10),
            const Text(
              "Subscription",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Color(0xFFA24322),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Subscribe to complete registration",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFA24322),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Choose a subscription plan",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            _buildPlanTile(0, _plans[0]["title"]!, _plans[0]["price"]!),
            _buildPlanTile(1, _plans[1]["title"]!, _plans[1]["price"]!),
            _buildPlanTile(2, _plans[2]["title"]!, _plans[2]["price"]!),
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
                  MaterialPageRoute(
                    builder: (context) => SubscriptionConfirmationPage(
                      selectedPlan: _selectedPlan.toString(),
                      duration: _plans[_selectedPlan]["title"]!,
                      price: _plans[_selectedPlan]["price"]!,
                    ),
                  ),
                );
              },
              child: const Text(
                "SUBSCRIBE",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanTile(int index, String title, String price) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPlan = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.brown.shade50,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Radio(
              value: index,
              groupValue: _selectedPlan,
              activeColor: Color(0xFFA24322),
              onChanged: (int? value) {
                setState(() {
                  _selectedPlan = value!;
                });
              },
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFA24322),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}