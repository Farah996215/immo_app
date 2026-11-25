import 'package:flutter/material.dart';
import 'favorites_screen.dart';
import 'messages_screen.dart';
import 'profile_screen.dart';
import 'add_listing_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final Color primaryPurple = const Color(0xFF5E23A6);
  
  final TextEditingController _homeSearchController = TextEditingController();

  // Data for all properties
  final List<Map<String, dynamic>> _allProperties = [
    {
      'id': 0,
      'title': 'Terrain avec vue panoramique',
      'price': '280 000 DT',
      'location': 'Ain drahem',
      'rating': '4.8',
      'reviews': '120',
      'image': 'assets/house1.jpg', // Ensure this matches your assets
    },
    {
      'id': 1,
      'title': 'Parcelle agricole de 2 hectares',
      'price': '125 000 DT',
      'location': 'BEJA',
      'rating': '4.8',
      'reviews': '120',
      'image': 'assets/house2.jpg', // Ensure this matches your assets
    },
  ];

  // This list will store the properties that the user clicked the heart on
  final List<Map<String, dynamic>> _favoriteItems = [];

  @override
  void dispose() {
    _homeSearchController.dispose();
    super.dispose();
  }

  // Toggle favorite logic
  void _toggleFavorite(Map<String, dynamic> property) {
    setState(() {
      // Check if the property is already in the favorites list
      final exists = _favoriteItems.any((item) => item['id'] == property['id']);
      
      if (exists) {
        // Remove it if it exists
        _favoriteItems.removeWhere((item) => item['id'] == property['id']);
      } else {
        // Add it if it doesn't exist
        _favoriteItems.add(property);
      }
    });
  }

  Widget _getBody() {
    switch (_currentIndex) {
      case 0: 
        return _buildHomeContent();
      case 1: 
        // Pass the favorite items to the FavoritesScreen
        return FavoritesScreen(favoriteProperties: _favoriteItems); 
      case 3: 
        return const MessagesScreen(); 
      case 4: 
        return const ProfileScreen(); 
      default: 
        return _buildHomeContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _currentIndex == 0 ? _buildHomeContent() : _getBody(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 2) return; // Ignore middle + button
          setState(() => _currentIndex = index);
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryPurple,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favoris'),
          BottomNavigationBarItem(icon: Icon(Icons.circle, color: Colors.transparent), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profil'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddListingScreen()));
        },
        backgroundColor: primaryPurple,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.location_on, color: Colors.black87, size: 20),
                  SizedBox(width: 4),
                  Text('Tunis', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              IconButton(icon: const Icon(Icons.notifications_none, size: 28), onPressed: () {}),
            ],
          ),
          const SizedBox(height: 16),
          
          // Search Bar
          Container(
            decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(12)),
            child: TextField(
              controller: _homeSearchController,
              readOnly: true,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
              decoration: const InputDecoration(
                hintText: 'Rechercher un bien...',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Categories
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCategoryItem(Icons.location_on_outlined, 'Vente', const Color(0xFFF3E8FF), primaryPurple),
              _buildCategoryItem(Icons.location_on_outlined, 'Location', const Color(0xFFFFF3E0), Colors.orange),
              _buildCategoryItem(Icons.location_on_outlined, 'Neuf', const Color(0xFFE3F2FD), Colors.blue),
              _buildCategoryItem(Icons.location_on_outlined, 'Terrain', const Color(0xFFE8F5E9), Colors.green),
            ],
          ),
          const SizedBox(height: 24),
          
          // Banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: primaryPurple, borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Trouvez la maison\nde vos rêves', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, height: 1.2)),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: primaryPurple,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const SearchScreen()),
                          );
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Découvrir', style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(width: 4),
                            Icon(Icons.arrow_forward, size: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset('assets/house1.jpg', width: 100, height: 100, fit: BoxFit.cover),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Annonces populaires', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Voir tout', style: TextStyle(fontSize: 14, color: primaryPurple, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 16),
          
          // Property Cards (Iterating over the _allProperties list)
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _allProperties.length,
              itemBuilder: (context, index) {
                final property = _allProperties[index];
                // Check if this property is currently in the favorites list
                final isFavorite = _favoriteItems.any((item) => item['id'] == property['id']);
                
                return _buildPropertyCard(
                  property: property,
                  isFavorite: isFavorite,
                  onFavoriteToggle: () => _toggleFavorite(property),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label, Color bgColor, Color iconColor) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(16)),
          child: Icon(icon, color: iconColor, size: 28),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildPropertyCard({
    required Map<String, dynamic> property,
    required bool isFavorite,
    required VoidCallback onFavoriteToggle,
  }) {
    return Container(
      width: 240,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  property['image'], 
                  height: 140, 
                  width: double.infinity, 
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: onFavoriteToggle,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border, 
                      size: 20, 
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(property['price'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryPurple)),
                const SizedBox(height: 4),
                Text(property['title'], maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(property['location'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text('${property['rating']} (${property['reviews']} avis)', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}