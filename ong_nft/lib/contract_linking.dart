import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:ong_nft/monitoring.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://10.0.2.2:7545";
  final String _wsUrl = "ws://10.0.2.2:7545/";
  final String _privateKey =
      "2092b1d56bc62e7ffd0d2c77344fdbf1548fdafb0cf319149c4bb1b1c8b7d488";

  late Web3Client _client;
  bool isLoading = true;

  late String _abiCode;
  late EthereumAddress _contractAddress;

  late Credentials _credentials;

  late DeployedContract _contract;
  late ContractFunction _class;
  late ContractFunction _precipitation;
  late ContractFunction _oxygenProduction;
  late ContractFunction _ndvi;
  late ContractFunction _setClass;
  late ContractFunction _setPrecipitation;
  late ContractFunction _setOxygenProduction;
  late ContractFunction _setNdvi;

  late Monitoring monitoring;

  ContractLinking() {
    initialSetup();
  }

  void initialSetup() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    final abiString =
        await rootBundle.loadString("build/contracts/Monitoring.json");
    final jsonAbi = jsonDecode(abiString);
    _abiCode = jsonEncode(jsonAbi["abi"]);
    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  Future<void> getCredentials() async {
    _credentials = EthPrivateKey.fromHex(_privateKey);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "Monitoring"), _contractAddress);

    _class = _contract.function("class");
    _precipitation = _contract.function("precipitation");
    _oxygenProduction = _contract.function("oxygenProduction");
    _ndvi = _contract.function("ndvi");
    _setClass = _contract.function("setClass");
    _setPrecipitation = _contract.function("setPrecipitation");
    _setOxygenProduction = _contract.function("setOxygenProduction");
    _setNdvi = _contract.function("setNdvi");

    getMonitoring();
  }

  void getMonitoring() async {

    final currentClass =
        await _client.call(contract: _contract, function: _class, params: []);
    final currentPrecipitation = await _client
        .call(contract: _contract, function: _precipitation, params: []);
    print("$currentClass, $currentPrecipitation");
    final currentOxygenProduction = await _client
        .call(contract: _contract, function: _oxygenProduction, params: []);
    final currentNdvi =
        await _client.call(contract: _contract, function: _ndvi, params: []);
    monitoring = Monitoring(
      className: currentClass[0],
      precipitation: currentPrecipitation[0],
      oxygenProduction: currentOxygenProduction[0],
      ndvi: currentNdvi[0],
    );

    isLoading = false;
    notifyListeners();
  }

  void setMonitoring(Monitoring value) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(_credentials, Transaction.callContract(contract: _contract, function: _setClass, parameters: [value.className]));
    await _client.sendTransaction(_credentials, Transaction.callContract(contract: _contract, function: _setPrecipitation, parameters: [value.precipitation]));
    await _client.sendTransaction(_credentials, Transaction.callContract(contract: _contract, function: _setOxygenProduction, parameters: [value.oxygenProduction]));
    await _client.sendTransaction(_credentials, Transaction.callContract(contract: _contract, function: _setNdvi, parameters: [value.ndvi]));
    getMonitoring();
  }
}
