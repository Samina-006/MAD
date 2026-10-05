// lab4.dart - Campus Cafe Order System
// Name: Samina Shahid Roll no: 04072313018

const String rollNo = '04072313018';

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10;
final int u = seed % 10;

const List<String> menu = [
  'Chai',
  'Latte',
  'Mocha',
  'Samosa',
  'Brownie',
  'Sandwich',
  'Cold Coffee',
  'Fries',
  'Pakora',
  'Zinger Wrap',
];

int priceOf(int i) => 100 + 7 * i + 3 * t;

final int priceFloor = 60 + 5 * t;
final int taxPercent = 5 + t;
final int bigOrderLimit = 450 + 20 * t;
final int balanceCap = 600 + 20 * t;
final int couponPercent = 5 + t + u;

// ===========================================================================
class Dish {
  late String name;
  late int price;
}
class MenuItem {
  String name;
  int price;

  MenuItem(this.name, this.price) {
    if (this.price < priceFloor) {
      this.price = priceFloor;
    }
  }

  MenuItem.free(this.name) : price = 0;

  MenuItem.fromString(String text)
      : name = text.split(':')[0],
        price = int.parse(text.split(':')[1]);

  @override
  String toString() => '$name (Rs $price)';
}
class OrderLog {
  static OrderLog? _instance;
  final List<String> entries = [];

  OrderLog._internal();

  factory OrderLog() {
    return _instance ??= OrderLog._internal();
  }

  void add(String msg) => entries.add(msg);
}
class OrderLine {
  final MenuItem item;
  final int qty;
  final int total;
  final int tax;

  OrderLine(this.item, this.qty)
      : total = item.price * qty,
        tax = (item.price * qty) * taxPercent ~/ 100,
        assert(qty > 0);

  int get grand => total + tax;

  bool get isBigOrder => grand > bigOrderLimit;

  String get label => '${item.name} x$qty';
}
OrderLine mainOrder() {
  return OrderLine(
    MenuItem(menu[u], priceOf(u)),
    2 + (t + u) % 5,
  );
}
class StudentCard {
  final String owner;
  int _balance;

  StudentCard(this.owner) : _balance = 0;

  int get balance => _balance;

  set balance(int v) {
    if (v < 0) {
      _balance = 0;
    } else if (v > balanceCap) {
      _balance = balanceCap;
    } else {
      _balance = v;
    }
  }
}
List<MenuItem> buildMenu() {
  return [
    for (var k = 0; k < 4; k++)
      MenuItem.fromString(
        '${menu[(u + 3 * k) % 10]}:${priceOf((u + 3 * k) % 10)}',
      ),
  ];
}
List<OrderLine> buildReceipt() {
  var items = buildMenu();

  return [
    for (var k = 0; k < 3; k++)
      OrderLine(
        items[k],
        1 + (t + k) % 4,
      ),
  ];
}
class Coupon {
  static final Map<String, Coupon> _cache = {};

  final String code;
  final int percent;
  final int minSpend;

  Coupon(this.code, this.percent)
      : minSpend = percent * 70,
        assert(percent >= 1 && percent <= 50);

  factory Coupon.fromCode(String code) {
    return _cache.putIfAbsent(
      code,
      () => Coupon(code, couponPercent),
    );
  }

  int discountOn(int amount) {
    if (amount >= minSpend) {
      return amount * percent ~/ 100;
    }
    return 0;
  }
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
  var item1 = Dish();
  item1.name = menu[u];
  item1.price = priceOf(u);

  var item2 = Dish();
  item2.name = menu[(u + 1) % 10];
  item2.price = priceOf((u + 1) % 10);

  item2.price = item2.price - u;

  print('Step 1: ${item1.name} Rs ${item1.price}');
  print('Step 1: ${item2.name} Rs ${item2.price}');
}

void step2() {
  var a = MenuItem(menu[u], priceOf(u));
  var b = MenuItem('Test Special', 15 * u);

  print('Step 2: ${a.name} Rs ${a.price}');
  print('Step 2: Test Special Rs ${b.price}');
}
// price cannot be final because the constructor may change it because of pricefloor

