// File: lib/screen/main/match_success_screen.dart

import 'package:app_fe/screen/home/connect_success_screen.dart';
import 'package:app_fe/screen/home/messages_screen.dart';
import 'package:app_fe/screen/home/profile_detail_screen.dart';
import 'package:flutter/material.dart';


class MatchSuccessScreen extends StatelessWidget {
  final String partnerName;
  final int matchPercent;

  const MatchSuccessScreen({
    Key? key,
    this.partnerName = "Alfredo",
    this.matchPercent = 80,
  }) : super(key: key);

  final Color primaryRed = const Color(0xFFFF5F6D);
  final Color primaryPurple = const Color(0xFF5F0F40);
  final Color lightPurpleBackground = const Color(0xFFFFF7FB);

  // --- Widget Buttons Area (Send a message / Keep swiping) ---
  Widget _buildButtonsArea(BuildContext context) {
    return Column(
      children: [
        // Send a message button (Chuyển sang màn hình Connect hoặc Chat)
        ElevatedButton.icon(
          onPressed: () {
            // Giả định chuyển sang màn hình Connect Success để xem điểm chung
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>  MessagesScreen()),
            );
          },
          icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
          label: const Text('Send a message', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryPurple,
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            minimumSize: const Size(double.infinity, 50),
          ),
        ),
        const SizedBox(height: 15),
        // Keep swiping button
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ConnectSuccessScreen()),
            );
          },
          icon: Icon(Icons.favorite_border, color: primaryRed),
          label: Text('Keep swiping', style: TextStyle(fontSize: primaryRed.value == const Color(0xFFFF5F6D).value ? 18 : 16, color: primaryRed, fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: Colors.grey.shade300, width: 2),
            ),
            minimumSize: const Size(double.infinity, 50),
            elevation: 0,
          ),
        ),
      ],
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
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: (){Navigator.pushReplacement(
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
                  "You and $partnerName liked each other!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryRed),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                
                // Profile Circles Placeholder
                SizedBox(
                  height: 200,
                  width: 300,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Circle 1 (You)
                      Positioned(
                        left: 10,
                        child: Container(
                          width: 150, height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade300,
                            border: Border.all(color: primaryRed, width: 4),
                          ),
                        ),
                      ),
                      // Circle 2 (Partner)
                      Positioned(
                        right: 10,
                        child: Container(
                          width: 150, height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade300,
                            border: Border.all(color: Colors.grey.shade300, width: 4),
                          ),
                        ),
                      ),
                      // Match Percentage
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: primaryPurple,
                        child: Text('$matchPercent%', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Buttons
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: _buildButtonsArea(context),
            ),
          ],
        ),
      ),
    );
  }
}