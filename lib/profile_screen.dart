import 'package:flutter/material.dart';
import 'login_screen.dart'; // <-- Imported to handle logout navigation

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // State for the Notifications toggle switch
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA), // Very light grey background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header (Title & Edit Icon)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Mon profil',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, color: Color(0xFF5E23A6)),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // 2. Profile Banner (Purple Gradient Card)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF7B1FA2), Color(0xFFAB47BC)], // Purple gradient
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    // Avatar Circle
                    Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        color: Colors.purpleAccent.withOpacity(0.3),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'S',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // User Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'saif eddine ben saelm',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'bensalemsaif016@gmail.com',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '21425573',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Small Edit Icon inside banner
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white, size: 20),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 3. Stats Row (Annonces, Favoris, Note)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatCard(Icons.home_outlined, '0', 'Annonces', const Color(0xFF5E23A6)),
                  _buildStatCard(Icons.favorite_border, '0', 'Favoris', const Color(0xFF5E23A6)),
                  _buildStatCard(Icons.star_border, '4.8', 'Note', const Color(0xFF5E23A6)),
                ],
              ),
              const SizedBox(height: 32),

              // 4. "Mon espace" Section
              const Text(
                'Mon espace',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 12),
              
              _buildMenuItem(
                icon: Icons.home_outlined,
                iconBgColor: const Color(0xFFF3E8FF),
                iconColor: const Color(0xFF5E23A6),
                title: 'Mes annonces',
                subtitle: 'Gérer et publier vos biens',
              ),
              const SizedBox(height: 12),
              
              _buildMenuItem(
                icon: Icons.favorite_border,
                iconBgColor: const Color(0xFFFFEBEE),
                iconColor: const Color(0xFFE57373),
                title: 'Mes favoris',
                subtitle: 'Les biens que vous avez enregistrés',
              ),
              const SizedBox(height: 12),
              
              _buildMenuItem(
                icon: Icons.mail_outline,
                iconBgColor: const Color(0xFFE3F2FD),
                iconColor: const Color(0xFF64B5F6),
                title: 'Informations personnelles',
                subtitle: 'Nom, email et téléphone',
              ),
              
              const SizedBox(height: 32),
              
              // 5. "Préférences" Section
              const Text(
                'Préférences',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 12),

              // Notifications Toggle
              _buildMenuItem(
                icon: Icons.notifications_none,
                iconBgColor: const Color(0xFFFFF8E1), // Light yellow
                iconColor: const Color(0xFFFFB300),   // Amber
                title: 'Notifications',
                subtitle: 'Nouveaux messages et annonces',
                trailing: Switch(
                  value: _notificationsEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                  activeColor: Colors.white,
                  activeTrackColor: const Color(0xFF5E23A6), // Purple track
                ),
              ),
              const SizedBox(height: 12),

              _buildMenuItem(
                icon: Icons.help_outline,
                iconBgColor: const Color(0xFFE0F2F1), // Light teal
                iconColor: const Color(0xFF26A69A),   // Teal
                title: "Centre d'aide",
                subtitle: 'Questions fréquentes et assistance',
              ),
              const SizedBox(height: 12),

              _buildMenuItem(
                icon: Icons.shield_outlined,
                iconBgColor: const Color(0xFFF5F5F5), // Light grey
                iconColor: const Color(0xFF757575),   // Grey
                title: 'Confidentialité',
                subtitle: 'Consulter la politique de confidentialité',
              ),

              const SizedBox(height: 40),

              // 6. Logout Button
              Center(
                child: TextButton.icon(
                  onPressed: () {
                    // Navigate back to Login Screen and clear the navigation stack
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text(
                    'Se déconnecter',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for the top 3 stats (Annonces, Favoris, Note)
  Widget _buildStatCard(IconData icon, String value, String label, Color iconColor) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for the list items
  Widget _buildMenuItem({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String subtitle,
    Widget? trailing, // Added optional trailing widget for the switch
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: Color(0xFF1E293B),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            subtitle,
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ),
        trailing: trailing ?? const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {
          // Navigation logic later
        },
      ),
    );
  }
}