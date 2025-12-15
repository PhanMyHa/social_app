// File: lib/screen/main/chat_screen.dart

import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String userName;

  // Constructor cho phép truyền tên người dùng (ví dụ: Clara Hazel)
  const ChatScreen({Key? key, this.userName = "Clara Hazel"}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Trạng thái mô phỏng các giai đoạn giao tiếp
  // 0: Connected Screen (You connected with Clara)
  // 1: Text Input Mode
  // 2: Recording Audio
  int _chatState = 1; 

  final Color primaryRed = Color(0xFFFF5F6D);
  final Color primaryPurple = Color(0xFF5F0F40);

  // Dữ liệu mô phỏng tin nhắn (Text và Audio)
  final List<Map<String, dynamic>> messages = [
    // Text messages
    {"type": "received", "content": "Hi Nadia, Clara here! 👋", "isText": true, "time": "9:00 PM"},
    {"type": "sent", "content": "Hey Clara, Nice to meet you! 😊", "isText": true, "time": null},
    {"type": "received", "content": "You too! Seems we have same things in common here", "isText": true, "time": null},
    {"type": "sent", "content": "So what song are you currently listening to?", "isText": true, "time": "9:00 PM"},
    {"type": "received", "content": "Been listening to John Mayer's new song, Last Train Home.", "isText": true, "time": null},
    
    // Audio messages (Mô phỏng)
    {"type": "received", "content": "0:10", "isText": false, "duration": 10},
    {"type": "sent", "content": "0:37", "isText": false, "duration": 37},
    {"type": "received", "content": "0:06", "isText": false, "duration": 6},
    {"type": "sent", "content": "0:20", "isText": false, "duration": 20},
  ];

  // --- Widget Audio Message Player ---
  Widget _buildAudioMessage(String type, int duration) {
    final bool isSent = type == "sent";
    final Color bubbleColor = isSent ? primaryRed : primaryRed.withOpacity(0.15);
    final Color waveColor = isSent ? Colors.white : primaryRed;
    final Color iconColor = isSent ? Colors.white : primaryRed;

    return Row(
      mainAxisAlignment: isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          width: 150,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          margin: EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Icon(Icons.play_arrow, color: iconColor, size: 20),
              SizedBox(width: 5),
              // Mô phỏng thanh sóng âm thanh
              Expanded(
                child: Container(
                  height: 2,
                  color: waveColor.withOpacity(0.5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: duration * 2.5, // Chiều dài mô phỏng
                      height: 2,
                      color: waveColor,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5),
              Text(
                '0:${duration.toString().padLeft(2, '0')}',
                style: TextStyle(color: isSent ? Colors.white : Colors.black87, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- Widget Text Message Bubble ---
  Widget _buildTextMessage(String type, String content) {
    final bool isSent = type == "sent";
    final Color bubbleColor = isSent ? primaryRed : primaryRed.withOpacity(0.15);
    final Color textColor = isSent ? Colors.white : Colors.black87;

    return Row(
      mainAxisAlignment: isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          margin: EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(isSent ? 15 : 4),
              bottomRight: Radius.circular(isSent ? 4 : 15),
            ),
          ),
          child: Text(content, style: TextStyle(color: textColor, fontSize: 16)),
        ),
      ],
    );
  }

  // --- Widget Input Area (Bottom) ---
  Widget _buildInputArea() {
    switch (_chatState) {
      case 0:
        // Connected screen (Không có input)
        return SizedBox.shrink();

      case 2:
        // Recording/Sending Audio Mode
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Cancel Button
              TextButton.icon(
                onPressed: () => setState(() => _chatState = 1), // Quay lại Text mode
                icon: Icon(Icons.close, color: primaryRed),
                label: Text("Cancel", style: TextStyle(color: primaryRed, fontSize: 16)),
              ),
              
              // Audio Wave Placeholder
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text("Voice recording...", style: TextStyle(color: Colors.grey[600])),
                ),
              ),
              
              // Send Button
              CircleAvatar(
                backgroundColor: primaryRed,
                child: IconButton(
                  icon: Icon(Icons.send, color: Colors.white),
                  onPressed: () => setState(() => _chatState = 1), // Gửi và quay lại
                ),
              ),
            ],
          ),
        );
        
      case 1:
      default:
        // Text Input Mode
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
          ),
          child: Row(
            children: [
              // Attachments
              Icon(Icons.attach_file, color: Colors.grey[600]),
              SizedBox(width: 10),
              // Text Field
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Type your message...",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              // Microphone/Send
              GestureDetector(
                onTap: () => setState(() => _chatState = 2), // Chuyển sang Audio mode
                child: CircleAvatar(
                  backgroundColor: primaryRed,
                  child: Icon(Icons.mic, color: Colors.white),
                ),
              ),
            ],
          ),
        );
    }
  }

  // --- Widget Connected Screen (First frame in image_611abd.png) ---
  Widget _buildConnectedScreen() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 50, bottom: 40, left: 20, right: 20),
      color: primaryPurple,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "You connected with ${widget.userName}",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            "11 mins ago",
            style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.7)),
          ),
          SizedBox(height: 30),
          
          // Profile Circle
          Container(
            width: 150, height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: primaryRed, width: 4),
            ),
            child: Center(child: Container(width: 120, height: 120, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade300))),
          ),
          SizedBox(height: 40),

          // Read Receipts
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: primaryRed, size: 20),
              SizedBox(width: 8),
              Text("Get Read Receipts", style: TextStyle(color: primaryRed, fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryPurple,
      appBar: AppBar(
        backgroundColor: primaryPurple,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.userName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.more_horiz, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                // Placeholder for background swirl pattern
                image: DecorationImage(
                  image: AssetImage('assets/swirl_pattern_placeholder.png'), // Thay thế bằng ảnh thực tế nếu có
                  fit: BoxFit.cover,
                  repeat: ImageRepeat.repeat,
                  colorFilter: ColorFilter.mode(primaryPurple.withOpacity(0.1), BlendMode.dstATop),
                ),
              ),
              child: ListView.builder(
                reverse: true, // Hiển thị tin nhắn mới nhất ở dưới
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                itemCount: _chatState == 0 ? 1 : messages.length, 
                itemBuilder: (context, index) {
                  if (_chatState == 0) {
                    return _buildConnectedScreen(); // Chỉ hiển thị màn hình Connected
                  }
                  
                  final data = messages[messages.length - 1 - index]; // Đảo ngược thứ tự
                  
                  if (data['time'] != null && index != 0) {
                      // Mô phỏng hiển thị thời gian cách quãng
                      // return Center(child: Text(data['time'], style: TextStyle(color: Colors.grey, fontSize: 12)));
                  }

                  if (data['isText']) {
                    return _buildTextMessage(data['type'], data['content']);
                  } else {
                    return _buildAudioMessage(data['type'], data['duration']);
                  }
                },
              ),
            ),
          ),
          // Input Area
          _buildInputArea(),
        ],
      ),
      // Màn hình chi tiết thường không có Navbar
    );
  }
}