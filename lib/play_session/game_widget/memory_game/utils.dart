class Utils {
  final String hiddenCardPath = 'assets/images/memory/fruits.png';
  List<String>? gameImg;
  List<Map<int, String>> matchCheck = [];

  final List<String> cardList = [
    'assets/images/memory/1.png',
    'assets/images/memory/4.png',
    'assets/images/memory/3.png',
    'assets/images/memory/2.png',
    'assets/images/memory/2.png',
    'assets/images/memory/1.png',
    'assets/images/memory/3.png',
    'assets/images/memory/4.png',
    'assets/images/memory/5.png',
    'assets/images/memory/6.png',
    'assets/images/memory/5.png',
    'assets/images/memory/6.png',
  ];

  void initGame() {
    gameImg = List.generate(cardList.length, (index) => hiddenCardPath);
  }
}
