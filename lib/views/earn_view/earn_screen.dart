import 'dart:js' as js;
import 'package:flutter/material.dart';

class EarnScreen extends StatelessWidget {
  const EarnScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connect TON Wallet"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            connectToTonWallet(context);
          },
          child: const Text('Connect to TON Wallet'),
        ),
      ),
    );
  }

  void connectToTonWallet(BuildContext context) {
    // Check if the JavaScript function is defined
    if (js.context['connectToTonWallet'] != null) {
      // Call the JS function
      js.context.callMethod('connectToTonWallet').then((walletAddress) {
        if (walletAddress != null) {
          _showWalletInfoBottomSheet(context, walletAddress);
        } else {
          print('Wallet address is null');
        }
      }).catchError((error) {
        // Log the error
        print('Error while connecting to TON Wallet: $error');
      });
    }
    else {
      print('connectToTonWallet function is not defined in JS context');
    }
  }

  void _showWalletInfoBottomSheet(BuildContext context, String walletAddress) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Connected Wallet',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text('Wallet Address: $walletAddress'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
}
