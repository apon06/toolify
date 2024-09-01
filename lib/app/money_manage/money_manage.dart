import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MoneyManage extends StatefulWidget {
  const MoneyManage({super.key});

  @override
  MoneyManageState createState() => MoneyManageState();
}

class MoneyManageState extends State<MoneyManage> {
  double totalMoney = 0.0;
  final List<Map<String, dynamic>> transactions = [];
  final TextEditingController amountController = TextEditingController();
  final TextEditingController sectorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      totalMoney = prefs.getDouble('totalMoney') ?? 0.0;
      String? transactionsData = prefs.getString('transactions');
      if (transactionsData != null) {
        transactions.addAll(
            List<Map<String, dynamic>>.from(json.decode(transactionsData)));
      }
    });
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('totalMoney', totalMoney);
    await prefs.setString('transactions', json.encode(transactions));
  }

  void addMoney() {
    final double amount = double.tryParse(amountController.text) ?? 0.0;
    final String sector = sectorController.text.trim();
    if (amount > 0 && sector.isNotEmpty) {
      setState(() {
        totalMoney += amount;
        transactions.add({
          'amount': amount,
          'sector': sector,
          'isIncome': true,
        });
        _saveData();
      });
      clearFields();
    }
  }

  void removeMoney() {
    final double amount = double.tryParse(amountController.text) ?? 0.0;
    final String sector = sectorController.text.trim();
    if (amount > 0 && sector.isNotEmpty) {
      setState(() {
        totalMoney -= amount;
        transactions.add({
          'amount': amount,
          'sector': sector,
          'isIncome': false,
        });
        _saveData();
      });
      clearFields();
    }
  }

  void clearFields() {
    amountController.clear();
    sectorController.clear();
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content:
              const Text('Are you sure you want to delete this transaction?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                _deleteTransaction(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteTransaction(int index) {
    final transaction = transactions[index];
    setState(() {
      if (transaction['isIncome']) {
        totalMoney -= transaction['amount'];
      } else {
        totalMoney += transaction['amount'];
      }
      transactions.removeAt(index);
      _saveData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Money Manage"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Money: \$${totalMoney.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: sectorController,
              decoration: InputDecoration(
                labelText: 'Sector',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: addMoney,
                    child: const Text('Add'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: removeMoney,
                    child: const Text('Remove'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return GestureDetector(
                    onLongPress: () => _confirmDelete(index),
                    child: Card(
                      child: ListTile(
                        title: Text(
                          '${transaction['sector']} - \$${transaction['amount'].toStringAsFixed(2)}',
                          style: TextStyle(
                            color: transaction['isIncome']
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
