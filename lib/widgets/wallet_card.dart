import 'package:flutter/material.dart';

class WalletCard extends StatelessWidget {
  final String walletName, walletPrice, walletCurrency;
  final IconData walletIcon;
  final bool isInverted;
  final double offsetY;

  final Color _blackColor = const Color(0xFF1F2123);

  const WalletCard({
    super.key,
    required this.walletName,
    required this.walletPrice,
    required this.walletCurrency,
    required this.walletIcon,
    required this.isInverted,
    required this.offsetY,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, offsetY),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: isInverted ? Colors.white : _blackColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 18,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    walletName,
                    style: TextStyle(
                      color: isInverted ? _blackColor : Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        walletPrice,
                        style: TextStyle(
                          color: isInverted ? _blackColor : Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        walletCurrency,
                        style: TextStyle(
                          color: isInverted
                              ? _blackColor.withOpacity(0.6)
                              : Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Transform.scale(
                scale: 2.2,
                child: Transform.translate(
                  offset: const Offset(-5, 15),
                  child: Icon(
                    walletIcon,
                    color: isInverted ? _blackColor : Colors.white,
                    size: 80,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
