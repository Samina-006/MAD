### Q1. What can a subclass using `extends` use for free that a class using `implements` has to write itself?

When a class uses "extends", it inherits the methods and properties already implemented in its parent class, so it does not need to write them again unless it wants to change their behaviour. However, when a class uses "implements", it only follows the interface or contract of another class and must provide its own implementation of all the required methods and properties.

### Q2. Book and Dvd both use Renewable. When would you pick a mixin, and when an abstract parent class?

I would use a mixin when different classes need the same behaviour but do not need to share the same parent class. For example, both Book and Dvd use the Renewable mixin to renew items without duplicating the code. I would use an abstract parent class when related classes share common properties or behaviour and need to follow the same basic structure, such as LibraryItem.

### Q3. Why must you override `hashCode` whenever you override `==`?

When we override "==", we define when two objects should be considered equal. We must also make sure that equal objects have the same "hashCode". Collections such as Set use both "==" and "hashCode" to identify unique objects. If these methods are inconsistent, a Set may treat equal objects as separate entries.

### Q4. An extension method on String and a subclass of String both add behaviour. Why does Dart let you write the first one but not the second?

Dart allows extension methods because they add extra functionality to an existing type without changing or modifying its original class. However, String is a special built-in type that cannot be extended through inheritance to create a subclass. An extension is useful because it lets us add convenient operations, such as getting the initials of a string, without changing how String itself works.
