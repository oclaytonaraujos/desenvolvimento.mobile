import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mamamia_pizzaria/pagamento/confirmacao.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:flutter/services.dart';

class PaymentScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cart;
  final double totalFromOrders;

  const PaymentScreen({
    Key? key,
    required this.cart,
    required this.totalFromOrders,
    required int itemCount,
  }) : super(key: key);

  @override
  PaymentScreenState createState() => PaymentScreenState();
}

class PaymentScreenState extends State<PaymentScreen> {
  bool saveCard = false;
  double total = 0.0;
  String selectedPaymentMethod = "Cartão";
  String? scannedCoupon;
  String? pixKey;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController cardNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    total = widget.totalFromOrders;
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    cardNameController.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        scannedCoupon = scanData.code;
        controller.dispose();
      });
      Navigator.pop(context);
    });
  }

  void _openQRScanner() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Escaneie o QR Code'),
          backgroundColor: Colors.yellow[700],
        ),
        body: QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
        ),
      ),
    );
  }

  String _generatePixKey() {
    const chars = "abcdefghijklmnopqrstuvwxyz0123456789";
    final random = Random();
    return List.generate(15, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Chave PIX copiada para a área de transferência!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (selectedPaymentMethod == "PIX" && pixKey == null) {
      pixKey = _generatePixKey();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[700],
        elevation: 0,
        title: const Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pagamento:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedPaymentMethod,
              onChanged: (String? newValue) {
                setState(() {
                  selectedPaymentMethod = newValue!;
                  pixKey = newValue == "PIX" ? _generatePixKey() : null;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Método de pagamento',
                border: OutlineInputBorder(),
              ),
              items: <String>['Cartão', 'Pagamento na Retirada', 'PIX']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            if (selectedPaymentMethod == "Cartão") _buildCardForm(),
            if (selectedPaymentMethod == "PIX") _buildPixSection(),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[700],
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderConfirmationScreen()),
                );
              },
              child: const Text('Confirmar', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 20),
            _buildDiscountSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildCardForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total: R\$${total.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: cardNumberController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'n° cartão',
            prefixIcon: const Icon(Icons.credit_card),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: expiryDateController,
                keyboardType: TextInputType.number,
                maxLength: 5,
                decoration: InputDecoration(
                  labelText: 'MM/AA',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: cvvController,
                keyboardType: TextInputType.number,
                maxLength: 3,
                decoration: InputDecoration(
                  labelText: 'CVV',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextField(
          controller: cardNameController,
          decoration: InputDecoration(
            labelText: 'Nome no cartão',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Salvar cartão:'),
            Switch(
              value: saveCard,
              onChanged: (value) {
                setState(() {
                  saveCard = value;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPixSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Chave PIX:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Text(
                pixKey ?? '',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {
                if (pixKey != null) {
                  _copyToClipboard(pixKey!);
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDiscountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cupom de desconto:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                readOnly: true,
                controller: TextEditingController(text: scannedCoupon),
                decoration: const InputDecoration(
                  hintText: 'Nenhum cupom aplicado',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[700],
                shape: const CircleBorder(),
              ),
              onPressed: _openQRScanner,
              child: const Icon(Icons.qr_code_scanner, color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }
}
