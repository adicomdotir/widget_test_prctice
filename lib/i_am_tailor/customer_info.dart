class CustomerInfo {
  String? name;
  double? doorCamar;
  double? doorBasan;
  double? ghadBasan;
  double? ghadDaman;
  double? doorGardan;
  double? ghadBalaTane;
  double? ghadPayinTane;
  double? karorJelo;
  double? karorPosht;
  double? doorSine;
  double? faseleSine;
  double? ghadSine;
  double? ghadSarshane;
  double? ghadAstin;
  double? doorBazo;
  double? doorMoch;
  double? doorMosht;
  double? ghadArenj;
  double? ghadSaraphone;
  double? ghadPirahan;
  double? doorRan;
  double? ghadShalvar;
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
