// File: lib/screen/main/filters_screen.dart

import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  // Trạng thái cho Checkbox Preferences
  bool _makeFriends = true;
  bool _dating = false;

  // Trạng thái cho Distance Slider
  double _distance = 10;
  
  // Trạng thái cho Age Range Slider
  RangeValues _ageRange = RangeValues(20, 25);
  
  // Trạng thái cho Online now Switch
  bool _onlineNow = false;

  // Màu sắc chính
  final Color primaryRed = Color(0xFFFF5F6D);
  final Color primaryPurple = Color(0xFF5F0F40);

  // --- Widget Row Checkbox ---
  Widget _buildPreferenceCheckbox(String title, bool value, Function(bool?) onChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: primaryRed,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        Text(title, style: TextStyle(fontSize: 16)),
        SizedBox(width: 15),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Handle Bar (Thanh kéo lên/xuống)
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            
            // TIÊU ĐỀ
            Text(
              "Filters",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25),

            // --- 1. Location ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Location", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Text("People nearby", style: TextStyle(color: Colors.grey[600], fontSize: 16)),
                      Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[600]),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // --- 2. Preferences ---
            Text("Preferences", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              children: [
                _buildPreferenceCheckbox("Make Friends", _makeFriends, (bool? newValue) {
                  setState(() => _makeFriends = newValue ?? false);
                }),
                _buildPreferenceCheckbox("Dating", _dating, (bool? newValue) {
                  setState(() => _dating = newValue ?? false);
                }),
              ],
            ),
            SizedBox(height: 20),
            
            // --- 3. Distance ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Distance", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("${_distance.round()}km", style: TextStyle(color: primaryRed, fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            Slider(
              value: _distance,
              min: 0,
              max: 100,
              divisions: 100,
              activeColor: primaryRed,
              inactiveColor: primaryRed.withOpacity(0.3),
              label: '${_distance.round()}km',
              onChanged: (double value) {
                setState(() => _distance = value);
              },
            ),
            SizedBox(height: 20),

            // --- 4. Age ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Age", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("${_ageRange.start.round()}-${_ageRange.end.round()}", style: TextStyle(color: primaryRed, fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            RangeSlider(
              values: _ageRange,
              min: 18,
              max: 60,
              divisions: 42,
              activeColor: primaryRed,
              inactiveColor: primaryRed.withOpacity(0.3),
              labels: RangeLabels(_ageRange.start.round().toString(), _ageRange.end.round().toString()),
              onChanged: (RangeValues values) {
                setState(() => _ageRange = values);
              },
            ),
            SizedBox(height: 20),

            // --- 5. Online Now ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Online now", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Switch(
                  value: _onlineNow,
                  onChanged: (bool newValue) {
                    setState(() => _onlineNow = newValue);
                  },
                  activeColor: primaryRed,
                  inactiveThumbColor: Colors.grey[400],
                  inactiveTrackColor: Colors.grey[200],
                ),
              ],
            ),
            SizedBox(height: 40),

            // --- 6. Buttons (Reset & Apply) ---
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _makeFriends = true; _dating = false;
                        _distance = 10;
                        _ageRange = RangeValues(20, 25);
                        _onlineNow = false;
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey[600],
                      side: BorderSide(color: Colors.grey.shade300),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text("Reset", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Đóng modal
                      // Xử lý áp dụng bộ lọc tại đây
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryPurple,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text("Apply", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}