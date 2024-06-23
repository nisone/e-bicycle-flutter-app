class TransactionModel {
  final int transactionId;
  final int transactionWalletId;
  final String transactionReference;
  final double transactionAmount;
  final String transactionNarration;
  final String transactionChannel;
  final String transactionType;
  final bool transactionIsSuccessful;
  final String transactionStatus;
  final String transactionCreatedAt;
  final String transactionUpdatedAt;

  TransactionModel({
    required this.transactionId,
    required this.transactionWalletId,
    required this.transactionReference,
    required this.transactionAmount,
    required this.transactionNarration,
    required this.transactionChannel,
    required this.transactionType,
    required this.transactionIsSuccessful,
    required this.transactionStatus,
    required this.transactionCreatedAt,
    required this.transactionUpdatedAt,
  });

  factory TransactionModel.fromMap(Map<String, dynamic> data) {
    return TransactionModel(
      transactionId: data['transaction_id'],
      transactionWalletId: data['transaction_wallet_id'],
      transactionReference: data['transaction_reference'],
      transactionAmount: double.parse(data['transaction_amount'].toString()),
      transactionNarration: data['transaction_narration'],
      transactionChannel: data['transaction_channel'],
      transactionType: data['transaction_type'],
      transactionIsSuccessful: data['transaction_is_successful'] == 1,
      transactionStatus: data['transaction_status'],
      transactionCreatedAt: data['transaction_created_at'],
      transactionUpdatedAt: data['transaction_updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transaction_id': transactionId,
      'transaction_wallet_id': transactionWalletId,
      'transaction_reference': transactionReference,
      'transaction_amount': transactionAmount,
      'transaction_narration': transactionNarration,
      'transaction_channel': transactionChannel,
      'transaction_type': transactionChannel,
      'transaction_is_successful': transactionIsSuccessful,
      'transaction_status': transactionStatus,
      'transaction_created_at': transactionCreatedAt,
      'transaction_updated_at': transactionUpdatedAt,
    };
  }
}
