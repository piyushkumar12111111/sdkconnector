import 'package:flutter/material.dart';

import 'package:projectwrapper/home.dart';

class InputPage extends StatefulWidget {
  // const InputPage({super.key});

  final List<String> receivedBranchIds;

  // Constructor to receive the list
  final Function() initCheckFunction;
  const InputPage(
    @required this.receivedBranchIds,
    @required this.initCheckFunction,
  );

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  String? selectedBranch;
  String? serverBaseUri;
  String? accountId;
  String? userId;
  String? userName;
  String? emailId;
  String? phoneNumber;
  String? appId;
  String? applicationNumber;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Form '),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            TextField(
              onChanged: (value) => setState(() => serverBaseUri = value),
              decoration: InputDecoration(labelText: 'Server Base URI'),
            ),
            TextField(
              onChanged: (value) => setState(() => accountId = value),
              decoration: InputDecoration(labelText: 'Account ID'),
            ),
            TextField(
              onChanged: (value) => setState(() => userId = value),
              decoration: InputDecoration(labelText: 'User ID'),
            ),
            TextField(
              onChanged: (value) => setState(() => userName = value),
              decoration: InputDecoration(labelText: 'User Name'),
            ),
            TextField(
              onChanged: (value) => setState(() => emailId = value),
              decoration: InputDecoration(labelText: 'Email ID'),
            ),
            TextField(
              onChanged: (value) => setState(() => phoneNumber = value),
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              onChanged: (value) => setState(() => appId = value),
              decoration: InputDecoration(labelText: 'App ID'),
            ),
            TextField(
              onChanged: (value) => setState(() => applicationNumber = value),
              decoration: InputDecoration(labelText: 'Application Number'),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  for (String b in widget.receivedBranchIds) {
                    print(b);
                  }
                },
                child: Text(
                  "Get Branch",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                value: selectedBranch,
                hint: Text('Select a branch'),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedBranch = newValue;
                  });
                },
                items: widget.receivedBranchIds
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                widget.initCheckFunction();
              },
              child: Text(
                "INIT",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
