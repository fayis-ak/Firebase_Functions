// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Bottom Navigation with Radio Buttons',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Bottom Navigation with Radio Buttons'),
//       ),
//       body: Center(
//         child: Text(
//           'Selected Index: $_selectedIndex',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             Radio(
//               value: 0,
//               groupValue: _selectedIndex,
//               onChanged: _onItemTapped,
//             ),
//             Radio(
//               value: 1,
//               groupValue: _selectedIndex,
//               onChanged: _onItemTapped,
//             ),
//             Radio(
//               value: 2,
//               groupValue: _selectedIndex,
//               onChanged: _onItemTapped,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
