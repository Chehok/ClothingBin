import 'package:flutter/material.dart';

class PayScreen extends StatefulWidget {
  @override
  _PayScreenState createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  String? selectedPaymentMethod;

  List<String> paymentMethods = [
    '카드결제',
    '계좌이체',
    '간편결제',
    // 다른 결제 수단들 추가
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('결제'),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '결제 수단을 선택해 주세요!',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: paymentMethods.map((paymentMethod) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPaymentMethod = paymentMethod;
                      });
                    },
                    child: CardWidget(
                      paymentMethod: paymentMethod,
                      isSelected: selectedPaymentMethod == paymentMethod,
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (selectedPaymentMethod != null) {
                  // 선택된 결제 수단 처리
                  // TODO: 결제 로직 추가
                }
              },
              child: Text('결제하기'),
            ),
          ],
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final String paymentMethod;
  final bool isSelected;

  const CardWidget({
    required this.paymentMethod,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            paymentMethod,
            style: TextStyle(
              fontSize: 18.0,
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Icon(
            Icons.credit_card,
            size: 48.0,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ],
      ),
    );
  }
}
