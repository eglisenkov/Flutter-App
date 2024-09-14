import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Для форматирования даты и времени
import 'package:intl/date_symbol_data_local.dart'; // Для поддержки локализации
import 'package:mood_calendar/statistica.dart';
import 'dnevnik.dart'; // Импортируем экран Дневника настроения

void main() {
  // Инициализация данных локализации
  initializeDateFormatting('ru_RU', null).then((_) {
    runApp(MoodDiaryApp());
  });
}

class MoodDiaryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Diary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Переменная для отслеживания выбранной вкладки

  // Список экранов
  final List<Widget> _screens = [DnevnikScreen(), StatistikaScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildAppBarTitle(),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              setState(() {});
            },
            iconSize: 30,
            color: Colors.black26,
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          _buildTabSwitcher(), // Наш кастомный переключатель вкладок
          Expanded(child: _screens[_selectedIndex]), // Показ выбранного экрана
        ],
      ),
    );
  }

  // Построение кастомного переключателя
  Widget _buildTabSwitcher() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTabButton(Icons.note, "Дневник настроения", 0),
        _buildTabButton(Icons.data_object, "Статистика", 1),
      ],
    );
  }

  // Кнопка для каждой вкладки
  Widget _buildTabButton(IconData iconData, String text, int index) {
    // Устанавливаем цвет для иконки и текста в зависимости от выбранной вкладки
    Color iconColor = _selectedIndex == index ? Colors.white : Colors.black54;
    Color textColor = _selectedIndex == index ? Colors.white : Colors.black54;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: _selectedIndex == index ? Colors.orange : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            Icon(
              iconData,
              color: iconColor, // Изменяем цвет иконки
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              text,
              style: TextStyle(
                color: textColor, // Изменяем цвет текста
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBarTitle() {
    String formattedDate = DateFormat('d MMMM', 'ru_RU').format(DateTime.now());
    String formattedTime = DateFormat('HH:mm', 'ru_RU').format(DateTime.now());

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formattedDate,
          style: AppTextStyles.title,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          formattedTime,
          style: AppTextStyles.title,
        ),
      ],
    );
  }
}

class AppTextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.black26,
  );
}
