// File: lib/screen/main/connect_success_screen.dart

import 'package:app_fe/screen/home/profile_detail_screen.dart';
import 'package:flutter/material.dart';

// Import màn hình Chat để có thể chuyển sang khi cần
import 'chat_screen.dart';

class ConnectSuccessScreen extends StatelessWidget {
  final String partnerName;
  final String partnerLocation;
  final List<String> commonInterests;

  const ConnectSuccessScreen({
    Key? key,
    this.partnerName = "Clara",
    this.partnerLocation = "Hamburg",
    this.commonInterests = const ["Music", "Fashion", "Nature"],
  }) : super(key: key);

  final Color primaryRed = const Color(0xFFFF5F6D);
  final Color primaryPurple = const Color(0xFF5F0F40);
  final Color lightPurpleBackground = const Color(0xFFFFF7FB);

  // --- Widget Interest Chip ---
  Widget _buildInterestChip(String label) {
    // Giả định icon dựa trên label (cho đơn giản)
    IconData icon;
    switch (label) {
      case "Music":
        icon = Icons.music_note;
        break;
      case "Fashion":
        icon = Icons.woman;
        break;
      case "Nature":
        icon = Icons.eco;
        break;
      default:
        icon = Icons.star;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: const EdgeInsets.only(right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: primaryRed.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primaryRed.withOpacity(0.5), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: primaryRed, size: 16),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: primaryRed, fontSize: 14)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightPurpleBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>  ProfileDetailScreen()),
            );},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 50),
                Text(
                  "You are connected with $partnerName from $partnerLocation!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryRed),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                
                // Profile Circles Placeholder (Connected)
                SizedBox(
                  height: 150,
                  width: 300,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Circle 1 (Clara)
                      Positioned(
                        left: 50,
                        child: Column(
                          children: [
                            Container(
                              width: 100, height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade300,
                                border: Border.all(color: primaryRed, width: 4),
                              ),
                            ),
                            Text(partnerName, style: TextStyle(color: primaryRed, fontWeight: FontWeight.bold)),
                            const Text('👋', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                      // Circle 2 (You)
                      Positioned(
                        right: 50,
                        child: Column(
                          children: [
                            Container(
                              width: 100, height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade300,
                                border: Border.all(color: Colors.grey.shade300, width: 4),
                              ),
                            ),
                            const Text('You', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                            const Text('👋', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Interest Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Interest", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Wrap(
                      children: commonInterests.map(_buildInterestChip).toList(),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "You have ${commonInterests.length} things in common with $partnerName. Let's start by talking about things you both like!",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ],
            ),
            
            // Buttons
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Row(
                children: [
                  // Chat bubble icon
                  Container(
                    width: 60, height: 60,
                    margin: const EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      color: primaryRed,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
                  ),
                  // Let's talk button
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // CHUYỂN TRANG: Mở màn hình Chat
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => ChatScreen(userName: partnerName)),
                        );
                      },
                      icon: const Icon(Icons.mic, color: Colors.white),
                      label: const Text("Let's talk", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryPurple,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}