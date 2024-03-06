import 'dart:convert';

import 'package:expense_tracker/widget/chart/chart.dart';
import 'package:expense_tracker/ui/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:expense_tracker/widget/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List<Expense> _registeredexpenses = [];

  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https(
        'expense-tracker-f6ff7-default-rtdb.firebaseio.com', 'expense.json');

    final response = await http.get(url);
    final Map<String, dynamic> responsedata = json.decode(response.body);
    final List<Expense> loadedItems = [];
    for (final item in responsedata.entries) {
      loadedItems.add(
        Expense(
            title: item.value['title'],
            amount: item.value['amount'],
            date: DateTime.parse(item.value['date']),
            category: parseCategory(item.value['category'])),
      );
      setState(() {
        _registeredexpenses = loadedItems;
        _isLoading = false;
      });
    }
  }

  void _openAddExpenseOverlay() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return NewExpense(onAddExpense: _addExpense);
        },
      ),
    );

    final url = Uri.https(
        'expense-tracker-f6ff7-default-rtdb.firebaseio.com', 'expense.json');

    final response = await http.get(url);
    if (response.statusCode >= 400) {
      setState(() {
        _error =
            '${response.statusCode}:Failed to get the data. Please try again later';
      });
    }
    print(response);
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredexpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) async {
    final index = _registeredexpenses.indexOf(expense);
    setState(() {
      _registeredexpenses.remove(expense);
    });
    print('This is the id ---- ${expense.id}');
    final url = Uri.https('expense-tracker-f6ff7-default-rtdb.firebaseio.com',
        'expense/${expense.id}.json');

    final response = await http.delete(url);
    print(response.statusCode);
    if (response.statusCode >= 400) {
      setState(() {
        _registeredexpenses.insert(index, expense);
      });
    }

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 4),
        // action: SnackBarAction(
        //     label: 'Undo',
        //     onPressed: () {
        //       setState(() {
        //         _registeredexpenses.insert(expenseIndex, expense);
        //       });
        //     }),
        content: Text('Item Deleted'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet'));

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_registeredexpenses.isNotEmpty) {
      content = Column(
        children: [
          Chart(expenses: _registeredexpenses),
          Expanded(
            child: ExpensesList(
              expenses: _registeredexpenses,
              onRemoveExpense: _removeExpense,
            ),
          ),
        ],
      );
    }

    if (_error != null) {
      content = Center(
        child: Text(_error!),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter ExpenseTracker'),
          actions: [
            IconButton(
              onPressed: _openAddExpenseOverlay,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: content);
  }
}

Category parseCategory(String cat) {
  if (cat == 'Category.leisure') {
    return Category.leisure;
  } else if (cat == 'Category.work') {
    return Category.work;
  } else if (cat == 'Category.food') {
    return Category.food;
  }
  return Category.travel;
}
