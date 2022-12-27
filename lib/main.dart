import 'package:flutter/material.dart';
import 'package:watoon/widgets/btn.dart';
import 'package:watoon/widgets/wallet_card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF181818),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "안녕하세요. 홍칠님",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                        Text(
                          '다시 보니 반갑네요. :)',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                Text(
                  "총 금액",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                const Text(
                  "197,250,000원",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Btn(
                      btnText: "환전하기",
                      textColor: Colors.black,
                      bgColor: Color(0xFFF1B33A),
                    ),
                    Btn(
                      btnText: "이체하기",
                      textColor: Colors.white,
                      bgColor: Color(0xFF1F2123),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '내 지갑',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      '모두 보기',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const WalletCard(
                  walletName: "유로",
                  walletPrice: "4,345",
                  walletCurrency: "EUR",
                  walletIcon: Icons.euro_rounded,
                  isInverted: false,
                  offsetY: 0,
                ),
                const WalletCard(
                  walletName: "비트코인",
                  walletPrice: "72",
                  walletCurrency: "BIT",
                  walletIcon: Icons.currency_bitcoin_rounded,
                  isInverted: true,
                  offsetY: -23,
                ),
                const WalletCard(
                  walletName: "달러",
                  walletPrice: "1,293",
                  walletCurrency: "USD",
                  walletIcon: Icons.attach_money_rounded,
                  isInverted: false,
                  offsetY: -46,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
