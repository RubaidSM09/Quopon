import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:quopon/app/modules/QRScanner/views/q_r_fail_view.dart';
import 'package:quopon/app/modules/QRScanner/views/q_r_success_view.dart';

import '../../deals/views/deals_view.dart';
import '../../home/views/home_view.dart';

class QRScannerView extends StatefulWidget {
  const QRScannerView({super.key});

  @override
  State<QRScannerView> createState() => _QRScannerViewState();
}

class _QRScannerViewState extends State<QRScannerView> {
  final MobileScannerController _scannerController = MobileScannerController();

  int _selectedIndex = 2;
  bool _isScanned = false;

  void _showQRSuccess(BuildContext context, String dealTitle, String dealStoreName, String brandLogo, String time) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: /*Container(
            height: 20,
            width: 20,
            color: Colors.white,
          )*/
          QRSuccessView(dealTitle: dealTitle, dealStoreName: dealStoreName, brandLogo: brandLogo, time: time),
        );
      },
    );
  }

  void _showQRFail(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: QRFailView(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Camera View (disable on Web)
          if (!kIsWeb)
            MobileScanner(
              controller: _scannerController,
              onDetect: (BarcodeCapture capture) {
                if (_isScanned) return;

                final List<Barcode> barcodes = capture.barcodes;
                if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
                  _isScanned = true;
                  final String code = barcodes.first.rawValue!;
                  debugPrint('Scanned: $code');

                  // Reset after 3 seconds
                  Future.delayed(const Duration(seconds: 3), () {
                    _isScanned = false;
                  });
                }
              },
            )
          else
            const Center(
              child: Text(
                "Scanner not supported on web",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),

          // Header bar
          Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                const SizedBox(width: 12),
                const Text(
                  "Scan QR Code",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),

          // QR Scan overlay box and label
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          // Bottom action buttons (Flash & Camera flip)
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _scannerController.toggleTorch(),
                  child: _actionButton(Icons.flash_on),
                ),
                const SizedBox(width: 32),
                GestureDetector(
                  onTap: () => _scannerController.switchCamera(),
                  child: _actionButton(Icons.cameraswitch),
                ),
                const SizedBox(width: 32),
                GestureDetector(
                  onTap: () => _showQRSuccess(context, '50% Off Any Grande Beverage', 'Starbucks', 'assets/images/deals/details/Starbucks_Logo.png', '01:05 AM'),
                  child: _actionButton(Icons.flash_on),
                ),
                const SizedBox(width: 32),
                GestureDetector(
                  onTap: () => _showQRFail(context),
                  child: _actionButton(Icons.cameraswitch),
                ),
              ],
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFFFFFFF),
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 0) {
            // Navigate to scanner screen without changing selected index
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeView()),
            );
          } else {
            setState(() {
              _selectedIndex = index;
            });

            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DealsView()),
              );
            }

            // Add more conditions if needed for other indexes
          }
        },
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/deals/Language.png'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/deals/PrivacyPolicy.png'),
            label: 'Deals',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Image.asset('assets/images/Home/BottomNavigation/Notifications.png'),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/Home/BottomNavigation/ChangePassword.png'),
            label: 'My Deals',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/Home/BottomNavigation/Icon-4.png'),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _actionButton(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(12),
      child: Icon(icon, color: Colors.white),
    );
  }
}
