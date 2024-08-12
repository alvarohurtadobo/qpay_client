import 'package:qpay_client/payment/model/transaction.dart';

class Tag {
  late String id;
  late DateTime dateAdd;
  late String tagId;
  late String code;
  late bool disabled;
  late String state;
  late String balance;
  late double balanceDouble;
  late List<Transaction> trxApps = [];

  Tag(
      {required this.id,
      required this.dateAdd,
      required this.tagId,
      required this.code,
      required this.disabled,
      required this.state,
      required this.balance,
      required this.trxApps})
      : balanceDouble = double.tryParse(balance) ?? 0;

  Tag.empty()
      : id = '',
        dateAdd = DateTime.now(),
        tagId = '',
        code = '',
        disabled = false,
        state = '',
        balance = '0.00',
        balanceDouble = 0,
        trxApps = [];

  Tag.fromJson(Map<String, dynamic> data) {
    List<dynamic> txTag = data['trxApps']??[];
    print("Tag trans are: $txTag");
    id = data['id'] ?? '';
    dateAdd =
        DateTime.parse(data['dateAdd'] ?? DateTime.now().toIso8601String());
    tagId = data['tagId'] ?? '';
    code = data['code'] ?? '';
    disabled = data['disabled'] ?? false;
    state = data['state'] ?? '';
    balance = data['balance'] ?? '0.00';
    balanceDouble = double.tryParse(data['balance']) ?? 0;
    trxApps = txTag
        .map<Transaction>(
          (e) => Transaction.fromJson(e, debug: true),
        )
        .toList();
  }

  @override
  String toString() {
    return '[TAG:$id] $code $state';
  }
}

List<Tag> myTags = [];

String currentTag = '';
