import 'package:flutter/material.dart';

class DnevnikScreen extends StatefulWidget {
  @override
  State<DnevnikScreen> createState() => _DnevnikScreenState();
}

class _DnevnikScreenState extends State<DnevnikScreen> {
  String? selectedMood;
  String? selectedSubMood;
  List<String> subMoods = [];
  double stressLevel = 0;
  double selfEsteemLevel = 0;
  String note = '';

  // Маппинг эмоций с изображениями
  final Map<String, String> moodImages = {
    'Радость': 'assets/images/radost.png',
    'Страх': 'assets/images/strah.png',
    'Бешенство': 'assets/images/beshenstvo.png',
    'Грусть': 'assets/images/grust.png',
    'Спокойствие': 'assets/images/spokoistvie.png',
    'Сила': 'assets/images/sila.png',
  };

  final Map<String, List<String>> moodMap = {
    'Радость': [
      'Возбуждение',
      'Восторг',
      'Игривость',
      'Наслаждение',
      'Очарование',
      'Чувственность'
    ],
    'Страх': ['Тревога', 'Беспокойство', 'Неловкость'],
    'Бешенство': ['Злость', 'Раздражение', 'Ярость'],
    'Грусть': ['Тоска', 'Печаль', 'Разочарование'],
    'Спокойствие': ['Расслабленность', 'Уверенность', 'Умиротворение'],
    'Сила': ['Энергичность', 'Самоуверенность', 'Контроль'],
  };

  void _onMoodSelected(String mood) {
    setState(() {
      selectedMood = mood;
      selectedSubMood = null;
      subMoods = moodMap[mood] ?? [];
    });
  }

  void _onSubMoodSelected(String subMood) {
    setState(() {
      selectedSubMood = subMood;
    });
  }

  bool get _isFormValid {
    return selectedMood != null &&
        selectedSubMood != null &&
        stressLevel > 0 &&
        selfEsteemLevel > 0 &&
        note.isNotEmpty;
  }

  void _saveData() {
    if (_isFormValid) {
      print(
          'Данные сохранены: $selectedMood, $selectedSubMood, $stressLevel, $selfEsteemLevel, $note');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Что чувствуешь?",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: moodMap.keys.map((mood) {
                  bool isSelected = selectedMood == mood;
                  return GestureDetector(
                    onTap: () => _onMoodSelected(mood),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.orange[100] : Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 249, 187, 95)
                                      .withOpacity(0.3),
                                  blurRadius: 25,
                                  spreadRadius: 5,
                                ),
                              ]
                            : [],
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            moodImages[mood]!,
                            height: 50,
                            width: 50,
                          ),
                          SizedBox(height: 8),
                          Text(
                            mood,
                            style: TextStyle(
                              fontSize: 14,
                              color: isSelected ? Colors.orange : Colors.grey,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            if (selectedMood != null)
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: subMoods.map((subMood) {
                  bool isSubMoodSelected = selectedSubMood == subMood;
                  return ChoiceChip(
                    label: Text(
                      subMood,
                      style: TextStyle(
                        color: isSubMoodSelected
                            ? Colors.white
                            : const Color.fromARGB(255, 53, 53, 53),
                      ),
                    ),
                    selected: isSubMoodSelected,
                    onSelected: (selected) {
                      _onSubMoodSelected(subMood);
                    },
                    selectedColor: Colors.orange,
                    backgroundColor: const Color.fromARGB(255, 250, 250, 250),
                  );
                }).toList(),
              ),
            SizedBox(height: 40),
            const Text(
              "Уровень стресса",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Slider(
              value: stressLevel,
              min: 0,
              max: 10,
              divisions: 10,
              label: stressLevel.round().toString(),
              onChanged: (double value) {
                setState(() {
                  stressLevel = value;
                });
              },
              activeColor: Colors.orange,
              inactiveColor: Colors.grey,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Низкий",
                  style: TextStyle(color: Colors.black54),
                ),
                Text(
                  "Высокий",
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
            SizedBox(height: 20),
            const Text(
              "Уровень самооценки",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Slider(
              value: selfEsteemLevel,
              min: 0,
              max: 10,
              divisions: 10,
              label: selfEsteemLevel.round().toString(),
              onChanged: (double value) {
                setState(() {
                  selfEsteemLevel = value;
                });
              },
              activeColor: Colors.orange,
              inactiveColor: Colors.grey,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Неуверенность",
                  style: TextStyle(color: Colors.black54),
                ),
                Text(
                  "Уверенность",
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
            SizedBox(height: 40),
            const Text(
              "Заметка",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
              child: TextField(
                maxLength: 100,
                onChanged: (value) {
                  setState(() {
                    note = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Введите заметку",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                onPressed: _isFormValid ? _saveData : null,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: _isFormValid ? Colors.orange : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text('Сохранить'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
