import 'package:flutter/material.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double result = 0; // convert howar por BDT amount ekhane thakbe

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Upor er wine bar
      appBar: AppBar(title: Text("Bill Converter")),
      body: Center(
        // Majhkhaner cream converter box
        child: SizedBox(
          width: 320,
          child: Card(
            color: Color.fromARGB(255, 255, 246, 247),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // USD <-> BDT lekha
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("USD"),
                      Icon(Icons.swap_horiz),
                      Text("BDT"),
                    ],
                  ),
                  SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Dollar amount likhar box
                        TextFormField(
                          controller: controller,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: InputDecoration(
                            labelText: "Amount",
                            hintText: "Enter Amount (USD)",
                            prefixIcon: Icon(Icons.attach_money),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Field is Empty!!";
                            }
                            if (double.tryParse(value) == null) {
                              return "Enter a number";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        // Holud Convert button (1 USD = 124.34 BDT)
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                String input = controller.text;
                                result = double.parse(input) * 124.34;
                                setState(() {});
                              }
                            },
                            child: Text("Convert"),
                          ),
                        ),
                        SizedBox(height: 20),
                        // Niche taka te result dekhay
                        Text(
                          "BDT: ${result.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
