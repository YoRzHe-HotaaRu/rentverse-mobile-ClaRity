//lib/features/auth/data/models/response/user_model.dart

import 'package:rentverse/features/auth/domain/entity/user_entity.dart';

import 'profile_model.dart';
import 'role_model.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    super.name,
    super.phone,
    super.avatarUrl,
    required super.isVerified,
    super.createdAt,
    super.roles,
    super.tenantProfile,
    super.landlordProfile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Build roles from either 'roles' array or fallback 'role' string
    List<UserRoleModel>? parsedRoles;
    if (json['roles'] != null) {
      parsedRoles = (json['roles'] as List)
          .whereType<Map<String, dynamic>>()
          .map((e) => UserRoleModel.fromJson(e))
          .toList();
    } else if (json['role'] is String && (json['role'] as String).isNotEmpty) {
      // Fallback: backend provided single role string
      parsedRoles = [
        UserRoleModel(role: RoleModel(name: json['role'] as String)),
      ];
    }

    return UserModel(
      id: json['id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      isVerified: (json['isVerified'] as bool?) ?? false,

      // Parse DateTime
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,

      // Parse List Roles
      roles: parsedRoles,

      // Parse Tenant Profile (Nullable)
      tenantProfile: json['tenantProfile'] != null
          ? TenantProfileModel.fromJson(
              json['tenantProfile'] as Map<String, dynamic>,
            )
          : null,

      // Parse Landlord Profile (Nullable)
      landlordProfile: json['landlordProfile'] != null
          ? LandlordProfileModel.fromJson(
              json['landlordProfile'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  // Penting untuk menyimpan user session ke SharedPreferences
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'avatarUrl': avatarUrl,
      'isVerified': isVerified,
      'createdAt': createdAt?.toIso8601String(),

      // Convert list roles ke json
      'roles': roles?.map((e) => (e as UserRoleModel).toJson()).toList(),

      // Convert profiles ke json
      'tenantProfile': tenantProfile != null
          ? (tenantProfile as TenantProfileModel).toJson()
          : null,
      'landlordProfile': landlordProfile != null
          ? (landlordProfile as LandlordProfileModel).toJson()
          : null,
    };
  }
}
