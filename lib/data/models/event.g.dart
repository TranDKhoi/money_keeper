// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      id: json['id'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      name: json['name'] as String?,
      icon: json['icon'] as String?,
      spent: json['spent'] as int?,
      wallet: json['wallet'] == null
          ? null
          : Wallet.fromJson(json['wallet'] as Map<String, dynamic>),
      isFinished: json['isFinished'] as bool?,
      transactions: (json['transactions'] as List<dynamic>?)
          ?.map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      walletId: json['walletId'] as int?,
      transactionsByDay: (json['transactionsByDay'] as List<dynamic>?)
          ?.map((e) => TransactionsByDay.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'name': instance.name,
      'icon': instance.icon,
      'spent': instance.spent,
      'wallet': instance.wallet,
      'walletId': instance.walletId,
      'isFinished': instance.isFinished,
      'transactions': instance.transactions,
      'transactionsByDay': instance.transactionsByDay,
    };
