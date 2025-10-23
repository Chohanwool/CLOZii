// 게시글 거래 유형을 나타내는 열거형
import 'package:hive/hive.dart';

part 'trade_type.g.dart';

@HiveType(typeId: 4)
enum TradeType {
  @HiveField(0)
  sell,

  @HiveField(1)
  share,
}
