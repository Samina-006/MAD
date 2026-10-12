
 // library_lab.dart - Campus Library System
// Name: Samina Shahid
// Roll no: 04072313018

const String rollNo = '04072313018';

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10;   // tens digit
final int u = seed % 10;    // units digit

const List<String> titles = [
  'Dart Basics', 'Flutter In Action', 'Data Structures', 'Operating Systems',
  'Mobile Design', 'Clean Code', 'Algorithms Unlocked', 'Computer Networks',
  'Database Systems', 'Software Testing',
];

int yearOf(int i) => 1995 + 2 * i + t;      // publication year of titles[i]
final int feePerDay = 5 + t;                // late fee per day, in rupees
final int daysLate = 3 + (t + u) % 6;       // normal number of days late
final int daysBig = 10 + u;                 // a long overdue period
final int feeCap = 150 + 10 * t;            // no single fee may exceed this
final int renewLimit = 1 + t % 3;           // renewals allowed per item
final int renewAttempts = 2 + u;            // renewal attempts made in Step 5
final int shelfSize = 3 + u % 4;            // items on the shelf in Steps 9-10
// ==========================================================================


abstract class LibraryItem {
  final String title;
  final int year;

  LibraryItem(this.title, this.year);

  String describe() => '$title ($year)';

  int lateFee(int days);
}





class Book extends LibraryItem with Renewable implements Borrowable {
  final int pages;
  bool _out = false;

  Book(super.title, super.year, this.pages);

  @override
  String describe() => '${super.describe()}, $pages pages';

  @override
  int lateFee(int days) => days * feePerDay;

  @override
  bool get isAvailable => !_out;

  @override
  void borrow() {
    _out = true;
  }

  @override
  void giveBack() {
    _out = false;
  }
}

Book mainBook() {
  return Book(titles[u], yearOf(u), 100 + 3 * seed);
}


class Magazine extends LibraryItem {
  final int issue;

  Magazine(super.title, super.year, this.issue);

  @override
  String describe() => '${super.describe()}, issue $issue';

  @override
  int lateFee(int days) => days * (feePerDay ~/ 2);
}


Magazine mainMagazine() {
  int i = (u + 1) % 10;
  return Magazine(
    titles[i],
    yearOf(i),
    1 + (t + u) % 12,
  );
}


class Dvd extends LibraryItem with Renewable {
  final int minutes;

  Dvd(super.title, super.year, this.minutes);

  @override
  String describe() => '${super.describe()}, $minutes min';

  @override
  int lateFee(int days) => days * feePerDay * 2;
}

Dvd mainDvd() {
  int i = (u + 2) % 10;
  return Dvd(
    titles[i],
    yearOf(i),
    90 + seed % 40,
  );
}

abstract class Borrowable {
  bool get isAvailable;

  void borrow();

  void giveBack();
}

mixin Renewable {
  int renewals = 0;

  bool renew(int limit) {
    if (renewals >= limit) {
      return false;
    }

    renewals++;
    return true;
  }
}


enum MemberType {
  student(3, 50),
  faculty(10, 20),
  guest(1, 0);

  final int maxLoans;
  final int discountPercent;

  const MemberType(this.maxLoans, this.discountPercent);

  int applyDiscount(int fee) =>
      fee - (fee * discountPercent ~/ 100);
}

extension MoneyText on int {
  String get rs => 'Rs $this';
}

extension Initials on String {
  String get initials =>
      split(' ').map((w) => w[0]).join();
}

extension ShelfMath on List<LibraryItem> {
  int totalLateFee(int days) =>
      fold(0, (sum, item) => sum + item.lateFee(days));
}



void main() {
  print('Seed: $seed (t=$t, u=$u)');
  step1();
  step2();
  step3();
  step4();
  step5();
  step6();
  step7();
  step8();
  step9();
  step10();
}


void step1() {
  print('--- Step 1 ---');

  Book b = mainBook();
  LibraryItem item = b;

  print('Step 1: ${b.title} (${b.year}), ${b.pages} pages');
  print('Step 1: stored as LibraryItem: ${item.title}');
  print('Step 1: runtimeType = ${item.runtimeType}');
  /*Answer item.pages causes a compile-time error because item is declared as LibraryItem, and the pages attribute is defined only in the Book class.*/
}


