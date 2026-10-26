# Layout and Lifecycle Lab — Answers

**Name:** Samina Shahid  
**Roll Number:** 04072313018  
**Course:** Mobile Dev / Flutter Lab

## Part A: Numerical Answers

**A1: 22 seconds**

The Clock starts at 10 seconds and increases by 3 seconds per tick. It stops when it reaches 22 seconds.

**A2: 5 builds**

The `Clock.build()` method runs once for the initial display and four more times as the timer updates the clock from 10 to 22 seconds.

**A3: 3**

Without keys, the tile's State stays at its position in the Row. After tapping the first tile three times and pressing Swap, the left tile should display the count 3 even though its label changes. Confirm this by performing the required experiment.

**A4: 66%**

The flex values are 2 and 1. Therefore, the Expanded button receives:

\[
\left\lfloor\frac{2}{2+1}\times100\right\rfloor=66\%
\]

## Part B: Written Answers

### B1. Which classes are Stateless and which are Stateful, and why?

**Stateless classes**: LabApp, HomePage, SettingsCard, SummaryRow, Probe, Welcome, InfoPanel, ShareRow, InfoBox, and StampStack. These classes do not store changing data of their own. They mainly display information or arrange other widgets on the screen.

**Stateful classes**: Clock, Tile, and SwapBoard. These classes need to remember changing data. Clock stores the time and build count, Tile stores how many times it has been tapped, and SwapBoard stores the order of the tiles. Their State objects keep this information and allow the screen to update when changes happen.

### B2. Widget, Element, RenderObject: which one is rebuilt on every setState, and which ones are kept? What did Probe show?

A Widget describes how something should look on the screen. When setState() is called, Flutter runs build() again and may create new Widget objects. An Element connects the Widget to its position in the widget tree and usually stays the same during a rebuild. A RenderObject manages the layout, drawing, and touch handling of the interface.

In the Probe experiment, the Widget number changed when the screen rebuilt, but the Element number stayed the same. It also showed Context belongs to: Probe and Scaffold above me: true. This helped me understand that BuildContext tells us where a widget is located in the tree.

### B3. Explain “constraints go down, sizes go up” using Step 7 or Step 8.

In 'Step 7', the Row gives each Expanded widget a share of the available width. These width limits go down to the Text widgets. Each Text fits its words into that width and decides how much height it needs. Its size then goes back up to the Row. This is why the text wraps onto multiple lines instead of overflowing.

In 'Step 8', the Row first gives 150 pixels to the fixed-width button. It then divides the remaining width between Expanded and Flexible according to their flex values. Expanded must fill its share, while Flexible can use less space if its content does not need all of it.

