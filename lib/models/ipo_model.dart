class IPOItem {
  final int id;
  final String name;
  final String bidName;
  final String date;
  final String price;
  final String logo;
  final String status;
  final String issueSize;
  final String exchange;
  final String minQty;
  final String lotSize;
  final String marketLot;
  final String openDate;
  final String closeDate;
  final String listingDate;

  IPOItem({
    required this.id,
    required this.name,
    required this.bidName,
    required this.date,
    required this.price,
    required this.logo,
    required this.status,
    required this.issueSize,
    required this.exchange,
    required this.minQty,
    required this.lotSize,
    required this.marketLot,
    required this.openDate,
    required this.closeDate,
    required this.listingDate,
  });

  factory IPOItem.fromJson(Map<String, dynamic> json) {
    return IPOItem(
      id: json["IPOSitesId"] ?? 0,
      name: json["IPOName"] ?? "",
      bidName: json["IPOBidName"] ?? "",
      date: json["Date"] ?? "",
      price: json["PriceRange"] ?? "",
      logo: json["LogoURL"] ?? "",
      status: json["IPOStatus"] ?? "",
      issueSize: json["IssueSize"] ?? "",
      exchange: json["Exchange"] ?? "",
      minQty: json["MinQty"] ?? "",
      lotSize: json["LotSize"] ?? "",
      marketLot: json["MarketLot"] ?? "",
      openDate: json["OpenDate"] ?? "",
      closeDate: json["CloseDate"] ?? "",
      listingDate: json["ListingDate"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "IPOSitesId": id,
      "IPOName": name,
      "IPOBidName": bidName,
      "Date": date,
      "PriceRange": price,
      "LogoURL": logo,
      "IPOStatus": status,
      "IssueSize": issueSize,
      "Exchange": exchange,
      "MinQty": minQty,
      "LotSize": lotSize,
      "MarketLot": marketLot,
      "OpenDate": openDate,
      "CloseDate": closeDate,
      "ListingDate": listingDate,
    };
  }
}