class Transaction {
  late DateTime dateAdd;
  late String detail;
  late String amount;
  late double amountDouble;
  late String state;
  late String code;
  late String type;

  Transaction(
      {required this.dateAdd,
      required this.detail,
      required this.amount,
      required this.state,
      required this.code,
      required this.type})
      : amountDouble = double.tryParse(amount) ?? 0;

  Transaction.empty()
      : dateAdd = DateTime.now(),
        detail = '',
        amount = '0.00',
        amountDouble = 0,
        state = '',
        code = '',
        type = "TAG_CHARGE";

  Transaction.fromJson(Map<String, dynamic> data, {bool debug = false}) {
    if (debug) {
      print("Arrived data (${data['code']}): $data");
    }
    dateAdd =
        DateTime.parse(data['dateAdd'] ?? DateTime.now().toIso8601String());
    detail = data['detail'] ?? '';
    amount = data['amount'] ?? '0.00';
    amountDouble = double.tryParse(data['amount']) ?? 0;
    state = data['state'] ?? '';
    code = data['code'] ?? '';

    try {
      type = data['trxType']['code'] ?? "TAG_CHARGE";
    } catch (err) {
      print("Unable to load transaction type");
    }

    if (debug) {
      print("Arrived data conv: ${toString()}");
    }
  }

  @override
  String toString() {
    return '[TRANSACTION] $detail $amount $state';
  }
}

List<Transaction> myTransactions = [];
