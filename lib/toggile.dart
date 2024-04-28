// import 'package:captura_lens/user/user_home.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import '../constants.dart';
// import '../forgot_password.dart';

// class UserLoginSignUp extends StatefulWidget {
//   const UserLoginSignUp({super.key});

//   @override
//   State<UserLoginSignUp> createState() => _UserLoginSignUpState();
// }

// class _UserLoginSignUpState extends State<UserLoginSignUp> {
//   bool _isLogin = true;
//   bool _isChecked = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         leading: Icon(
//           Icons.arrow_back,
//           color: CupertinoColors.white,
//         ),
//         backgroundColor: CupertinoColors.black,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               color: CupertinoColors.black,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           _isLogin
//                               ? 'Go ahead and setup Your account'
//                               : 'Register yourself',
//                           style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18.0,
//                               color: CupertinoColors.white),
//                         ),
//                         Text(
//                           _isLogin
//                               ? 'Sign in-up to enjoy the best managing experience'
//                               : 'Complete the form below to get start',
//                           style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 10.0,
//                               color: CupertinoColors.systemGrey4),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20), color: Colors.white),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           _isLogin = !_isLogin;
//                         });
//                       },
//                       child: Container(
//                         width: double.maxFinite,
//                         height: 50.0,
//                         decoration: BoxDecoration(
//                           color: Colors.grey,
//                           borderRadius: BorderRadius.circular(34.0),
//                         ),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 'Login',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   color: _isLogin
//                                       ? Colors.black
//                                       : CustomColors.buttonGrey,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 'Register',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   color: _isLogin
//                                       ? CustomColors.buttonGrey
//                                       : Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   const TextField(
//                     decoration: InputDecoration(
//                         prefixIcon: Icon(
//                           Icons.mail_outline,
//                           color: CustomColors.buttonGreen,
//                         ),
//                         hintText: 'Email Address',
//                         border: OutlineInputBorder()),
//                   ),
//                   const SizedBox(height: 20.0),
//                   const TextField(
//                     decoration: InputDecoration(
//                         hintText: 'Password',
//                         prefixIcon: Icon(
//                           Icons.lock_outline,
//                           color: CustomColors.buttonGreen,
//                         ),
//                         border: OutlineInputBorder()),
//                     obscureText: true,
//                   ),
//                   const SizedBox(height: 20.0),
//                   if (!_isLogin)
//                     const TextField(
//                       decoration: InputDecoration(
//                           hintText: 'Confirm Password',
//                           prefixIcon: Icon(
//                             Icons.lock_outline,
//                             color: CustomColors.buttonGreen,
//                           ),
//                           border: OutlineInputBorder()),
//                       obscureText: true,
//                     ),
//                   const SizedBox(height: 20.0),
//                   if (!_isLogin)
//                     const TextField(
//                       decoration: InputDecoration(
//                           hintText: 'Place',
//                           prefixIcon: Icon(
//                             Icons.location_on,
//                             color: CustomColors.buttonGreen,
//                           ),
//                           border: OutlineInputBorder()),
//                     ),
//                   const SizedBox(height: 20.0),
//                   if (!_isLogin)
//                     const TextField(
//                       decoration: InputDecoration(
//                           hintText: 'Contact Number',
//                           prefixIcon: Icon(
//                             Icons.phone_android,
//                             color: CustomColors.buttonGreen,
//                           ),
//                           border: OutlineInputBorder()),
//                       keyboardType: TextInputType.number,
//                     ),
//                   const SizedBox(
//                     height: 20.0,
//                   ),
//                   if (_isLogin)
//                     Row(
//                       children: [
//                         Checkbox(
//                             value: _isChecked,
//                             onChanged: (bool? value) {
//                               setState(() {
//                                 _isChecked = value!;
//                               });
//                             }),
//                         Text(
//                           "Remember Me",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         Spacer(),
//                         TextButton(
//                             onPressed: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => ForgotPassword()));
//                             },
//                             child: Text("Forgot Password?"))
//                       ],
//                     ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       setState(() {
//                         _isLogin = !_isLogin;
//                       });
//                     },
//                     child: Text(
//                       _isLogin
//                           ? 'Create a new account? Register'
//                           : 'Already have an account? Login',
//                       style: TextStyle(color: Colors.blue),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(4),
//                     child: TextButton(
//                       style: TextButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 12, horizontal: 40),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                           foregroundColor: Colors.white,
//                           backgroundColor: CustomColors.buttonGreen),
//                       onPressed: () {
//                         _isLogin
//                             ? Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const UserHome()))
//                             : Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const UserHome()));
//                       },
//                       child: Text(_isLogin ? 'Login' : 'Register'),
//                     ),
//                   ),
//                   SizedBox(height: 20.0),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }