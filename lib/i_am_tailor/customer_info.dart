import 'package:hive/hive.dart';

part 'customer_info.g.dart';

@HiveType(typeId: 0)
class CustomerInfo extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  double? doorCamar;
  @HiveField(3)
  double? doorBasan;
  @HiveField(4)
  double? ghadBasan;
  @HiveField(5)
  double? ghadDaman;
  @HiveField(6)
  double? doorGardan;
  @HiveField(7)
  double? ghadBalaTane;
  @HiveField(8)
  double? ghadPayinTane;
  @HiveField(9)
  double? karorJelo;
  @HiveField(10)
  double? karorPosht;
  @HiveField(11)
  double? doorSine;
  @HiveField(12)
  double? faseleSine;
  @HiveField(13)
  double? ghadSine;
  @HiveField(14)
  double? ghadSarshane;
  @HiveField(15)
  double? ghadAstin;
  @HiveField(16)
  double? doorBazo;
  @HiveField(17)
  double? doorMoch;
  @HiveField(18)
  double? doorMosht;
  @HiveField(19)
  double? ghadArenj;
  @HiveField(20)
  double? ghadSaraphone;
  @HiveField(21)
  double? ghadPirahan;
  @HiveField(22)
  double? doorRan;
  @HiveField(23)
  double? ghadShalvar;
  @HiveField(24)
  double? dampa;

  CustomerInfo();
}

String getCustomerInfoTitle(String title) {
  switch (title) {
    case 'doorCamar':
      return 'دور کمر';
    case 'doorBasan':
      return 'دور باسن';
    case 'ghadBasan':
      return 'قد باسن';
    case 'ghadDaman':
      return 'قد دامن';
    case 'doorGardan':
      return 'دور گردن';
    case 'ghadBalaTane':
      return 'قد بالاتنه جلو';
    case 'ghadPayinTane':
      return 'قد بالاتنه پشت';
    case 'karorJelo':
      return 'کارور جلو';
    case 'karorPosht':
      return 'کارور پشت';
    case 'doorSine':
      return 'دور سینه';
    case 'faseleSine':
      return 'فاصله سینه';
    case 'ghadSine':
      return 'قد سینه';
    case 'ghadSarshane':
      return 'قد سرشانه';
    case 'ghadAstin':
      return 'قد استین';
    case 'doorBazo':
      return 'دور بازو';
    case 'doorMoch':
      return 'درو مچ';
    case 'doorMosht':
      return 'دور مشت';
    case 'ghadArenj':
      return 'قد ارنج';
    case 'ghadSaraphone':
      return 'قد سارافون';
    case 'ghadPirahan':
      return 'قد پیراهن';
    case 'doorRan':
      return 'دور ران';
    case 'ghadShalvar':
      return 'قد شلوار';
    case 'dampa':
      return 'دمپا';
    default:
      return '';
  }
}
