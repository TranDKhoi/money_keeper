import 'package:money_keeper/data/models/wallet.dart';

class Event {
  final String? name;
  final DateTime? endDate;
  final int? icon;
  final Wallet? wallet;
  bool? isFinished;

  Event({this.name, this.endDate, this.icon, this.wallet, this.isFinished});
}
