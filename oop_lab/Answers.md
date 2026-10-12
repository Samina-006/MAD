Step01:
Answer item.pages causes a compile-time error because item is declared as LibraryItem, and the pages attribute is defined only in the Book class.
Step02: 
Answer: With @override: Dart reports an error because descibe() does not match a method in the parent class.
Without @override: Dart may accept descibe() as a new method. When you call mainBook().describe(), Dart uses the inherited describe() method instead, so the output will be Database Systems (2012) without , 154 pages
Step03:
Answer:/*An abstract class can contain methods without implementations. For example, lateFee() has no body in LibraryItem. Dart prevents you from creating a direct object of this class because it does not provide the complete behaviour required by the abstract contract.
Instead, you create a concrete subclass such as Book, Magazine, or Dvd, each of which implements lateFee().*/
Step04:
Answer: /*Answer: With @override: Dart reports an error because descibe() does not match a method in the parent class.
Without @override: Dart may accept descibe() as a new method. When you call mainBook().describe(), Dart uses the inherited describe() method instead, so the output will be Database Systems (2012) without , 154 pages
*/
Step05:
Answer: A mixin allows us to reuse the same renewal code in Book and Dvd without duplicating it. Magazine does not need renewal behaviour, so placing renew() in LibraryItem would give the feature to every library item. The Renewable mixin allows only the classes that need it to use this behaviour
Step06:
/*Answer: MemberType.student refers to a predefined enum value, so Dart can check that the value belongs to the MemberType enum. A string such as 'student' can contain spelling mistakes or invalid names. Using an enum makes membership types more reliable and helps prevent invalid values.*/
Step07:
Answer: An extension lets me use a useful operation directly on an existing type without modifying its original class. Writing 72.rs is convenient and readable because the formatting operation is attached to the integer value. It also keeps related operations organised under an extension.
