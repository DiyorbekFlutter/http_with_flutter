class TaxiModel {
  String taxiDriverName;
  String imgUrl;
  String carModelName;
  String direction;
  String price;
  String description;
  String phoneNumber;
  String? telegramUsername;
  bool negotiable;
  bool nonSmokingDriver;
  bool canPauseEating;
  PaymentType paymentType;
  int interests;

  TaxiModel({
    required this.taxiDriverName,
    required this.imgUrl,
    required this.carModelName,
    required this.direction,
    required this.price,
    required this.description,
    required this.phoneNumber,
    this.telegramUsername,
    required this.negotiable,
    required this.nonSmokingDriver,
    required this.canPauseEating,
    required this.paymentType,
    required this.interests
  });
}

enum PaymentType {
  cash,
  card,
  cashOrCard
}


List<TaxiModel> taxiModels = [
  TaxiModel(
    taxiDriverName: 'Elmurod Haqnazarov',
    imgUrl: 'assets/images/img/img10.png',
    carModelName: 'Cobalt',
    direction: "Bag'dod Toshkent",
    price: "120 000  so'm",
    description: "Bag'dod Toshkent yo'nalishi bo'yicha yuramiz. +998 91 688 44 60",
    phoneNumber: '+998(91) 688-44-60',
    telegramUsername: 'https://t.me/diyorbekqurbonov',
    negotiable: true,
    nonSmokingDriver: true,
    canPauseEating: true,
    paymentType: PaymentType.cashOrCard,
    interests: 36578
  ),
  TaxiModel(
    taxiDriverName: 'Elon Musk',
    imgUrl: 'assets/images/img/img2.png',
    carModelName: 'Nexia 3',
    direction: "Rishton Toshkent",
    price: "125 000  so'm",
    description: "Rishton Toshkent yo'nalishi bo'yicha qatnaymiz",
    phoneNumber: '+998 91 688 44 60',
    negotiable: false,
    nonSmokingDriver: false,
    canPauseEating: false,
    paymentType: PaymentType.card,
    interests: 78528
  ),
  TaxiModel(
    taxiDriverName: 'Jahongir Poziljonuv',
    imgUrl: 'assets/images/img/img9.png',
    carModelName: 'Cobalt',
    direction: "Andjon shahri",
    price: "100 000  so'm",
    description: "Andjon Toshkent yo'nalishi bo'yicha qatnaymiz",
    phoneNumber: '+998 91 688 44 60',
    negotiable: true,
    nonSmokingDriver: true,
    canPauseEating: true,
    paymentType: PaymentType.cash,
    interests: 23487
  ),
  TaxiModel(
    taxiDriverName: 'Stiv Jobs',
    imgUrl: 'assets/images/img/img7.png',
    carModelName: 'Spark',
    direction: "Farg'ona Toshkent",
    price: "150 000  so'm",
    description: "Farg'ona Toshkent yo'nalishi bo'yicha qatnaymiz",
    phoneNumber: '+998 91 688 44 60',
    negotiable: true,
    nonSmokingDriver: true,
    canPauseEating: false,
    paymentType: PaymentType.cashOrCard,
    interests: 36629
  ),
  TaxiModel(
    taxiDriverName: 'Artur Pendragon',
    imgUrl: 'assets/images/img/img8.png',
    carModelName: 'Gentra',
    direction: "Samarqand Toshkent",
    price: "132 000  so'm",
    description: "Samarqand Toshkent yo'nalishi bo'yicha qatnaymiz",
    phoneNumber: '+998 91 688 44 60',
    negotiable: true,
    nonSmokingDriver: true,
    canPauseEating: true,
    paymentType: PaymentType.cashOrCard,
    interests: 128749
  ),
  TaxiModel(
    taxiDriverName: 'Erik Xaydar',
    imgUrl: 'assets/images/img/img6.png',
    carModelName: 'Lasetti',
    direction: "Navoi Toshkent",
    price: "200 000  so'm",
    description: "Navoi Toshkent yo'nalishi bo'yicha qatnaymiz",
    phoneNumber: '+998 91 688 44 60',
    negotiable: false,
    nonSmokingDriver: true,
    canPauseEating: true,
    paymentType: PaymentType.cash,
    interests: 578
  ),
  TaxiModel(
    taxiDriverName: 'Bobur Mansuruv',
    imgUrl: 'assets/images/img/img4.png',
    carModelName: 'Cobalt',
    direction: "Navoiy Toshkent",
    price: "220 000  so'm",
    description: "Navoiy Toshkent yo'nalishi bo'yicha qatnaymiz",
    phoneNumber: '+998 91 688 44 60',
    negotiable: true,
    nonSmokingDriver: true,
    canPauseEating: true,
    paymentType: PaymentType.cashOrCard,
    interests: 82564
  ),
  TaxiModel(
    taxiDriverName: 'Shukurullo Isroilov',
    imgUrl: 'assets/images/img/img5.png',
    carModelName: 'Gentra',
    direction: "Bag'dod Toshkent",
    price: "Narx kelishiladi",
    description: "Bag'dod Toshkent yo'nalishi bo'yicha qatnaymiz",
    phoneNumber: '+998 91 688 44 60',
    negotiable: false,
    nonSmokingDriver: true,
    canPauseEating: true,
    paymentType: PaymentType.cashOrCard,
    interests: 27845
  ),
  TaxiModel(
    taxiDriverName: 'Mirzobek Xolmadov',
    imgUrl: 'assets/images/img/img3.png',
    carModelName: 'Nexi 3',
    direction: "Namangan Toshkent",
    price: "100 000  so'm",
    description: "Namangan Toshkent yo'nalishi bo'yicha qatnaymiz",
    phoneNumber: '+998 91 688 44 60',
    negotiable: true,
    nonSmokingDriver: true,
    canPauseEating: true,
    paymentType: PaymentType.cashOrCard,
    interests: 97845
  ),
  TaxiModel(
    taxiDriverName: 'Dileme',
    imgUrl: 'assets/images/img/img1.png',
    carModelName: 'Nexi 3',
    direction: "Bag'dod Toshkent",
    price: "100 000  so'm",
    description: "Bag'dod Toshkent yo'nalishi bo'yicha qatnaymiz",
    phoneNumber: '+998 91 688 44 60',
    negotiable: true,
    nonSmokingDriver: true,
    canPauseEating: true,
    paymentType: PaymentType.cashOrCard,
    interests: 47585
  ),
];
