import 'package:fido_traininguz/core/utils/utils.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  double? monthlyPayment;

  int _month = 6;
  late final TextEditingController _amountController;

  @override
  void initState() {
    _amountController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              'Калькулятор',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Узнайте ежемесячный платеж для покупки товара в рассрочку. Просто введите сумму товара, выберите желаемый период рассрочки и нажмите кнопку "Рассчитать".',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Сумма Товара'),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _amountController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintText: 'Введите сумму:',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Выберите период:'),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              width: 300,
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: _month,
                  items: [
                    DropdownMenuItem(
                      value: 6,
                      child: const Text('  6 месяцев'),
                      onTap: () => setState(() => _month = 6),
                    ),
                    DropdownMenuItem(
                      value: 12,
                      child: const Text('  12 месяцев'),
                      onTap: () => setState(() => _month = 12),
                    ),
                  ],
                  onChanged: (value) {},
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  setState(
                    () {
                      final amount =
                          double.tryParse(_amountController.text.trim());
                      if (amount != null) {
                        final double percent = _month == 6
                            ? 1.26
                            : _month == 12
                                ? 1.44
                                : 0;
                        monthlyPayment = amount * 1.2 * percent / _month;
                      }
                    },
                  );
                },
                child: const Text('Рассчитать'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            _amountController.text == ''
                ? const SizedBox()
                : Text(
                    '$_month месяцев: ${monthlyPayment?.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
          ],
        ),
      ),
    );
  }
}
