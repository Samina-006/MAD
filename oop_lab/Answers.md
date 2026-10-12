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