void step3() { //// The floor logic did not run because free() is a separate named constructor;
// it directly initializes price to 0 and does not execute the main constructor body.
  var freebie = MenuItem.free('Water');

  var i = (u + 2) % 10;
  var parsed = MenuItem.fromString('${menu[i]}:${priceOf(i)}');

  print('Step 3: ${freebie.name} Rs ${freebie.price}');
  print('Step 3: ${parsed.name} Rs ${parsed.price}');
  print('Step 3: floor=$priceFloor, free price=${freebie.price}');
}

void step4() {
  var log1 = OrderLog();
  var log2 = OrderLog();

  for (var i = 1; i <= u + 2; i++) {
    var message = 'order #${100 * t + i}';

    if (i % 2 == 1) {
      log1.add(message);
    } else {
      log2.add(message);
    }
  }

  print('Step 4: same object? ${identical(log1, log2)}');
  print('Step 4: entries = ${log1.entries.length}');
  print('Step 4: last = ${log2.entries.last}');
}
/* The underscore makes _instance and _internal private to this library.
 Without it, outside code could access them directly and bypass the factory.*/
void step5() { 
  /*Answer : An initializer list cannot read another instance field because the object is not fully initialized yet.*/
  var line = mainOrder();

  print('Step 5: ${line.item.name} x ${line.qty}');
  print('Step 5: total=${line.total}, tax=${line.tax}');

  try {
    OrderLine(MenuItem('Bad', 100), 0);
  } catch (e) {
    print('Step 5: caught ${e.runtimeType}');
  }
}
void step6() {
  /* Answer: ->line.grand = 5 fails because grand has only a getter, so it can be
-> read but not changed. To make assignment legal, we would need to add
-> a setter for grand.*/

  var line = mainOrder();

  print('Step 6: grand=${line.grand}');
  print('Step 6: big order? ${line.isBigOrder} (limit $bigOrderLimit)');
  print('Step 6: label=${line.label}');
}

void step7() {
  /*Answer  For an invalid value, a setter could throw an exception or show an error
 message instead of silently changing the value.*/
  var card = StudentCard('S$seed');

  card.balance = seed * 10 + 50;
  print('Step 7: topped up -> ${card.balance}');

  card.balance = -seed - 1;
  print('Step 7: bad value -> ${card.balance}');

  card.balance = balanceCap - u;
  print('Step 7: reset -> ${card.balance}');

  card.balance = card.balance - mainOrder().grand;
  print('Step 7: paid order -> ${card.balance}');
}

void step8() {
  var items = buildMenu();

  var priciest = items.reduce(
    (a, b) => a.price > b.price ? a : b,
  );

  var sum = items.fold(
    0,
    (acc, item) => acc + item.price,
  );

  print('Step 8: menu = $items');
  print('Step 8: priciest = ${priciest.name}');
  print('Step 8: sum = $sum');
}

void step9() {
  var receipt = buildReceipt();
  var total = 0;

  for (var line in receipt) {
    print('Step 9: ${line.label} = ${line.grand}');

    OrderLog().add('receipt: ${line.label}');

    total += line.grand;
  }

  print('Step 9: receipt total = $total');
  print('Step 9: log size = ${OrderLog().entries.length}');
}

void step10() {
  var code = 'CAFE${seed.toString().padLeft(2, '0')}';

  var c1 = Coupon.fromCode(code);
  var c2 = Coupon.fromCode(code);

  var receipt = buildReceipt();
  var receiptAmount = receipt.fold(
    0,
    (sum, line) => sum + line.grand,
  );

  var discount = c1.discountOn(receiptAmount);
  var payable = receiptAmount - discount;

  print('Step 10: ${c1.code} gives ${c1.percent}% off, min spend ${c1.minSpend}');
  print('Step 10: cached? ${identical(c1, c2)}');
  print('Step 10: receipt $receiptAmount, discount $discount, payable $payable');
}
