import 'package:flutter/material.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({
    super.key,
    this.selectedCity,
    this.selectedDate,
    this.selectedGenre,
    this.selectedVenue,
  });
  final String? selectedCity;
  final String? selectedVenue;
  final String? selectedGenre;
  final DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    final Object? argsObject = ModalRoute.of(context)?.settings.arguments;

    // Güvenli tür dönüşümü yaptım
    Map<String, dynamic> args = {};
    if (argsObject is Map<String, dynamic>) {
      args = argsObject;
    }

    // Verileri alırken güvenli işlem yaptım
    String? selectedCity = args['city'] as String?;
    String? selectedVenue = args['venue'] as String?;
    String? selectedGenre = args['genre'] as String?;
    DateTime? selectedDate =
        (args['date'] != null) ? DateTime.tryParse(args['date']) : null;

    final List<Map<String, String>> movies = [
      {
        'title': 'The Brutalist',
        'genre': 'Dram',
        'poster': 'assets/images/brutalist.jpg',
      },
      {'title': 'Maria', 'genre': 'Dram', 'poster': 'assets/images/maria.jpg'},
      {
        'title': 'Babygirl',
        'genre': 'Komedi',
        'poster': 'assets/images/babygirl.jpg',
      },
      {
        'title': 'Kutsal Damacana 5',
        'genre': 'Komedi',
        'poster': 'assets/images/kutsaldamacana.jpg',
      },
    ];

    List<Map<String, String>> filteredMovies =
        movies.where((movie) {
          return selectedGenre == null || movie['genre'] == selectedGenre;
        }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Filmler')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Seçilen Şehir: ${selectedCity ?? 'Belirtilmedi'}",
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "Seçilen Mekan: ${selectedVenue ?? 'Belirtilmedi'}",
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "Seçilen Tür: ${selectedGenre ?? 'Belirtilmedi'}",
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "Seçilen Tarih: ${selectedDate != null ? selectedDate.toLocal().toString().split(' ')[0] : 'Belirtilmedi'}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: filteredMovies.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            filteredMovies[index]['poster']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            filteredMovies[index]['title']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
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
