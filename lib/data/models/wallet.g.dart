// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wallet _$WalletFromJson(Map<String, dynamic> json) => Wallet(
      id: json['id'] as int?,
      name: json['name'] as String?,
      icon: json['icon'] as String?,
      balance: json['balance'] as int?,
      isDefault: json['isDefault'] as bool?,
      type: json['type'] as String?,
      clonedCategoryWalletId: json['clonedCategoryWalletId'] as int?,
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'balance': instance.balance,
      'isDefault': instance.isDefault,
      'type': instance.type,
      'clonedCategoryWalletId': instance.clonedCategoryWalletId,
      'members': instance.members?.map((e) => e.toJson()).toList(),
    };
