
# 时-分：showTimePicker()
```dart
showTimePicker(
  initialTime: TimeOfDay(hour: 23, minute: 11),
  context: context,
).then((value) {
    print(value.runtimeType);
    print('value = $value');
});
```

## Return value

> 异步

The returned `Future` resolves to the date selected by the user when the user confirms the dialog. 
If the user cancels the dialog, `null` is returned.

> TimeOfDay

```dart
TimeOfDay now = TimeOfDay.now();
const TimeOfDay releaseTime = TimeOfDay(hour: 15, minute: 0); // 3:00pm
TimeOfDay roomBooked = TimeOfDay.fromDateTime(DateTime.parse('2018-10-20 16:30:04Z')); // 4:30pm
```
```dart
// 返回值value，可能是null
// error：The property 'hour' can't be unconditionally accessed because the receiver can be 'null'
// int hour = value.hour;
int hour = value!.hour;
int minute = value!.minute;
```

## Cases

默认是上午下午的12小时制，想要24小时，就用加一个参数builder
```dart
builder: (BuildContext context, Widget? child) {
    return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(alwaysUse24HourFormat: true),
        child: child!,
    );
},
```

# 年-月-日: showDatePicker()
```dart
showDatePicker(
    context: context,
    firstDate: DateTime(2022, 4, 18),
    initialDate: DateTime(2022, 4, 19),
    lastDate: DateTime(2022, 4, 30),
).then((value) {
    print(value.runtimeType);
    print('value = $value');
});
```
## Return value
> 异步
一样。
The returned `Future` resolves to the date selected by the user when the user confirms the dialog. 
If the user cancels the dialog, `null` is returned.

> DateTime

```dart
final now = DateTime.now();
// year is required, other is default 0 or 1, i.e.1-1-00:00:00.
final berlinWallFell = DateTime(1989, 11, 9);
final moonLanding = DateTime.parse('1969-07-20 20:18:04'); // 8:18pm
```
Input Format and Output Format

```dart
import 'package:intl/intl.dart';
DateFormat inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
DateTime dateTime = inputFormat.parse("18-08-2019 20:59:59");
DateFormat outputFormat = DateFormat("HH:mm:ss");
String dateInString = outputFormat.format(dateTime); //  20:59:59

```
Day and month values begin at 1, and the week starts on Monday.
```dart
print(berlinWallFell.year); // 1989
print(berlinWallFell.month); // 11
print(berlinWallFell.day); // 9
print(moonLanding.hour); // 20
print(moonLanding.minute); // 18
```
Use the `add` and `subtract` methods with a Duration object 
```dart
final now = DateTime.now();
final later = now.add(const Duration(hours: 36));   // days hours minutes seconds milliseconds microseconds 
final later = now.subtract(const Duration(hours: 36));
```
To find out how much time is between two `DateTime` objects use `difference`, which returns a `Duration` object
```dart
final a = DateTime(2022, 1, 1);
final b = DateTime(2022, 2, 1);
// b - a
final difference = b.difference(a);
print(difference.inDays); // 31。如果a.difference(b);就是-31
```

- `difference(DateTime other)` → Duration
Returns a Duration with the difference when subtracting other from this. [...]
- `isAfter(DateTime other)` → bool
Returns true if this occurs after other. [...]
- `isAtSameMomentAs(DateTime other)` → bool
Returns true if this occurs at the same moment as other. [...]
- `isBefore(DateTime other)` → bool
Returns true if this occurs before other. [...]

> Duration

```dart
final c = Duration(days: 1, hours: 1, minutes: -5);
print(c.inDays); // 1
print(c.inHours); // 24
print(c.inMinutes); // 1495
print(c.inSeconds); // 89700
print(c.inMilliseconds); // 89700000
print(c.inMicroseconds); // 89700000000
```
获取单个属性
```dart
final a = DateTime(0);
final b = Duration(hours: 1, minutes: -5);
var c = a.add(b);
print(c.minute);
```
```dart
const firstHalf = Duration(minutes: 45); // 00:45:00.000000
const secondHalf = Duration(minutes: 45); // 00:45:00.000000
const overTime = Duration(minutes: 30); // 00:30:00.000000
final maxGameTime = firstHalf + secondHalf + overTime;
print(maxGameTime.inMinutes); // 120

// The duration of the firstHalf and secondHalf is the same, returns 0.
var result = firstHalf.compareTo(secondHalf);
print(result); // 0

// Duration of overTime is shorter than firstHalf, returns < 0.
result = overTime.compareTo(firstHalf);
print(result); // -1

// Duration of secondHalf is longer than overTime, returns > 0.
result = secondHalf.compareTo(overTime);
print(result); // 1
```
## Cases

- currentDate

The `currentDate` represents the current day (i.e. today). 
If null, the date of `DateTime.now()` will be used.

- helpText

`helpText`, label displayed at the top of the dialog.

- initialDatePickerMode
`DatePickerMode.year` or `DatePickerMode.day`(default).
前者先选年，再选日子。后者直接选日子，可以手动选年份。
