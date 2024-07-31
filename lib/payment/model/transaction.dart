class Transaction {
  DateTime dateAdd;
  String detail;
  String amount;
  double amountDouble;
  String state;
  String code;

  Transaction({
    required this.dateAdd,
    required this.detail,
    required this.amount,
    required this.state,
    required this.code,
  }) : amountDouble = double.tryParse(amount) ?? 0;

  Transaction.empty()
      : dateAdd = DateTime.now(),
        detail = '',
        amount = '0.00',
        amountDouble = 0,
        state = '',
        code = '';

  Transaction.fromJson(Map<String, dynamic> data)
      : dateAdd = DateTime.parse(data['dateAdd'] ?? DateTime.now().toIso8601String()),
        detail = data['detail'] ?? '',
        amount = data['amount'] ?? '0.00',
        amountDouble = double.tryParse(data['amount']) ?? 0,
        state = data['state'] ?? '',
        code = data['code'] ?? '';

  @override
  String toString() {
    return '[TRANSACTION] $detail $amount $state';
  }
}

List<Transaction> myTransactions = [];