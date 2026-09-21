String? getInstructor() {
  return null;
}

String? getPhone() {
  return null;
}

String? getOptionalEmail() {
  return 'teacher@qau.edu.pk';
}

String? getConfirmedEmail() {
  return 'teacher@qau.edu.pk';
}

Object getFormInput() {
  return 'twenty-two';
}

int getEnrollmentStatusCode() {
  return 200;
}

List<String>? getExtraNotes() {
  return null;
}

/// Prints welcome message
void printWelcome(String appName) {
  print('=== $appName ===');
}

void main() {
  // Part 1
  printWelcome('Course Roster Manager');

  // Part 2
  const int maxCapacity = 4;
  final DateTime createdAt = DateTime.now();

  String courseTitle = 'CS201: Mobile App Development';
  int capacity = maxCapacity;
  double creditHours = 3.0;
  var semester = 'Fall 2026';

  List<String> enrolledStudents = [
    'Aiden',
    'Maria',
    'Jamal',
  ];

  Set<String> waitlist = {
    'Priya',
    'Noah',
  };

  Map<String, int> attendanceCount = {
    'Aiden': 3,
    'Maria': 4,
    'Jamal': 2,
  };

  bool isOpen = enrolledStudents.length < capacity;

  print(
    '$courseTitle | Capacity: $capacity | Enrolled: ${enrolledStudents.length}',
  );

  // Part 3
  String? instructorName = getInstructor();

  print(instructorName ?? 'TBA');

  String? phone = getPhone();
  phone ??= 'Not provided';

  String? optionalEmail = getOptionalEmail();
  optionalEmail?.toUpperCase();

  String confirmedEmail = getConfirmedEmail()!;

  late String enrollmentCode;
  enrollmentCode = 'CS101';

  print('Enrollment code: $enrollmentCode');

  // Part 4
  String rawNames = ' Aiden , maria ,JAMAL , Priya ';

  List<String> cleanNames = [];

  for (String name in rawNames.split(',')) {
    cleanNames.add(name.trim());
  }

  String courseDescription = '''
$courseTitle
Semester: $semester
Credit Hours: $creditHours
Created: $createdAt
Clean Names: ${cleanNames.length}
Phone: $phone
Email: $confirmedEmail
''';

  // Part 5
  int fullGroups = enrolledStudents.length ~/ 3;
  int leftover = enrolledStudents.length % 3;

  print(
    'Full groups of 3: $fullGroups, leftover: $leftover',
  );

  Object formInput = getFormInput();

  String typeMessage = '';
  bool notInteger = false;

  if (formInput is String) {
    typeMessage = 'This is text!';
  }

  if (formInput is! int) {
    notInteger = true;
  }

  if (notInteger) {
    print(typeMessage);
  }

  var report = StringBuffer()
    ..write('Report: ${courseDescription.split('\n').first}')
    ..write(' | Cap: $capacity')
    ..write(' | Roster: ${enrolledStudents.length}');

  print(report.toString());

  List<String>? extraNotes = getExtraNotes();

  extraNotes?..add('Room change pending');

  print('Extra notes: $extraNotes');

  int? bonusSeats;

  bonusSeats ??= 0;

  print('Bonus seats: $bonusSeats');

  // Part 6
  if (isOpen && enrolledStudents.length < capacity) {
    print("You're in! Welcome aboard.");
  } else {
    print('Course is full.');
  }

  int enrollmentStatusCode =
      getEnrollmentStatusCode();

  switch (enrollmentStatusCode) {
    case 200:
      print('Enrolled');
      break;

    case 404:
      print('Course not found');
      break;

    default:
      print('Unknown error');
      break;
  }

  String statusTag =
      isOpen ? 'OPEN' : 'FULL';

  print(statusTag);

  // Part 7
  for (var student in enrolledStudents) {
    print(student);
  }

  attendanceCount.forEach((name, count) {
    print('$name: $count');
  });

  List<String> announcements = [
    'Welcome to $courseTitle',

    if (!isOpen)
      'Course is FULL — waitlist open',

    for (var student in waitlist)
      'Reminder: $student, please confirm attendance',
  ];

  for (var announcement in announcements) {
    print(announcement);
  }
}