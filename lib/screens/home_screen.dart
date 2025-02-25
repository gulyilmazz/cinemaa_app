import 'package:cinema_flutter/screens/movies_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCity;
  String? selectedVenue;
  String? selectedGenre;
  DateTime? selectedDate;

  final List<String> cities = ['İstanbul', 'Ankara', 'İzmir'];
  final List<String> venues = ['Salon 1', 'Salon 2', 'Salon 3'];
  final List<String> genres = ['Aksiyon', 'Komedi', 'Dram'];

  void navigateToMovies() {
    if (selectedCity != null &&
        selectedVenue != null &&
        selectedGenre != null &&
        selectedDate != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => MoviesScreen(
                selectedCity: selectedCity,
                selectedDate: selectedDate,
                selectedGenre: selectedGenre,
                selectedVenue: selectedVenue,
              ),

          //  venue': selectedVenue!,
          //  'genre': selectedGenre!,
          //  'date': selectedDate!.toIso8601String(),
        ),
      );
      // context,
      // 'screens/movies_screen',
      // arguments: {
      //   'city': selectedCity!,
      //   'venue': selectedVenue!,
      //   'genre': selectedGenre!,
      //   'date': selectedDate!.toIso8601String(),
      // },
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen tüm seçenekleri doldurun!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vizyondaki Filmler')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildDropdownField(
                label: 'Şehir Seçiniz',
                icon: Icons.location_city,
                items: cities,
                selectedValue: selectedCity,
                onChanged: (value) {
                  setState(() {
                    selectedCity = value;
                  });
                },
              ),
              const SizedBox(height: 15),
              _buildDropdownField(
                label: 'Mekan Seçiniz',
                icon: Icons.theater_comedy,
                items: venues,
                selectedValue: selectedVenue,
                onChanged: (value) {
                  setState(() {
                    selectedVenue = value;
                  });
                },
              ),
              const SizedBox(height: 15),
              _buildDropdownField(
                label: 'Tür Seçiniz',
                icon: Icons.movie,
                items: genres,
                selectedValue: selectedGenre,
                onChanged: (value) {
                  setState(() {
                    selectedGenre = value;
                  });
                },
              ),
              const SizedBox(height: 15),
              _buildDatePickerField(),
              const SizedBox(height: 20),
              _buildElevatedButton(),
            ],
          ),
        ),
      ),
    );
  }

  /// **Açılır Menüler İçin Ortak Widget**
  Widget _buildDropdownField({
    required String label,
    required IconData icon,
    required List<String> items,
    required String? selectedValue,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color.fromARGB(255, 79, 138, 12)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 79, 138, 12),
            width: 1,
          ),
        ),
      ),
      items:
          items.map((item) {
            return DropdownMenuItem(value: item, child: Text(item));
          }).toList(),
      value: selectedValue,
      onChanged: onChanged,
    );
  }

  /// **Tarih Seçici Widget**
  Widget _buildDatePickerField() {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Etkinlik Tarihi Seçiniz',
        suffixIcon: IconButton(
          icon: const Icon(
            Icons.calendar_today,
            color: Color.fromARGB(255, 79, 138, 12),
          ),
          onPressed: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2025),
              lastDate: DateTime(2030),
            );
            if (pickedDate != null) {
              setState(() {
                selectedDate = pickedDate;
              });
            }
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 79, 138, 12),
            width: 1,
          ),
        ),
      ),
      controller: TextEditingController(
        text:
            selectedDate != null
                ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                : "",
      ),
    );
  }

  /// **Giriş Butonu Widget'ı**
  Widget _buildElevatedButton() {
    return ElevatedButton(
      onPressed: navigateToMovies,

      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: const Color.fromARGB(255, 79, 138, 12),
      ),
      child: const Text(
        "GİRİŞ",
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
