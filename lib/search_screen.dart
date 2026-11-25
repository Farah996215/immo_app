import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; 
import 'package:latlong2/latlong.dart';       

class SearchScreen extends StatefulWidget {
  final String? initialSearchText; // Receive text from Home Screen

  const SearchScreen({super.key, this.initialSearchText});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _selectedTransaction = 'Tous';
  double _currentPrice = 1000000;
  String _selectedPropertyType = '';
  
  // Search Controller
  late TextEditingController _searchController;
  String _searchQuery = '';

  // Center point for the map (Tunis)
  final LatLng _mapCenter = const LatLng(36.8065, 10.1815); 

  // Dummy data for search results
  final List<Map<String, dynamic>> _allProperties = [
    {
      'title': 'Terrain avec vue panoramique',
      'price': '280 000 DT',
      'location': 'Ain drahem',
      'rating': '4.8',
      'reviews': '120',
      'image': 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      'lat': 36.8450, 'lng': 10.2500,
    },
    {
      'title': 'Parcelle agricole de 2 hectares',
      'price': '125 000 DT',
      'location': 'BEJA',
      'rating': '4.8',
      'reviews': '120',
      'image': 'https://images.unsplash.com/photo-1464226184884-fa280b87c399?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      'lat': 36.8300, 'lng': 10.2300,
    },
    {
      'title': 'Villa moderne avec piscine',
      'price': '850 000 DT',
      'location': 'La Marsa, Tunis',
      'rating': '4.9',
      'reviews': '85',
      'image': 'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      'lat': 36.8100, 'lng': 10.2000,
    },
  ];

  List<Map<String, dynamic>> _filteredProperties = [];

  @override
  void initState() {
    super.initState();
    // Initialize search controller with text from Home Screen
    _searchController = TextEditingController(text: widget.initialSearchText ?? '');
    _searchQuery = widget.initialSearchText ?? '';
    _filteredProperties = _allProperties; // Initially show all
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Filter logic
  void _filterResults(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredProperties = _allProperties;
      } else {
        _filteredProperties = _allProperties.where((property) {
          final title = property['title'].toString().toLowerCase();
          final location = property['location'].toString().toLowerCase();
          final lowerQuery = query.toLowerCase();
          return title.contains(lowerQuery) || location.contains(lowerQuery);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Recherche', style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
        actions: [IconButton(icon: const Icon(Icons.tune, color: Color(0xFF1E293B)), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- FILTER SECTION ---
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Real Search Input
                  Container(
                    decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                      controller: _searchController,
                      onChanged: _filterResults, // Trigger filter on typing
                      decoration: const InputDecoration(
                        hintText: 'Ville, quartier...',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _buildToggleButton('Vente'),
                      const SizedBox(width: 8),
                      _buildToggleButton('Location'),
                      const SizedBox(width: 8),
                      _buildToggleButton('Tous'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Prix (DT)', style: TextStyle(color: Colors.grey, fontSize: 13)),
                      Text('${_currentPrice.toInt()} DT', style: const TextStyle(color: Color(0xFF5E23A6), fontWeight: FontWeight.bold, fontSize: 14)),
                    ],
                  ),
                  Slider(
                    value: _currentPrice,
                    min: 0,
                    max: 2000000,
                    divisions: 200,
                    activeColor: const Color(0xFF5E23A6),
                    inactiveColor: const Color(0xFF5E23A6).withOpacity(0.2),
                    onChanged: (value) => setState(() => _currentPrice = value),
                  ),
                  const SizedBox(height: 16),
                  const Text('Type de bien', style: TextStyle(color: Colors.grey, fontSize: 13)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTypeIcon(Icons.home_outlined, 'Maison'),
                      _buildTypeIcon(Icons.apartment, 'Appartement'),
                      _buildTypeIcon(Icons.villa_outlined, 'Villa'),
                      _buildTypeIcon(Icons.landscape_outlined, 'Terrain'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5E23A6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        // Optional: Close keyboard when applying filters
                        FocusScope.of(context).unfocus();
                      },
                      child: const Text('Appliquer les filtres', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),

            // --- LIVE MAP & RESULTS SECTION ---
            Stack(
              children: [
                SizedBox(
                  height: 500,
                  width: double.infinity,
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: _mapCenter,
                      initialZoom: 12.5,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.immofinder_app',
                      ),
                      MarkerLayer(
                        markers: _filteredProperties.map((prop) {
                          return Marker(
                            point: LatLng(prop['lat'], prop['lng']),
                            width: 40,
                            height: 40,
                            child: const Icon(Icons.location_on, color: Colors.blue, size: 35),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                
                // Results Counter Badge
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2))],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Résultats (', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                        Text('${_filteredProperties.length}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF5E23A6))),
                        const Text(')', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),

                // Floating Property Card (Shows first result)
                if (_filteredProperties.isNotEmpty)
                  Positioned(
                    bottom: 20,
                    left: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 10, offset: const Offset(0, 4))],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              _filteredProperties.first['image'],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_filteredProperties.first['price'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF5E23A6))),
                                const SizedBox(height: 4),
                                Text(_filteredProperties.first['title'], maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, color: Colors.grey, size: 14),
                                    const SizedBox(width: 4),
                                    Text(_filteredProperties.first['location'], style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(String text) {
    bool isSelected = _selectedTransaction == text;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTransaction = text),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF5E23A6) : const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[700],
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeIcon(IconData icon, String label) {
    bool isSelected = _selectedPropertyType == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedPropertyType = isSelected ? '' : label),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF5E23A6).withOpacity(0.1) : const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(16),
              border: isSelected ? Border.all(color: const Color(0xFF5E23A6), width: 1.5) : null,
            ),
            child: Icon(icon, color: isSelected ? const Color(0xFF5E23A6) : Colors.grey, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? const Color(0xFF5E23A6) : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}