import 'package:bike_rental/app/models/pagination_meta_model.dart';
import 'package:bike_rental/app/models/transaction_model.dart';

class WalletModel {
  final String address;
  final double balance;
  final List<TransactionModel> transactions;
  final dynamic links;
  final PaginationMetaModel meta;

  WalletModel(
      {required this.address,
      required this.balance,
      required this.transactions,
      this.links,
      required this.meta});

  factory WalletModel.fromMap(Map<String, dynamic> data) {
    return WalletModel(
      address: data['address'],
      balance: double.parse(data['balance'].toString()),
      transactions: (data['transactions'] as List)
          .map((t) => TransactionModel.fromMap(t))
          .toList(),
      links: data['links'],
      meta: PaginationMetaModel.fromMap(data['meta']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'balance': balance,
      'transactions': transactions.map((transaction) => transaction.toJson()),
      'links': links,
      'meta': meta.toJson(),
    };
  }
}
