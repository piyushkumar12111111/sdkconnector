import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:projectwrapper/inputdata.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  static const SDKChannel = MethodChannel('SDKChannel', JSONMethodCodec());

  List<String> branchName = ["single"];

  void getResponce() async {
    final initArgs = {
      "serverBaseUrl":
          "https://bkr.axiomprotect.com:6653/AxiomProtect/v1/WD/sonicKYC",
      "accountId": "8797893D-7F0D-4B5F-9F6E-DE1706BC33D0",
      // "userId":"qqqqqq",
      // "userName":"qqqqqq",
      // "emailId":"",
      // "phoneNumber":"",
      // "applicationNumber":"qqq1qqq"
    };

    var res = await SDKChannel.invokeMethod('getBranchs', initArgs);
    //  var res1 = await SDKChannel.invokeMethod('start');

    // var res2 = await SDKChannel.invokeMethod('destroyToken');
    // var res3 = await SDKChannel.invokeMethod('faceRecognition');
    // var res4 = await SDKChannel.invokeMethod('faceAuthentication',faceArgs);
    // var res5 = await SDKChannel.invokeMethod('faceDelete',faceArgs);

    debugPrint('response: $res');
    print(res);

    //! storing in the list branchName

    final branches = res['resultData']['branches'] as List;
    branchName =
        branches.map((branch) => branch['branchName'] as String).toList();

    //String res = await SDKChannel.invokeMethod('clickDocumentImage');

    // setState(() {
    //   _counter= "res";
    // });
  }

  void initCheck() async {
    final initArgs = {
      "serverBaseUrl":
          "https://access.axiomprotect.com:6653/AxiomProtect/v1/WD/sonicKYC",
      "accountId": "27EE8782-A091-490A-8823-44A7813DBF27",
      "userId": "qqqqqq",
      "userName": "qqqqqq",
      "emailId": "",
      "phoneNumber": "",
      "applicationNumber": "qqq1qqq"
    };

    var res = await SDKChannel.invokeMethod('init', initArgs);
    //  var res1 = await SDKChannel.invokeMethod('start');

    // var res2 = await SDKChannel.invokeMethod('destroyToken');
    // var res3 = await SDKChannel.invokeMethod('faceRecognition');
    // var res4 = await SDKChannel.invokeMethod('faceAuthentication',faceArgs);
    // var res5 = await SDKChannel.invokeMethod('faceDelete',faceArgs);

    debugPrint('response: $res');
    //String res = await SDKChannel.invokeMethod('clickDocumentImage');
  }

  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                getResponce();
              },
              child: Text(
                "Get branch responce",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                print("BUTTON PRESSED");
                for (String b in branchName) {
                  print(b);
                }
              },
              child: Text(
                "TESTING BUTTON",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                initCheck();
              },
              child: Text(
                "INIT CHECK",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InputPage(branchName,initCheck)),
                );
              },
              child: Text(
                "Datapass Button",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
