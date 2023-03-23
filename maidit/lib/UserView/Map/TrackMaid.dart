// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:maidit/model/MaidModel.dart';

class TrackMaid extends StatefulWidget {
  final Maid maid;
  const TrackMaid({super.key, required this.maid});

  @override
  State<TrackMaid> createState() => _TrackMaidState();
}

class _TrackMaidState extends State<TrackMaid> {
  late MapController _mapController;
  final double _maxZoom = 18.0;
  final double _minZoom = 4.0;
  late double _currentZoom = 15.0;
  final bool _isZoomInDisabled = false;
  final bool _isZoomOutDisabled = false;
  late Stream<DocumentSnapshot<Map<String, dynamic>>> _maidStream;

  void _zoomIn() {
    _mapController.move(_mapController.center, _mapController.zoom + 1);
    setState(() {
      _currentZoom += 1;
    });
  }

  void _zoomOut() {
    _mapController.move(_mapController.center, _mapController.zoom - 1);
    setState(() {
      _currentZoom -= 1;
    });
  }

  @override
  void initState() {
    _mapController = MapController();
    super.initState();
    _maidStream = FirebaseFirestore.instance
        .collection('maids')
        .doc(widget.maid.id)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              "Suivre ${widget.maid.nom.replaceFirst(widget.maid.nom.characters.first, widget.maid.nom.characters.first.toUpperCase())} ${widget.maid.prenom.replaceFirst(widget.maid.prenom.characters.first, widget.maid.prenom.characters.first.toUpperCase())}"),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios, // replace with your desired icon
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: _maidStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            // Get the maid's latitude and longitude from the snapshot
            final maidData = snapshot.data!.data()!;
            final maidLatitude = maidData['latitude'] as double?;
            final maidLongitude = maidData['longitude'] as double?;

            return FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: LatLng(maidLatitude!, maidLongitude!),
                zoom: 15,
                maxZoom: _maxZoom, // maximum zoom level
                minZoom: _minZoom, // minimum zoom level
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                  backgroundColor: Colors.white,
                  maxZoom: 20,
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80,
                      height: 80,
                      point: LatLng(maidLatitude, maidLongitude),
                      builder: (ctx) => Stack(
                        children: [
                          Positioned(
                            bottom: 10,
                            left: 15,
                            child: Icon(
                              Icons.location_on,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 30,
                            ),
                          ),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: ClipOval(
                                child: Image.network(
                                  widget.maid.photo!,
                                  fit: BoxFit.cover,
                                  width: 200,
                                  height: 200,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "zoomIn",
            onPressed: _zoomIn,
            tooltip: 'Zoom in',
            backgroundColor: _isZoomInDisabled
                ? Colors.grey
                : Theme.of(context).colorScheme.secondary,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: "zoomOut",
            onPressed: _zoomOut,
            tooltip: 'Zoom out',
            backgroundColor: _isZoomOutDisabled
                ? Colors.grey
                : Theme.of(context).colorScheme.secondary,
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
