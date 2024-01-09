import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('Address', () {
    group('validateAddress', () {
      test('base58 addresses and valid network', () {
        expect(
            Address.validateAddress(
                'mhv6wtF2xzEqMNd3TbXx9TjLLo6mp2MUuT', testnet),
            true);
        expect(Address.validateAddress('1K6kARGhcX9nJpJeirgcYdGAgUsXD59nHZ'),
            true);
      });
      test('base58 addresses and invalid network', () {
        expect(
            Address.validateAddress(
                'mhv6wtF2xzEqMNd3TbXx9TjLLo6mp2MUuT', bitcoin),
            false);
        expect(
            Address.validateAddress(
                '1K6kARGhcX9nJpJeirgcYdGAgUsXD59nHZ', testnet),
            false);
      });
      test('bech32 addresses and valid network', () {
        expect(
            Address.validateAddress(
                'tb1qgmp0h7lvexdxx9y05pmdukx09xcteu9sx2h4ya', testnet),
            true);
        expect(
            Address.validateAddress(
                'bc1qw508d6qejxtdg4y5r3zarvary0c5xw7kv8f3t4'),
            true);
        // expect(Address.validateAddress('tb1qqqqqp399et2xygdj5xreqhjjvcmzhxw4aywxecjdzew6hylgvsesrxh6hy'), true); TODO
      });
      test('bech32 addresses and invalid network', () {
        expect(
            Address.validateAddress(
                'tb1qgmp0h7lvexdxx9y05pmdukx09xcteu9sx2h4ya'),
            false);
        expect(
            Address.validateAddress(
                'bc1qw508d6qejxtdg4y5r3zarvary0c5xw7kv8f3t4', testnet),
            false);
      });
      test('invalid addresses', () {
        expect(Address.validateAddress('3333333casca'), false);
      });
    });
  });
}



final testnet = new NetworkType(
    messagePrefix: '\x18Bitcoin Signed Message:\n',
    bech32: 'tb',
    bip32: new Bip32Type(public: 0x043587cf, private: 0x04358394),
    pubKeyHash: 0x6f,
    scriptHash: 0xc4,
    wif: 0xef);

final bitcoin = new NetworkType(
    messagePrefix: '\x18Bitcoin Signed Message:\n',
    bech32: 'bc',
    bip32: new Bip32Type(public: 0x0488b21e, private: 0x0488ade4),
    pubKeyHash: 0x00,
    scriptHash: 0x05,
    wif: 0x80);