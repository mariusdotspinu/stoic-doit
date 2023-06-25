import 'package:flutter/material.dart';

import '../utils/quote_utils.dart';

class QuoteWidget extends StatelessWidget {
  late Future<Quote> quote;

  QuoteWidget({required Future<Quote> quote}) {
    this.quote = quote;
  }

  @override
  Widget build(BuildContext context) {
    return quoteContainer(context, quote);
  }

  Container quoteContainer(BuildContext context, Future<Quote> quote) {
    return Container(
        child: Center(child: quoteFutureBuilder(quote)),
      margin: const EdgeInsets.fromLTRB(10, 25, 10, 50)
    );
  }

  Container quoteFutureBuilder(Future<Quote> quote) {
    return Container(
        child: FutureBuilder<Quote>(
            future: quote,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return quoteWidget(context, snapshot.requireData);
              } else if (snapshot.hasError) {
                return Text('error');
              }
              return const CircularProgressIndicator();
            }));
  }

  Row quoteWidget(BuildContext context, Quote quote) {
    return Row(
      children: [
        Expanded(
            child: Align(
          alignment: Alignment.topLeft,
          child: RichText(
            text: TextSpan(
              text: "\"" + quote.quote + "\"",
              style: TextStyle(fontWeight: FontWeight.bold,
                  fontFamily: 'Quote',
                  color: Colors.grey,
                  fontSize: 23),
              children: <TextSpan>[
                TextSpan(
                    text: '\n\n - ' + quote.author,
                    style: TextStyle(fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ))
      ],
    );
  }
}
