import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController(text: "Cauã");
  final TextEditingController _lastNameController = TextEditingController(text: "Moreto");

  DateTime? _selectedDate;

  final List<String> _interests = [
    'Música',
    'Viagens',
    'Esportes',
    'Filmes',
    'Leitura',
    'Video game',
    'Tecnologia',
    'Pets',
    'Arte',
    'Culinária'
  ];
  List<String> _selectedInterests = [];

  final List<String> _orientations = [
    'Heterossexual',
    'Homossexual',
    'Bissexual',
    'Pansexual',
    'Assexual',
  ];
  String? _selectedOrientation;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale("pt", "BR"),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              const Text(
                "Seu perfil",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('lib/assets/profile.jpg'),
                  ),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(0xFFE94057),
                    child: Icon(Icons.camera_alt, color: Colors.white, size: 18),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: "Nome",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: "Sobrenome",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.cake, color: Color(0xFFE94057)),
                      const SizedBox(width: 8),
                      Text(
                        _selectedDate == null
                            ? "Selecione sua data de nascimento"
                            : DateFormat('dd/MM/yyyy').format(_selectedDate!),
                        style: const TextStyle(color: Color(0xFFE94057)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Selecione sua orientação sexual:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Wrap(
                spacing: 8,
                children: _orientations.map((orientation) {
                  final isSelected = _selectedOrientation == orientation;
                  return FilterChip(
                    label: Text(orientation),
                    selected: isSelected,
                    selectedColor: Colors.redAccent.shade100,
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedOrientation = selected ? orientation : null;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Selecione seus interesses:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Wrap(
                spacing: 8,
                children: _interests.map((interest) {
                  final isSelected = _selectedInterests.contains(interest);
                  return FilterChip(
                    label: Text(interest),
                    selected: isSelected,
                    selectedColor: Colors.redAccent.shade100,
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _selectedInterests.add(interest);
                        } else {
                          _selectedInterests.remove(interest);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE94057),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    // Tratar o envio dos dados aqui
                  },
                  child: const Text("Confirmar",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}