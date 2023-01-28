import 'package:json_annotation/json_annotation.dart';
import 'package:money_keeper/data/models/user.dart';

part "wallet.g.dart";

@JsonSerializable(explicitToJson: true)
class Wallet {
  int? id;
  String? name;
  String? icon;
  int? balance;
  bool? isDefault;
  String? type;
  int? clonedCategoryWalletId;
  List<User>? members;
  List<int>? memberIds;

  Wallet(
      {this.id,
      this.name,
      this.icon,
      this.balance,
      this.isDefault,
      this.type,
      this.clonedCategoryWalletId,
      this.members,
      this.memberIds});

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);

  Map<String, dynamic> toJson() => _$WalletToJson(this);
}
