import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // App Bar with Title and New Message Icon
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Messages',
          style: TextStyle(
            color: Color(0xFF1E293B), // Dark text
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit_outlined, 
              color: Color(0xFF5E23A6), // Purple icon
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5), // Light grey
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Rechercher...',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),

          // List of Messages
          Expanded(
            child: ListView(
              children: [
                _buildMessageTile(
                  initial: 'T',
                  name: 'test',
                  message: 'CC',
                  date: '24 nov.',
                  avatarBgColor: const Color(0xFFF3E8FF), // Light purple
                  avatarTextColor: const Color(0xFF5E23A6),
                ),
                const Divider(height: 1, color: Color(0xFFF0F0F0)),
                _buildMessageTile(
                  initial: 'G',
                  name: 'GHOFRAN',
                  message: 'HI',
                  date: '24 nov.',
                  avatarBgColor: const Color(0xFFF3E8FF),
                  avatarTextColor: const Color(0xFF5E23A6),
                ),
                const Divider(height: 1, color: Color(0xFFF0F0F0)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to build each message row
  Widget _buildMessageTile({
    required String initial,
    required String name,
    required String message,
    required String date,
    required Color avatarBgColor,
    required Color avatarTextColor,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: avatarBgColor,
        child: Text(
          initial,
          style: TextStyle(
            color: avatarTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Color(0xFF1E293B),
        ),
      ),
      subtitle: Text(
        message,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
      ),
      trailing: Text(
        date,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      ),
      onTap: () {
        // Navigate to the specific chat screen later
      },
    );
  }
}