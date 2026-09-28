// Week3.dart  -  Library Desk Assistant  
// Name: Samina Shahid  Roll no: 04072313018  
  
final List<Map<String, dynamic>> books = [  
  {  
    'title': 'Dart in Action',  
    'author': 'Ada',  
    'year': 2021,  
    'copies': 3,  
    'tags': ['dart', 'programming'],  
  },  
  {  
    'title': 'Flutter Basics',  
    'author': 'Sam',  
    'year': 2023,  
    'copies': 0,  
    'tags': ['flutter', 'mobile'],  
  },  
  {  
    'title': 'Clean Code',  
    'author': 'Martin',  
    'year': 2008,  
    'copies': 2,  
    'tags': ['programming', 'design'],  
  },  
  {  
    'title': 'Algorithms',  
    'author': 'Knuth',  
    'year': 1968,  
    'copies': 1,  
    'tags': ['programming', 'math'],  
  },  
  {  
    'title': 'UI Design',  
    'author': 'Nora',  
    'year': 2019,  
    'copies': 4,  
    'tags': ['design', 'mobile'],  
  },  
];  
  
// Part 1  
//1.1  
double lateFee(int daysLate, double ratePerDay) => daysLate * ratePerDay;  
  
//1.2  
String formatTitle(String title, [String? author]) {  
  if (author == null) {  
    return title;  
  }  
  return '$title by $author';  
}  
  
//1.3  
Map<String, dynamic> makeBook({  
  required String title,  
  required String author,  
  int year = 2024,  
  int copies = 1,  
}) {  
  return {'title': title, 'author': author, 'year': year, 'copies': copies};  
}  
  
//1.4  
bool isClassic(int year) => year < 2000;  
  
// Part 2  
//2.1  
List<String> transformAll(List<String> items, String Function(String) fn) {  
  final List<String> updatedItems = [];  
  
  for (final item in items) {  
    updatedItems.add(fn(item));  
  }  
  return updatedItems;  
}  
  
//2.2  
int Function() makeCounter() {  
  var count = 0;  
  return () {  
    count = count + 1;  
    return count;  
  };  
}  
  
//2.3  
double Function(int) makeFeeCalculator(double rate) {  
  return (days) => rate * days;  
}  
  
//2.4  
int sumDigits(int n) {  
  if (n < 10) {  
    return n;  
  }  
  
  final lastDigit = n % 10;  
  return lastDigit + sumDigits(n ~/ 10);  
}  
  
//Part 3  
//3.4  
Map<String, int> buildStock() {  
  final Map<String, int> stock = {  
    for (final book in books) book['title'] as String: book['copies'] as int,  
  };  
  
  return stock;  
}  
  
// Part 4  
//4.1  
class Box<T> {  
  T value;  
  
  Box(this.value);  
}  
  
//4.2  
T firstOr<T>(List<T> items, T fallback) {  
  return items.isEmpty ? fallback : items[0];  
}  
  
//4.3  
class Pair<A, B> {  
  final A first;  
  final B second;  
  
  Pair(this.first, this.second);  
  @override  
  String toString() {  
    return '($first, $second)';  
  }  
}  
  
// Part 5  
//5.1  
class BookNotFoundException implements Exception {  
  final String title;  
  
  BookNotFoundException(this.title);  
}  
  
// Custom exception for unavailable books  
class BookNotAvailableException implements Exception {  
  final String title;  
  BookNotAvailableException(this.title);  
}  
  
//5.2  
void checkOut(Map<String, int> stock, String title) {  
  if (!stock.containsKey(title)) {  
    throw BookNotFoundException(title);  
  }  
  final copies = stock[title]!;  
  if (copies <= 0) {  
    throw BookNotAvailableException(title);  
  }  
  
  stock[title] = copies - 1;  
}  
  
//5.4  
Map<String, dynamic> findBook(String title) {  
  return books.firstWhere((book) => book['title'] == title);  
}  
  
// Part 6  
  
//6.1  
Future<String> fetchBookOfTheDay() async {  
  await Future.delayed(const Duration(seconds: 1));  
  return 'Dart in Action';  
}  
  
//6.3  
Future<String> fetchBroken() async {  
  await Future.delayed(const Duration(milliseconds: 500));  
  throw Exception('Server down');  
}  
  
void main() async {  
  part1();  
  part2();  
  part3();  
  part4();  
  part5();  
  await part6();  

  // BONUS ADDED
  await bonusPart();
}  
  
// part 1 function  
void part1() {  
  print('Part 1');  
  
  final fee = lateFee(5, 0.5);  
  print('Late fee: $fee');  
  print(formatTitle('Dart in Action'));  
  print(formatTitle('Dart in Action', 'Ada'));  
  
  final cleanCode = makeBook(title: 'Clean Code', author: 'Martin');  
  print(cleanCode);  
  
  final algorithms = makeBook(title: 'Algorithms', author: 'Knuth', year: 1968);  
  print(algorithms);  
  
  print(isClassic(1968));  
  print(isClassic(2021));  
}  
  
// part 2 function  
void part2() {  
  print('Part 2');  
  
  final bookNames = ['Dart in Action', 'Clean Code'];  
  
  print(  
    transformAll(bookNames, (name) {  
      return name.toUpperCase();  
    }),  
  );  
  
  print(transformAll(bookNames, (name) => '$name!'));  
  
  final desk1 = makeCounter();  
  final desk2 = makeCounter();  
  
  print(desk1());  
  print(desk1());  
  print(desk1());  
  print(desk2());  
  
  final studentFee = makeFeeCalculator(0.25);  
  final staffFee = makeFeeCalculator(0.10);  
  
  print('Student fee: ${studentFee(4)}');  
  print('Staff fee: ${staffFee(4)}');  
  
  print('Sum of digits: ${sumDigits(1223)}');  
}  
  
