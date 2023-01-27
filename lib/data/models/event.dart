import 'package:json_annotation/json_annotation.dart';
import 'package:money_keeper/data/models/transaction.dart';
import 'package:money_keeper/data/models/transactions_by_day.dart';
import 'package:money_keeper/data/models/wallet.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  int? id;
  DateTime? createdAt;
  DateTime? endDate;
  String? name;
  String? icon;
  int? spent;
  Wallet? wallet;
  int? walletId;
  bool? isFinished;
  List<Transaction>? transactions;
  List<TransactionsByDay>? transactionsByDay;

  Event({
    this.id,
    this.createdAt,
    this.endDate,
    this.name,
    this.icon,
    this.spent,
    this.wallet,
    this.isFinished,
    this.transactions,
    this.walletId,
    this.transactionsByDay,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
