class IPOItem {
  final int id;
  final String name;
  final String date;
  final String price;
  final String lotSize;
  final String issueSize;
  final String status;
  final String logo;

  final String? bidName;
  final String? exchange;
  final String? minQty;
  final String? marketLot;
  final String? openDate;
  final String? closeDate;
  final String? listingDate;

  IPOItem({
    required this.id,
    required this.name,
    this.bidName,
    required this.date,
    required this.price,
    required this.logo,
    required this.status,
    required this.issueSize,
    this.exchange,
    this.minQty,
    required this.lotSize,
    this.marketLot,
    this.openDate,
    this.closeDate,
    this.listingDate,
  });

  factory IPOItem.fromJson(Map<String, dynamic> json) {
    return IPOItem(
      id: json["IPOSitesId"] ?? 0,
      name: json["IPOName"]?.toString() ?? "",
      bidName: json["IPOBidName"]?.toString() ?? "",
      date: json["Date"]?.toString() ?? "",
      price: json["PriceRange"]?.toString() ?? "",
      logo: json["LogoURL"]?.toString() ?? "",
      status: json["IPOStatus"]?.toString() ?? "",
      issueSize: json["IssueSize"]?.toString() ?? "",
      exchange: json["Exchange"]?.toString() ?? "",
      minQty: json["MinQty"]?.toString() ?? "",
      lotSize: json["LotSize"]?.toString() ?? "",
      marketLot: json["MarketLot"]?.toString() ?? "",
      openDate: json["OpenDate"]?.toString() ?? "",
      closeDate: json["CloseDate"]?.toString() ?? "",
      listingDate: json["ListingDate"]?.toString() ?? "",
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