void step2() {
  print('--- Step 2 ---');
  print('Step 2: ${mainBook().describe()}');
  print('Step 2: ${mainMagazine().describe()}');
  /*Answer: With @override: Dart reports an error because descibe() does not match a method in the parent class.
Without @override: Dart may accept descibe() as a new method. When you call mainBook().describe(), Dart uses the inherited describe() method instead, so the output will be Database Systems (2012) without , 154 pages
*/

 
}


void step3() {
  print('--- Step 3 ---');

  print(
    'Step 3: Book late fee for $daysLate days = ${mainBook().lateFee(daysLate)}',
  );
  print(
    'Step 3: Magazine late fee for $daysLate days = ${mainMagazine().lateFee(daysLate)}',
  );
  print(
    'Step 3: Dvd late fee for $daysLate days = ${mainDvd().lateFee(daysLate)}',
  );

  /*An abstract class can contain methods without implementations. For example, lateFee() has no body in LibraryItem. Dart prevents you from creating a direct object of this class because it does not provide the complete behaviour required by the abstract contract.
Instead, you create a concrete subclass such as Book, Magazine, or Dvd, each of which implements lateFee().*/
}


void step4() {
  print('--- Step 4 ---');

  Book book = mainBook();

  print('Step 4: available? ${book.isAvailable}');

  book.borrow();
  print('Step 4: after borrow? ${book.isAvailable}');

  book.giveBack();
  print('Step 4: after return? ${book.isAvailable}');

  List<LibraryItem> items = [
    book,
    mainMagazine(),
    mainDvd(),
  ];

  for (LibraryItem item in items) {
    print(
      'Step 4: ${item.runtimeType} borrowable? ${item is Borrowable}',
    );
  }

  /* Using extends would allow a class to inherit the available implementation from its parent. However, Borrowable defines the required members without providing their implementations, so we must write the borrowing behaviour ourselves. Also, Book already extends LibraryItem, and Dart allows only one superclass. Therefore, implements Borrowable is appropriate because it lets Book inherit from LibraryItem while fulfilling the borrowing contract.*/
}


void step5() {
  print('--- Step 5 ---');

  Book book = mainBook();
  int ok = 0;

  for (int i = 0; i < renewAttempts; i++) {
    if (book.renew(renewLimit)) {
      ok++;
    }
  }

  print(
    'Step 5: renewed $ok of $renewAttempts attempts (limit $renewLimit)',
  );
  print('Step 5: renew once more? ${book.renew(renewLimit)}');
  print('Step 5: dvd can renew too? ${mainDvd().renew(1)}');

  /*Answer: A mixin allows us to reuse the same renewal code in Book and Dvd without duplicating it. Magazine does not need renewal behaviour, so placing renew() in LibraryItem would give the feature to every library item. The Renewable mixin allows only the classes that need it to use this behaviour.*/
}


void step6() {
  print('--- Step 6 ---');

  MemberType type = MemberType.values[seed % 3];
  int fee = mainBook().lateFee(daysLate);

  print(
    'Step 6: member type = ${type.name} (index ${type.index})',
  );
  print('Step 6: max loans = ${type.maxLoans}');
  print(
    'Step 6: book fee $fee -> ${type.applyDiscount(fee)} after discount',
  );

  /*Answer: MemberType.student refers to a predefined enum value, so Dart can check that the value belongs to the MemberType enum. A string such as 'student' can contain spelling mistakes or invalid names. Using an enum makes membership types more reliable and helps prevent invalid values.*/
}


void step7() {
  print('--- Step 7 ---');

  MemberType type = MemberType.values[seed % 3];
  int fee = mainBook().lateFee(daysLate);
  int discountedFee = type.applyDiscount(fee);

  List<LibraryItem> shelf = [
    mainBook(),
    mainMagazine(),
    mainDvd(),
  ];

  print('Step 7: ${discountedFee.rs}');
  print('Step 7: initials of "${titles[u]}" = ${titles[u].initials}');
  print(
    'Step 7: shelf fee for $daysLate days = '
    '${shelf.totalLateFee(daysLate).rs}',
  );

 /* The main benefit is readability and convenience. Instead of passing a value to a separate function, the extension allows you to use the operation directly on the value. For example, 72.rs clearly expresses formatting the integer as rupees.*/
}

void step8() { print('--- Step 8 ---'); }
void step9() { print('--- Step 9 ---'); }
void step10() { print('--- Step 10 ---'); }
