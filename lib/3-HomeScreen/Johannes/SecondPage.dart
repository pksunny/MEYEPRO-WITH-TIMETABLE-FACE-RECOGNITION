import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  final String payload;

  const SecondPage({
    required this.payload,
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Second page - Payload:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                payload,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                child: Text('Back'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      );
}