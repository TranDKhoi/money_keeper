import 'package:json_annotation/json_annotation.dart';

import 'category.dart';
import 'wallet.dart';

part 'transaction.g.dart';

@JsonSerializable(explicitToJson: true)
class Transaction {
  int? id;
  int? amount;
  String? note;
  int? categoryId;
  int? walletId;
  Wallet? wallet;
  Category? category;
  int? eventId;
  String? image;
  DateTime? createdAt;

  Transaction(
      {this.id,
      this.amount,
      this.note,
      this.categoryId,
      this.walletId,
      this.wallet,
      this.category,
      this.eventId,
      this.image,
      this.createdAt});

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
