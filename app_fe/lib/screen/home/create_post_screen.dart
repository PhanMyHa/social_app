// File: lib/screen/main/create_post_screen.dart

import 'package:flutter/material.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  final Color primaryRed = const Color(0xFFFF5F6D);
  final Color primaryPurple = const Color(0xFF5F0F40);
  final Color lightBackground = const Color(0xFFF0F4F8); // Màu nền nhạt cho body

  // --- Danh sách Tùy chọn Đính kèm/Nội dung ---
  final List<Map<String, dynamic>> postOptions = const [
    {"title": "Add A Photo", "icon": Icons.photo_library_outlined, "color": Colors.blue},
    {"title": "Take A Video", "icon": Icons.videocam_outlined, "color": Colors.green},
    {"title": "Add A Document", "icon": Icons.link, "color": Colors.blueGrey},
    {"title": "Background Color", "icon": Icons.text_fields, "color": Colors.redAccent},
    {"title": "Gif", "icon": Icons.gif_box_outlined, "color": Colors.orange},
    {"title": "Live Video", "icon": Icons.videocam, "color": Colors.pink},
    {"title": "Cemera", "icon": Icons.camera_alt_outlined, "color": Colors.teal},
  ];

  // --- Widget Tùy chọn (ListTile) ---
  Widget _buildOptionTile(Map<String, dynamic> option) {
    return ListTile(
      leading: Icon(option["icon"], color: option["color"], size: 28),
      title: Text(option["title"], style: const TextStyle(fontSize: 16, color: Colors.black87)),
      onTap: () {
        // Xử lý hành động khi chọn tùy chọn
        print("Selected: ${option["title"]}");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground, // Nền nhạt theo ảnh
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Create a Post', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // Xử lý đăng bài
              print("Attempting to post...");
            },
            child: Text('Post', style: TextStyle(color: primaryPurple, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: Column(
        children: [
          // --- Phần Input Bài Đăng (Trắng) ---
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile & Privacy Dropdown
                  Row(
                    children: [
                      const CircleAvatar(radius: 20, backgroundColor: Colors.grey),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Text('Public', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                            Icon(Icons.arrow_drop_down, color: primaryPurple),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  
                  // Text Input Field
                  const Expanded(
                    child: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: "What's on your head?",
                        border: InputBorder.none,
                      ),
                      maxLines: null, // Cho phép nhiều dòng
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // --- Phần Tùy chọn Đính kèm (Dưới) ---
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: postOptions.map(_buildOptionTile).toList(),
            ),
          ),
          // Thêm padding cho vùng an toàn dưới cùng nếu không dùng extendBody
          SizedBox(height: MediaQuery.of(context).padding.bottom + 10),
        ],
      ),
    );
  }
}