// part 3 function  
void part3() {  
  print('Part 3');  
  
  // Task 3.1: Get all titles  
  final titles = books.map((book) => book['title'] as String).toList();  
  
  print('Titles: $titles');  
  
  final availableTitles = books  
      .where((book) => (book['copies'] as int) > 0)  
      .map((book) => book['title'] as String)  
      .toList();  
  
  print('Available: $availableTitles');  
  
  final totalCopies = books.fold<int>(  
    0,  
    (total, book) => total + (book['copies'] as int),  
  );  
  
  print('Total copies: $totalCopies');  
  
  final years = books.map((book) => book['year'] as int).toList();  
  
  final oldestYear = years.reduce(  
    (first, second) => first < second ? first : second,  
  );  
  
  print('Oldest year: $oldestYear');  
  
  final booksByYear = [...books];  
  
  booksByYear.sort((first, second) {  
    final firstYear = first['year'] as int;  
    final secondYear = second['year'] as int;  
  
    return firstYear.compareTo(secondYear);  
  });  
  
  final orderedTitles = booksByYear.map((book) => book['title']).toList();  
  
  print('By year: $orderedTitles');  
  
  final stock = buildStock();  
  print('Stock: $stock');  
  stock.forEach((title, copies) {  
    if (copies == 0) {  
      print('Out of stock: $title');  
    }  
  });  
  
  final unknownCopies = stock['Unknown'] ?? 0;  
  print('Copies of Unknown: $unknownCopies');  
  
  final Set<String> allTags = {  
    for (final book in books) ...(book['tags'] as List<String>),  
  };  
  
  print('All tags: $allTags');  
  
  final a = {'Dart in Action', 'Clean Code', 'Flutter Basics'};  
  
  final b = {'Clean Code', 'Flutter Basics', 'Algorithms'};  
  
  print('Union: ${a.union(b)}');  
  print('Common: ${a.intersection(b)}');  
  print('Only in A: ${a.difference(b)}');  
}  
  
//part 4 function  
void part4() {  
  print('Part 4');  
  final intBox = Box<int>(5);  
  final stringBox = Box<String>('dart');  
  
  print('Box<int>: ${intBox.value}');  
  print('Box<String>: ${stringBox.value}');  
  
  // This would give a type error because the box stores an int.  
  // intBox.value = 'hello';  
  
  print(firstOr(['Dart in Action', 'Clean Code'], 'none'));  
  
  print(firstOr<String>([], 'z'));  
  
  final bookPair = Pair('Dart in Action', 3);  
  print(bookPair);  
}  
  
//part 5 function  
void part5() {  
  print('Part 5');  
  
  final stock = buildStock();  
  
  final requestedBooks = ['Dart in Action', 'Flutter Basics', 'Unknown Book'];  
  
  for (final title in requestedBooks) {  
    try {  
      checkOut(stock, title);  
      print('Checked out: $title');  
    } on BookNotFoundException catch (error) {  
      print('Not found: "${error.title}"');  
    } on BookNotAvailableException catch (error) {  
      print('Sorry: "${error.title}" has no copies left');  
    } finally {  
      print('Transaction logged.');  
    }  
  }  
  
  print('Copies left of Dart in Action: ${stock['Dart in Action']}');  
  
  try {  
    findBook('Missing');  
  } on StateError {  
    print('Search failed: no such book');  
  }  
}  
  
// part 6 function  
Future<void> part6() async {  
  print('Part 6');  
  
  print('Fetching...');  
  
  final result = await fetchBookOfTheDay();  
  
  print('Book of the day: $result');  
  
  try {  
    await fetchBroken();  
  } catch (error) {  
    print('Fetch failed: $error');  
  }  
}  
  

// Bonus 1

Map<String, List<String>> groupBooksByTag() {
  final Map<String, List<String>> groupedBooks = {};

  for (final book in books) {
    final title = book['title'] as String;
    final tags = book['tags'] as List<String>;

    for (final tag in tags) {
      groupedBooks.putIfAbsent(tag, () => []);
      groupedBooks[tag]!.add(title);
    }
  }

  return groupedBooks;
}


// Bonus 2


List<T> filterBy<T>(List<T> items, bool Function(T) test) {
  final List<T> filteredItems = [];

  for (final item in items) {
    if (test(item)) {
      filteredItems.add(item);
    }
  }

  return filteredItems;
}


// Bonus Part

Future<void> bonusPart() async {
  print('Bonus Part');

  // Bonus 1
  print('Bonus 1 - Books grouped by tag');

  final groupedBooks = groupBooksByTag();

  groupedBooks.forEach((tag, titles) {
    print('$tag: $titles');
  });


  // Bonus 2
  print('Bonus 2 - Available books using filterBy');

  final availableBooks = filterBy<Map<String, dynamic>>(
    books,
    (book) => (book['copies'] as int) > 0,
  );

  final availableTitles = availableBooks
      .map((book) => book['title'] as String)
      .toList();

  print('Available books: $availableTitles');


  // Bonus 3
  print('Bonus 3 - Two Futures using Future.wait');

  final stopwatch = Stopwatch()..start();

  final results = await Future.wait([
    fetchBookOfTheDay(),
    fetchBookOfTheDay(),
  ]);

  stopwatch.stop();

  print('Future results: $results');
  print('Time taken: ${stopwatch.elapsedMilliseconds} ms');
}
