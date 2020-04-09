import 'package:abotph/models/Beneficiary.dart';
import 'package:abotph/widgets/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:fluttertoast/fluttertoast.dart';

class BeneficiaryPage extends StatefulWidget {
  @override
  _BeneficiaryPageState createState() => _BeneficiaryPageState();
}

class _BeneficiaryPageState extends State<BeneficiaryPage> {
  final String baseURL = 'http://10.0.2.2:3000/api'; // Put this to environment variables when available.
  String cursor = '';
  bool areAllDataLoaded = false;

  List<Beneficiary> beneficiaries = new List();
  ScrollController _scrollController;

  _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
      fetchBeneficiaries();
    }
  }

  void fetchBeneficiaries() async{
    if(!areAllDataLoaded) {
      String url = baseURL + '/beneficiary?limit=15';

      if(cursor != '' && cursor != null) {
        url += '&cursor=' + cursor;
      }

      var apiResponse = await http.get(url);
      if (apiResponse.statusCode == 200) {
        Map<String, dynamic> beneficiaryRequest = convert.jsonDecode(apiResponse.body);
        if(beneficiaryRequest['beneficiaries'].length > 0) {
          setState(() {
            for (var beneficiary in beneficiaryRequest["beneficiaries"]) {
              beneficiaries.add(Beneficiary.fromJson(beneficiary));
            }
            cursor = beneficiaryRequest["next"];
          });
        }else {
          areAllDataLoaded = true;
          ToastUtil.show("You've reached the end", ToastStatus.INFO);
        }
      } else {
        ToastUtil.show('Request failed with status: ${apiResponse.statusCode}.', ToastStatus.WARNING);
      }
    }
  }

  void redirectToAddBeneficiary () {
    // TODO : Implement redirection when Add Beneficiary page is available
  }

  void redirectToBeneficiaryDetails () {
    // TODO : Implement redirection when Beneficiary Details page is available
  }

  @override
  void initState() {
    fetchBeneficiaries();
    _scrollController = new ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Beneficiary Page',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Beneficiary List'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.person_add),
              onPressed: redirectToAddBeneficiary,
            )
          ],
        ),
        body: Center(
          child: _buildBeneficiaryList()
        ),
      ),
    );
  }


  Widget _buildBeneficiaryList(){
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: beneficiaries.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: redirectToBeneficiaryDetails,
            title: Text('${beneficiaries[index].firstName} ${beneficiaries[index].lastName}'),
          );
        },
        controller: _scrollController);
  }
}