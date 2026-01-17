import 'package:flutter/material.dart';

class CurrencyConverterMaterialPage extends StatefulWidget {
  const CurrencyConverterMaterialPage({super.key});

  @override
  State<CurrencyConverterMaterialPage> createState() =>
      _CurrencyConverterMaterialPageState();
}

class _CurrencyConverterMaterialPageState
    extends State<CurrencyConverterMaterialPage> {
  final TextEditingController tec = TextEditingController();

  double result = 0;

  String fromCurrency = 'INR';
  String toCurrency = 'USD';

  // Single source of truth
  final Map<String, double> rates = {'INR': 1, 'USD': 81, 'EUR': 80};

  final OutlineInputBorder border = const OutlineInputBorder(
    borderSide: BorderSide(width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(50)),
  );

  void updateCurrency() {
    double exchangeRate = rates[fromCurrency]! / rates[toCurrency]!;
    double input = double.tryParse(tec.text) ?? 0;
    result = input * exchangeRate;
  }

  @override
  Widget build(BuildContext context) {
    double exchangeRate = rates[fromCurrency]! / rates[toCurrency]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Exchange Rate Display
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text(
                  'Exchange Rate: ${exchangeRate.toStringAsFixed(4)}',
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 26,
                    color: Colors.white70,
                  ),
                ),
              ),

              // Result Display
              Text(
                '${result.toStringAsFixed(2)} $toCurrency',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(240, 237, 237, 1),
                ),
              ),

              // Amount Input
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: tec,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    hintText: 'ENTER AMOUNT IN $fromCurrency',
                    prefixIcon: const Icon(Icons.currency_exchange),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 98, 172, 233),
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
              ),

              // Convert Button
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      updateCurrency();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'CONVERT',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              // FROM Currency Dropdown
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: DropdownButton<String>(
                  value: fromCurrency,

                  isExpanded: true,
                  items: rates.keys.map((String currency) {
                    return DropdownMenuItem<String>(
                      value: currency,
                      child: Text(
                        currency,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      fromCurrency = value!;
                      updateCurrency();
                    });
                  },
                ),
              ),

              // TO Currency Dropdown
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: DropdownButton<String>(
                  value: toCurrency,
                  isExpanded: true,
                  items: rates.keys.map((String currency) {
                    return DropdownMenuItem<String>(
                      value: currency,
                      child: Text(
                        currency,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      toCurrency = value!;
                      updateCurrency();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    tec.dispose();
    super.dispose();
  }
}
