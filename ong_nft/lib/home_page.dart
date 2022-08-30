import 'package:flutter/material.dart';
import 'package:ong_nft/contract_linking.dart';
import 'package:ong_nft/monitoring.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Monitoring Contract"),
      ),
      body: Consumer<ContractLinking>(builder: (_, contractLinking, child) {
        if (contractLinking.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 3.0,
            ),
          );
        }
        final _classController =
            TextEditingController(text: contractLinking.monitoring.className);
        final _precipitationController = TextEditingController(
            text: contractLinking.monitoring.precipitation);
        final _oxygenProductionController = TextEditingController(
            text: contractLinking.monitoring.oxygenProduction);
        final _ndviController =
            TextEditingController(text: contractLinking.monitoring.ndvi);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
          child: Column(
            children: [
              TextFormField(
                controller: _classController,
                decoration: const InputDecoration(hintText: "Class"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _precipitationController,
                decoration: const InputDecoration(hintText: "Precipitation"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _oxygenProductionController,
                decoration:
                    const InputDecoration(hintText: "Oxygen Production"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _ndviController,
                decoration: const InputDecoration(hintText: "NDVI"),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () => contractLinking.setMonitoring(
                  Monitoring(
                    className: _classController.text,
                    precipitation: _precipitationController.text,
                    oxygenProduction: _oxygenProductionController.text,
                    ndvi: _ndviController.text,
                  ),
                ),
                child: const Text("Set Monitoring"),
              )
            ],
          ),
        );
      }),
    );
  }
}
