class Message {
  final String senderId;
  final String senderEmail;
  final String recieverId;
  final String message;
  final DateTime timestamp;

  const Message({
    required this.senderEmail, 
    required this.senderId,
    required this.recieverId,
    required this.message,
    required this.timestamp,
  });

  factory Message.fromJson(String chatId, Map<String, dynamic> json) {
    final List<String> ids = chatId.split('_');
    if (ids.length != 2) {
      throw Exception('Invalid chatId');
    }

    return Message(
      senderEmail: json['senderEmail'],
      senderId: ids[0],
      recieverId: ids[1],
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

 // to Json
}



