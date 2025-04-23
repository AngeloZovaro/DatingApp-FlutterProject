import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.arrow_back_ios, size: 20),
                  Column(
                    children: const [
                      Text("Discover", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text("Chicago, IL", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const Icon(Icons.tune, size: 20),
                ],
              ),
            ),

            // Card Stack Placeholder
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Back Card
                  Positioned(
                    top: 40,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),

                  // Front Card
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: const DecorationImage(
                        image: AssetImage('lib/assets/user_1.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Jessica Parker, 23", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                              SizedBox(height: 4),
                              Text("Professional model", style: TextStyle(color: Colors.white70)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Distance chip
                  Positioned(
                    top: 24,
                    left: 32,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text("1 km", style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                  ),
                ],
              ),
            ),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(Icons.clear, Colors.orange),
                  _buildActionButton(Icons.favorite, Colors.pink, size: 64),
                  _buildActionButton(Icons.star, Colors.purple),
                ],
              ),
            ),

            // Bottom Nav
            Container(
              height: 56,
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Icon(Icons.local_fire_department, color: Colors.redAccent),
                  Icon(Icons.favorite, color: Colors.pink),
                  Icon(Icons.chat_bubble_outline, color: Colors.grey),
                  Icon(Icons.person_outline, color: Colors.grey),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color, {double size = 48}) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: size * 0.5),
    );
  }
}