import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  final List<Map<String, String>> users = [
    {
      'name': 'Peter Parker',
      'age': '23',
      'profession': 'Desenvolvedor',
      'image': 'lib/assets/users/user_1.jpg'
    },
    {
      'name': 'Camila Alves',
      'age': '22',
      'profession': 'Modelo',
      'image': 'lib/assets/users/user_2.jpg'
    },
    {
      'name': 'Tiago Pinheiro',
      'age': '29',
      'profession': 'Designer',
      'image': 'lib/assets/users/user_3.jpg'
    },
    {
      'name': 'Larissa Silva',
      'age': '26',
      'profession': 'Fotografa',
      'image': 'lib/assets/users/user_4.jpg'
    },
  ];

  int _currentIndex = 0;
  Offset _position = Offset.zero;
  double _rotation = 0.0;

  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _controller.addListener(() {
      setState(() {
        _position = _animation.value;
      });
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _resetPosition();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _resetPosition() {
    setState(() {
      _position = Offset.zero;
      _rotation = 0;
      if (_currentIndex < users.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _position += details.delta;
      _rotation = 0.002 * _position.dx;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    final threshold = screenWidth * 0.3;

    if (_position.dx > threshold) {
      _triggerSwipe(direction: 'right');
    } else if (_position.dx < -threshold) {
      _triggerSwipe(direction: 'left');
    } else {
      setState(() {
        _position = Offset.zero;
        _rotation = 0;
      });
    }
  }

  void _triggerSwipe({required String direction}) {
    final size = MediaQuery.of(context).size;
    Offset endOffset;

    switch (direction) {
      case 'left':
        endOffset = Offset(-size.width, 0);
        break;
      case 'right':
        endOffset = Offset(size.width, 0);
        break;
      case 'up':
        endOffset = Offset(0, -size.height);
        break;
      default:
        endOffset = Offset.zero;
    }

    _animation = Tween<Offset>(
      begin: _position,
      end: endOffset,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward(from: 0);
  }

  Widget _buildCard(Map<String, String> user) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.6,
      margin: const EdgeInsets.only(top: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(user['image']!),
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
              children: [
                Text("${user['name']}, ${user['age']}",
                    style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(user['profession']!, style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color, VoidCallback onPressed, {double size = 48}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: size * 0.5),
      ),
    );
  }

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

            // Card Stack
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  for (int i = users.length - 1; i >= _currentIndex; i--)
                    if (i == _currentIndex)
                      GestureDetector(
                        onPanUpdate: _onPanUpdate,
                        onPanEnd: _onPanEnd,
                        child: Transform.translate(
                          offset: _position,
                          child: Transform.rotate(
                            angle: _rotation,
                            child: _buildCard(users[i]),
                          ),
                        ),
                      )
                    else
                      _buildCard(users[i]),
                ],
              ),
            ),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(Icons.clear, Colors.orange, () => _triggerSwipe(direction: 'left')),
                  _buildActionButton(Icons.favorite, Colors.pink, () => _triggerSwipe(direction: 'up'), size: 64),
                  _buildActionButton(Icons.star, Colors.purple, () => _triggerSwipe(direction: 'right')),
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
}