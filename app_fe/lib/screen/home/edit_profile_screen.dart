// File: lib/screen/main/edit_profile_screen.dart

import 'package:app_fe/screen/home/mainscreen.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final Color primaryRed = Color(0xFFFF5F6D);
  final Color primaryPurple = Color(0xFF5F0F40);

  // Dữ liệu mô phỏng sở thích và mô tả
  List<String> selectedInterests = [
    'Photography',
    'Music',
    'Fashion',
    'Read Book',
  ];
  Map<String, String> interestDescriptions = {
    'Photography': 'I love taking photo because so and soon...',
    'Music': 'I love music so and so etc.',
  };

  // --- Widget Photo Placeholder ---
  Widget _buildPhotoPlaceholder(BuildContext context, {bool isMain = false}) {
    return Container(
      width: isMain ? double.infinity : 100,
      height: isMain ? 200 : 100,
      margin: isMain ? EdgeInsets.zero : EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person, size: 40, color: Colors.grey.shade500),
            if (!isMain)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: primaryRed.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, color: primaryRed, size: 14),
                    Text(
                      'Add',
                      style: TextStyle(color: primaryRed, fontSize: 12),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // --- Widget Editable Chip (My Interests) ---
  Widget _buildEditableChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: EdgeInsets.only(right: 8, bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: TextStyle(color: Colors.black87, fontSize: 14)),
          SizedBox(width: 5),
          Icon(Icons.close, size: 14, color: Colors.grey[600]),
        ],
      ),
    );
  }

  // --- Widget Interest Description Field ---
  Widget _buildDescriptionField(String interest) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          interest,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        TextFormField(
          initialValue: interestDescriptions[interest],
          maxLines: 3,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.all(12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            suffix: Text(
              '71/250',
              style: TextStyle(color: primaryRed, fontSize: 12),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  // --- Widget Profile Field ---
  Widget _buildProfileField(
    String label, {
    String initialValue = '',
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        initialValue: initialValue,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[700]),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
            );
          },
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Photo Section ---
            _buildPhotoPlaceholder(context, isMain: true),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildPhotoPlaceholder(context),
                _buildPhotoPlaceholder(context),
                _buildPhotoPlaceholder(context),
              ],
            ),
            SizedBox(height: 30),

            // --- Personal Details ---
            Text(
              'PERSONAL DETAILS',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 10),

            _buildProfileField('Full Name', initialValue: 'Nadia Lipshutz'),
            _buildProfileField(
              'Birthdate',
              initialValue: '20/10/2000',
              readOnly: true,
            ),

            // --- About ---
            Text(
              'About',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              initialValue:
                  'A good listener. I love having a good talk to know each other\'s side 😊.',
              maxLines: 3,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffix: Text(
                  '71/250',
                  style: TextStyle(color: primaryRed, fontSize: 12),
                ),
              ),
            ),
            SizedBox(height: 20),

            // --- My Interests ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Interests',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Edit', style: TextStyle(color: primaryRed)),
                ),
              ],
            ),
            Wrap(children: selectedInterests.map(_buildEditableChip).toList()),
            SizedBox(height: 20),

            // --- Describe Interests ---
            Text(
              'Describe my interested',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            ...interestDescriptions.keys
                .map((interest) => _buildDescriptionField(interest))
                .toList(),

            // --- Location & Gender ---
            _buildProfileField(
              'Location',
              initialValue: 'Hamburg, Germany',
              readOnly: true,
            ),
            _buildProfileField('Gender', initialValue: 'Woman', readOnly: true),

            SizedBox(height: 40),

            // --- Save Changes Button ---
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Quay lại màn hình Account Profile
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryPurple,
                padding: EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(
                'Save Changes',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
