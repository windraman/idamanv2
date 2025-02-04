// import "package:flutter/material.dart";
// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
//
// class Body extends StatefulWidget {
//   const Body({Key? key}) : super(key: key);
//
//   @override
//   State<Body> createState() => _BodyState();
// }
//
// class _BodyState extends State<Body> {
//   MapController controller = MapController(
//     initMapWithUserPosition: false,
//     initPosition: GeoPoint(latitude: 14.599512, longitude: 120.984222),
//     areaLimit: const BoundingBox.world(),
//   );
//
//   @override
//   void initState() {
//     super.initState();
//     // controller = MapController.withPosition(
//     //   initPosition: GeoPoint(
//     //     latitude: 47.4358055,
//     //     longitude: 8.4737324
//     //     ,),s
//     //   areaLimit: BoundingBox(
//     //     east: 10.4922941,
//     //     north: 47.8084648,
//     //     south: 45.817995,
//     //     west:  5.9559113,
//     //   ),
//     // );
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         OSMFlutter(
//           controller: controller,
//           trackMyPosition: true,
//           initZoom: 15,
//           stepZoom: 1.0,
//           userLocationMarker: UserLocationMaker(
//             personMarker: const MarkerIcon(
//               icon: Icon(
//                 Icons.location_history_rounded,
//                 color: Colors.red,
//                 size: 48,
//               ),
//             ),
//             directionArrowMarker: const MarkerIcon(
//               icon: Icon(
//                 Icons.double_arrow,
//                 size: 48,
//               ),
//             ),
//           ),
//           markerOption: MarkerOption(
//               defaultMarker: const MarkerIcon(
//                 icon: Icon(
//                   Icons.person_pin_circle,
//                   color: Colors.blue,
//                   size: 56,
//                 ),
//               )
//           ),
//         )
//       ],
//     );
//   }
// }
//
//
//
//
