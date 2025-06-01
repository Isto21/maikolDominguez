import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maikol_tesis/config/theme/app_theme.dart';

class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  final Set<Polygon> _polygons = {};

  // Coordenadas de la UCI (aproximadas)
  static const LatLng _uciCenter = LatLng(23.0358, -82.5097);

  final List<GuardPoint> _guardPoints = [
    GuardPoint(
      id: 1,
      name: 'Residencia Estudiantil 1',
      position: const LatLng(23.0365, -82.5105),
      description: 'Punto de guardia principal de la residencia 1',
      isActive: true,
    ),
    GuardPoint(
      id: 2,
      name: 'Residencia Estudiantil 2',
      position: const LatLng(23.0355, -82.5095),
      description: 'Punto de guardia principal de la residencia 2',
      isActive: true,
    ),
    GuardPoint(
      id: 3,
      name: 'Biblioteca Central',
      position: const LatLng(23.0370, -82.5080),
      description: 'Punto de guardia de la biblioteca',
      isActive: false,
    ),
    GuardPoint(
      id: 4,
      name: 'Comedor Principal',
      position: const LatLng(23.0345, -82.5110),
      description: 'Punto de guardia del comedor',
      isActive: true,
    ),
    GuardPoint(
      id: 5,
      name: 'Edificio Docente 1',
      position: const LatLng(23.0380, -82.5090),
      description: 'Punto de guardia del edificio docente',
      isActive: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _createMarkers();
    _createPolygons();
  }

  void _createMarkers() {
    for (final point in _guardPoints) {
      _markers.add(
        Marker(
          markerId: MarkerId(point.id.toString()),
          position: point.position,
          infoWindow: InfoWindow(title: point.name, snippet: point.description),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            point.isActive
                ? BitmapDescriptor.hueGreen
                : BitmapDescriptor.hueRed,
          ),
          onTap: () => _showGuardPointDetails(point),
        ),
      );
    }
  }

  void _createPolygons() {
    // Polígono que representa el área de la UCI
    _polygons.add(
      Polygon(
        polygonId: const PolygonId('uci_area'),
        points: const [
          LatLng(23.0400, -82.5130),
          LatLng(23.0400, -82.5060),
          LatLng(23.0320, -82.5060),
          LatLng(23.0320, -82.5130),
        ],
        fillColor: AppTheme.primaryBlue.withOpacity(0.1),
        strokeColor: AppTheme.primaryBlue,
        strokeWidth: 2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        title: const Text('Mapa UCI'),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => _showMapLegend(),
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: const Stack(
        children: [
          // GoogleMap(
          //   onMapCreated: (GoogleMapController controller) {
          //     _mapController = controller;
          //   },
          //   initialCameraPosition: const CameraPosition(
          //     target: _uciCenter,
          //     zoom: 16.0,
          //   ),
          //   markers: _markers,
          //   polygons: _polygons,
          //   mapType: MapType.hybrid,
          //   myLocationEnabled: true,
          //   myLocationButtonEnabled: false,
          //   zoomControlsEnabled: false,
          // ),

          // Panel de información
          // Positioned(
          //   top: 16,
          //   left: 16,
          //   right: 16,
          //   child: FadeInDown(
          //     duration: const Duration(milliseconds: 800),
          //     child: Container(
          //       padding: const EdgeInsets.all(16),
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(12),
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.black.withOpacity(0.1),
          //             blurRadius: 10,
          //             offset: const Offset(0, 2),
          //           ),
          //         ],
          //       ),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           const Text(
          //             'Puntos de Guardia UCI',
          //             style: TextStyle(
          //               fontSize: 16,
          //               fontWeight: FontWeight.bold,
          //               color: AppTheme.primaryBlue,
          //             ),
          //           ),
          //           const SizedBox(height: 8),
          //           Row(
          //             children: [
          //               _buildLegendItem(Colors.green, 'Activos'),
          //               const SizedBox(width: 16),
          //               _buildLegendItem(Colors.red, 'Inactivos'),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),

          // // Botones de control
          // Positioned(
          //   bottom: 100,
          //   right: 16,
          //   child: FadeInUp(
          //     duration: const Duration(milliseconds: 800),
          //     child: Column(
          //       children: [
          //         FloatingActionButton(
          //           heroTag: 'zoom_in',
          //           onPressed: () => _zoomIn(),
          //           backgroundColor: Colors.white,
          //           foregroundColor: AppTheme.primaryBlue,
          //           mini: true,
          //           child: const Icon(Icons.zoom_in),
          //         ),
          //         const SizedBox(height: 8),
          //         FloatingActionButton(
          //           heroTag: 'zoom_out',
          //           onPressed: () => _zoomOut(),
          //           backgroundColor: Colors.white,
          //           foregroundColor: AppTheme.primaryBlue,
          //           mini: true,
          //           child: const Icon(Icons.zoom_out),
          //         ),
          //         const SizedBox(height: 8),
          //         FloatingActionButton(
          //           heroTag: 'my_location',
          //           onPressed: () => _goToMyLocation(),
          //           backgroundColor: Colors.white,
          //           foregroundColor: AppTheme.primaryBlue,
          //           mini: true,
          //           child: const Icon(Icons.my_location),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          // // Lista de puntos de guardia
          // Positioned(
          //   bottom: 16,
          //   left: 16,
          //   right: 16,
          //   child: FadeInUp(
          //     duration: const Duration(milliseconds: 800),
          //     delay: const Duration(milliseconds: 200),
          //     child: SizedBox(
          //       height: 120,
          //       child: ListView.builder(
          //         scrollDirection: Axis.horizontal,
          //         itemCount: _guardPoints.length,
          //         itemBuilder: (context, index) {
          //           final point = _guardPoints[index];
          //           return Container(
          //             width: 200,
          //             margin: const EdgeInsets.only(right: 12),
          //             padding: const EdgeInsets.all(12),
          //             decoration: BoxDecoration(
          //               color: Colors.white,
          //               borderRadius: BorderRadius.circular(12),
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: Colors.black.withOpacity(0.1),
          //                   blurRadius: 10,
          //                   offset: const Offset(0, 2),
          //                 ),
          //               ],
          //             ),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Row(
          //                   children: [
          //                     Container(
          //                       width: 12,
          //                       height: 12,
          //                       decoration: BoxDecoration(
          //                         color: point.isActive
          //                             ? Colors.green
          //                             : Colors.red,
          //                         shape: BoxShape.circle,
          //                       ),
          //                     ),
          //                     const SizedBox(width: 8),
          //                     Expanded(
          //                       child: Text(
          //                         point.name,
          //                         style: const TextStyle(
          //                           fontSize: 14,
          //                           fontWeight: FontWeight.bold,
          //                         ),
          //                         maxLines: 1,
          //                         overflow: TextOverflow.ellipsis,
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //                 const SizedBox(height: 8),
          //                 Text(
          //                   point.description,
          //                   style: TextStyle(
          //                     fontSize: 12,
          //                     color: Colors.grey[600],
          //                   ),
          //                   maxLines: 2,
          //                   overflow: TextOverflow.ellipsis,
          //                 ),
          //                 const Spacer(),
          //                 ElevatedButton(
          //                   onPressed: () => _goToPoint(point),
          //                   style: ElevatedButton.styleFrom(
          //                     backgroundColor: AppTheme.primaryBlue,
          //                     minimumSize: const Size(double.infinity, 32),
          //                   ),
          //                   child: const Text(
          //                     'Ver en Mapa',
          //                     style: TextStyle(
          //                       fontSize: 12,
          //                       color: Colors.white,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           );
          //         },
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  void _showGuardPointDetails(GuardPoint point) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: point.isActive ? Colors.green : Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    point.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              point.description,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 16),
            Text(
              'Estado: ${point.isActive ? 'Activo' : 'Inactivo'}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: point.isActive ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _goToPoint(point);
                },
                child: const Text('Centrar en Mapa'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMapLegend() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Leyenda del Mapa'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLegendRow(Colors.green, 'Puntos de guardia activos'),
            const SizedBox(height: 8),
            _buildLegendRow(Colors.red, 'Puntos de guardia inactivos'),
            const SizedBox(height: 8),
            _buildLegendRow(AppTheme.primaryBlue, 'Área de la UCI'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendRow(Color color, String description) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(description)),
      ],
    );
  }

  void _zoomIn() {
    _mapController?.animateCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut() {
    _mapController?.animateCamera(CameraUpdate.zoomOut());
  }

  void _goToMyLocation() {
    _mapController?.animateCamera(CameraUpdate.newLatLng(_uciCenter));
  }

  void _goToPoint(GuardPoint point) {
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: point.position, zoom: 18.0),
      ),
    );
  }
}

class GuardPoint {
  final int id;
  final String name;
  final LatLng position;
  final String description;
  final bool isActive;

  GuardPoint({
    required this.id,
    required this.name,
    required this.position,
    required this.description,
    required this.isActive,
  });
}
