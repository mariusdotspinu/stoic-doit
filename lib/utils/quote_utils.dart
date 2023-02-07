import 'dart:convert';
import 'package:http/http.dart' as http;

class QuoteUtils {
  static Future<Quote> fetchRandomStoicQuote() async {
    final response = await http
        .get(Uri.parse('https://stoicquotesapi.com/v1/api/quotes/random'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Quote.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
}
}

class Quote {
  final String quote;
  final String author;

  const Quote({
    required this.quote,
    required this.author
  });

  factory Quote.fromJson(Map<String, dynamic> quoteJson) {
    return Quote(
      quote: quoteJson['body'],
      author: quoteJson['author']
    );
  }

}