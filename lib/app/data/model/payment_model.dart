class CheckoutResponse {
  final String url;

  CheckoutResponse({required this.url});

  factory CheckoutResponse.fromJson(Map<String, dynamic> json) {
    return CheckoutResponse(
      url: json['url'],
    );
  }
}
