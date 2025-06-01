// import 'package:flutter/material.dart';
// import 'package:maikol_tesis/generated/l10n.dart';

// class ChangePasswordPage extends StatelessWidget {
//   const ChangePasswordPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return SpacedScreen(
//       appBarTitle: S.of(context).Change_Password,
//       title: S.of(context).SEND_COMMENT,
//       onPressed: () {},
//       buttonChild: Text(S.of(context).ACCEPT),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextFormField(
//               decoration: InputDecoration(
//                 suffixIcon: const Icon(Icons.remove_red_eye),
//                 hintText: S.of(context).Actual_password,
//                 label: Text(" ${S.of(context).New_password}"),
//               ),
//             ),
//           ),
//           const SizedBox(height: 25),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextFormField(
//               decoration: InputDecoration(
//                 suffixIcon: const Icon(Icons.remove_red_eye),
//                 hintText: S.of(context).Enter_New_password,
//                 label: Text(" ${S.of(context).New_password}"),
//               ),
//             ),
//           ),
//           const SizedBox(height: 25),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextFormField(
//               decoration: InputDecoration(
//                 hintText: S.of(context).Enter_New_password,
//                 suffixIcon: const Icon(Icons.remove_red_eye),
//                 label: Text(" ${S.of(context).Confirm_New_password}"),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
