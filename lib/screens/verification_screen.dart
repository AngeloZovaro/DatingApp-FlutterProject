import 'package:flutter/material.dart';
import 'package:datingapp/screens/profile_screen.dart';

class VerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const VerificationScreen({super.key, required this.phoneNumber});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  List<String> enteredDigits = [];

  void _onKeyboardTap(String value) {
    setState(() {
      if (value == 'del') {
        if (enteredDigits.isNotEmpty) {
          enteredDigits.removeLast();
        }
      } else if (enteredDigits.length < 4) {
        enteredDigits.add(value);

        if (enteredDigits.length == 4) {
          _validateCode(); // Valida o código ao completar 4 dígitos
        }
      }
    });
  }

  void _validateCode() {
    final code = enteredDigits.join('');
    if (code == '6789') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Código inválido'), backgroundColor: Colors.red),
      );
      setState(() {
        enteredDigits.clear();
      });
    }
  }

  Widget _buildDigitBox(int index) {
    return Container(
      width: 56,
      height: 56,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: enteredDigits.length > index ? const Color(0xFFE94057) : Colors.white,
        border: Border.all(color: const Color(0xFFE94057)),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(
        enteredDigits.length > index ? enteredDigits[index] : '',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: enteredDigits.length > index ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildKeyboardButton(String value, {IconData? icon}) {
    return InkWell(
      onTap: () => _onKeyboardTap(value),
      child: SizedBox(
        height: 60,
        width: 60,
        child: Center(
          child: icon != null
              ? Icon(icon, size: 24)
              : Text(
                  value,
                  style: const TextStyle(fontSize: 22),
                ),
        ),
      ),
    );
  }

  Widget _buildKeyboard() {
    final keys = [
      '1', '2', '3',
      '4', '5', '6',
      '7', '8', '9',
      '', '0', 'del',
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      itemCount: keys.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        final key = keys[index];
        if (key == '') {
          return const SizedBox.shrink();
        } else if (key == 'del') {
          return _buildKeyboardButton(key, icon: Icons.backspace_outlined);
        } else {
          return _buildKeyboardButton(key);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.phoneNumber,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Digite o código de verificação que enviamos para você",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) => _buildDigitBox(index)),
              ),
              const SizedBox(height: 32),
              _buildKeyboard(),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // lógica de reenvio
                },
                child: const Text(
                  "Enviar novamente",
                  style: TextStyle(
                    color: Color(0xFFE94057),
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}