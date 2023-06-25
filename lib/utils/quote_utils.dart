import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';

class QuoteUtils {
  static Future<Quote> fetchRandomStoicQuote(BuildContext context) async {
    String quoteData = await DefaultAssetBundle.of(context).loadString("assets/quotes.json");
    List quotes = jsonDecode(quoteData);
    return Quote.fromJson(quotes.elementAt(Random().nextInt(36)));
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