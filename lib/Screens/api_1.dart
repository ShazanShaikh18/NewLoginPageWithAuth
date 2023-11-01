// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

// class GetApiScreen extends StatefulWidget {
//   const GetApiScreen({super.key});

//   @override
//   State<GetApiScreen> createState() => _GetApiScreenState();
// }

// class _GetApiScreenState extends State<GetApiScreen> {
//   List<dynamic> users = [];

//   @override
//   void initState() {
//     super.initState();

//     getDio();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: ListView(
//           children: users.map((e) {
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Card(
//                 elevation: 2,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       flex: 4,
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: CircleAvatar(
//                               radius: 28,
//                               backgroundImage: NetworkImage(e["avatar"]),
//                             ),
//                           ),
//                           Flexible(
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     e["name"],
//                                     style: TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   Text(
//                                     e["title"],
//                                     style: TextStyle(fontSize: 18),
//                                   ),
//                                   Chip(label: Text(e["role"]))
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             flex: 1,
//                             child: Align(
//                               alignment: Alignment.topRight,
//                               child: Text(
//                                 '\$ ${e["balance"].toString() == "null" ? "0" : e["balance"]}',
//                                 style: TextStyle(
//                                     fontSize: 20, fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }

//   void getDio() async {
//     try {
//       final response =
//           await Dio(BaseOptions(headers: {"Content-Type": "application/json"}))
//               .get('https://mock-database-f1298.web.app/api/v1/users');

//       users = response.data["users"];
//       setState(() {});
//     } catch (e) {
//       print(e);
//     }
//   }
// }
