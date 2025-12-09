import 'package:rentverse/features/chat/domain/entity/chat_conversation_entity.dart';

class ChatConversationModel {
  final String id;
  final String propertyId;
  final String propertyTitle;
  final String propertyCity;
  final String otherUserName;
  final String? otherUserAvatar;
  final String lastMessage;
  final DateTime lastMessageAt;
  final int unreadCount;

  const ChatConversationModel({
    required this.id,
    required this.propertyId,
    required this.propertyTitle,
    required this.propertyCity,
    required this.otherUserName,
    required this.otherUserAvatar,
    required this.lastMessage,
    required this.lastMessageAt,
    this.unreadCount = 0,
  });

  factory ChatConversationModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;

    return ChatConversationModel(
      id: (data['id'] ?? data['_id'] ?? '').toString(),
      propertyId: (data['propertyId'] ?? data['property_id'] ?? '').toString(),
      propertyTitle:
          (data['propertyTitle'] ??
                  data['property_title'] ??
                  data['property']?['title'] ??
                  '')
              .toString(),
      propertyCity:
          (data['propertyCity'] ??
                  data['property_city'] ??
                  data['property']?['city'] ??
                  '')
              .toString(),
      otherUserName:
          (data['otherUserName'] ??
                  data['other_user_name'] ??
                  data['otherUser']?['name'] ??
                  'User')
              .toString(),
      otherUserAvatar:
          (data['otherUserAvatar'] ??
                  data['other_user_avatar'] ??
                  data['otherUser']?['avatarUrl'])
              ?.toString(),
      lastMessage: (data['lastMessage'] ?? data['last_message'] ?? '')
          .toString(),
      lastMessageAt: _parseDate(
        data['lastMessageAt'] ?? data['last_message_at'],
      ),
      unreadCount: _parseUnreadCount(data),
    );
  }

  ChatConversationEntity toEntity() {
    return ChatConversationEntity(
      id: id,
      propertyId: propertyId,
      propertyTitle: propertyTitle,
      propertyCity: propertyCity,
      otherUserName: otherUserName,
      otherUserAvatar: otherUserAvatar,
      lastMessage: lastMessage,
      lastMessageAt: lastMessageAt,
      unreadCount: unreadCount,
    );
  }

  static DateTime _parseDate(dynamic value) {
    if (value is DateTime) return value;
    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    }
    if (value is String && value.isNotEmpty) {
      try {
        return DateTime.parse(value);
      } catch (_) {
        return DateTime.now();
      }
    }
    return DateTime.now();
  }

  static int _parseUnreadCount(Map<String, dynamic> data) {
    final value = data['unreadCount'] ?? data['unread_count'] ?? data['unread'];
    if (value is int) return value;
    if (value is String) {
      final parsed = int.tryParse(value);
      if (parsed != null) return parsed;
    }
    return 0;
  }
}
