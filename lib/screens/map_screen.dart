import 'package:campus_3d_navigation/config/icons/app_icons.dart';
import 'package:campus_3d_navigation/helpers/permission_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapboxMap? _mapboxMap;

  // Define Babcock University Bounds

  final Position southwest = Position(6.8950, 3.7170); // Bottom-left corner
  final Position northeast = Position(6.9045, 3.7305); // Top-right corner

  @override
  void initState() {
    super.initState();
    PermissionHelper.requestLocationPermission();
  }

  @override
  void dispose() {
    super.dispose();
    _mapboxMap?.dispose();
  }

  void _onMapCreated(MapboxMap mapboxMap) async {
    _mapboxMap = mapboxMap;

    // Set Custom Puck
    final ByteData bytes = await rootBundle.load(AppIcons.puck);
    final Uint8List list = bytes.buffer.asUint8List();
    _mapboxMap?.location.updateSettings(
      LocationComponentSettings(
        locationPuck: LocationPuck(
          locationPuck2D: DefaultLocationPuck2D(
            topImage: list,
            shadowImage: Uint8List.fromList([]),
          ),
        ),
      ),
    );

    // Apply Bounding Box Constraint
    // _mapboxMap?.setBounds(
    //   CameraBoundsOptions(
    //     bounds: CoordinateBounds(
    //       southwest: Point(coordinates: southwest),
    //       northeast: Point(coordinates: northeast),
    //       infiniteBounds: false,
    //     ),
    //     maxZoom: 18,
    //     minZoom: 14,
    //   ),
    // );

    // Set Map Style
    // _mapboxMap?.style.setStyleImportConfigProperty(
    //   "basemap",
    //   "lightPreset",
    //   "dusk",
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapWidget(
        styleUri: MapboxStyles.STANDARD,
        cameraOptions: CameraOptions(
          center: Point(
            coordinates: Position(6.0033416748046875, 43.70908256335716),
          ),
          zoom: 3,
          bearing: 0,
          pitch: 45,
        ),
        onMapCreated: _onMapCreated,
      ),
    );
  }
}
