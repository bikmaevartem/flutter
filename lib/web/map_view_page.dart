import 'package:flutter/material.dart';
import 'package:flutter_mentoring/web/base_page.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapViewPage extends BasePage {

  const MapViewPage({required String title}) : super(title: title);

  @override
  Widget buildContent(BuildContext context) {
    return Center(
      child: FlutterMap(
        options: MapOptions(
          center: const LatLng(40.000000, 20.000000),
          zoom: 10,
        ),

        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),

          MarkerLayer(
            markers: [
              Marker(
                width: 40.0,
                height: 40.0,
                point: LatLng(40.0, 20.00),
                builder: (context) => const Icon(Icons.man, color: Colors.red),
              ),
            ],
          )
        ],
      ),
    );
  }

}