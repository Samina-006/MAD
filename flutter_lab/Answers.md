# Flutter Lab — Study Tracker

**Name:** Samina Shahid  
**Roll Number:** 04072313018

## Part A: Numerical Answers

### A1: How many taps of + are needed to reach `maxCount`?

My starting count is 11, the step size is 2, and the maximum count is 22. Each time I press the + button, the count increases by 2. After five taps, the count becomes 21. On the sixth tap, it reaches 22. The code does not allow the count to go above the maximum, so it stays at 22.

**A1: 6**

### A2: How many times does `Countdown.build()` run until “Time is up!” appears?

My countdown starts at 8 seconds. The first build displays 8 seconds, and then the timer decreases the remaining time by one every second. Each timer update calls `setState()`, which causes the countdown widget to rebuild. Including the initial display and the final “Time is up!” message, the expected total is nine builds.

**A2: 9**

### A3: What is the value of `_clicks` after three taps when the bug is present?

The `bugStep` value for my roll number is 1. Each button tap adds 1 to `_clicks`. Therefore, after three taps, the internal value becomes 3. When the bug is present, the code does not call `setState()`, so the screen does not update even though the internal value changes.

**A3: 3**

### A4: What percentage is displayed in the Progress line when the app starts?

My starting count is 11 and the maximum count is 22. I calculated the percentage by dividing the starting count by the maximum count and multiplying the result by 100.

\[
\text{Percentage}=\frac{11}{22}\times100=50\%
\]

Therefore, the app initially displays 50% progress.

**A4: 50**

## Part B: Written Answers

### B1: Which classes are Stateless and which are Stateful, and why?

In my application, `LabApp`, `HomePage`, `StudentCard`, and `GoalBanner` are Stateless widgets. They are used to set up the application, arrange the screen, display student information, and show progress. They do not manage changing state of their own.

The `Tally`, `Countdown`, and `BuggyCounter` classes are Stateful widgets because they involve values that can change while the application is running. For example, the tally count changes when I press the buttons, the countdown changes every second, and the buggy counter stores the number of button clicks. Stateful widgets allow Flutter to update the user interface when their state changes.

### B2: Why must the Timer be cancelled in `dispose()`?

The timer should be cancelled in `dispose()` because it may still be running when the countdown widget is removed from the screen. If it continues running, it could try to update a widget that no longer exists, which may cause a Flutter error and waste resources.

In my code, I use `_timer.cancel()` inside `dispose()` to stop the timer before calling `super.dispose()`. This ensures that the timer is properly stopped when the widget is removed.

### B3: Which widgets in your code can be `const`, and what does `const` buy you?

Widgets with fixed values and constant constructor arguments can be declared using `const`. In my code, examples include `const Tally()`, `const Countdown()`, `const BuggyCounter()`, `const Text('Reset')`, and `const SizedBox(height: 12)`.

However, widgets that display changing values, such as `Text('Count: $_count')`, cannot be declared as constant because the count changes when the user interacts with the application.

Using `const` makes it clear that a widget's configuration will not change. Dart can reuse constant objects instead of repeatedly creating equivalent objects, which can help make the application more efficient. It also makes the code easier to understand by showing which parts have fixed values.

## Conclusion

Through this lab, I learned the difference between Stateless and Stateful widgets, how to update a user interface using `setState()`, and how a timer can update a countdown. I also learned why timers should be cancelled in `dispose()` and how `const` can be used for widgets with fixed configurations. These concepts helped me understand how Flutter manages widget state and updates the screen.