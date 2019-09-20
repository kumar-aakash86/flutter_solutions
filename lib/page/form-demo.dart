import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormDemo extends StatefulWidget {
  @override
  _FormDemoState createState() => _FormDemoState();
}

class _FormDemoState extends State<FormDemo> {
  final formKey = new GlobalKey<FormState>();
  bool _validate = false;
  bool _obscureText = true;
  Person person = new Person();

  String passcode;
  final _emailFocusNode = new FocusNode();
  final _passwordFocusNode = new FocusNode();
  final _fnameFocuNode = new FocusNode();
  final _lnameFocusNode = new FocusNode();

  final TextEditingController _email = new TextEditingController();
  final TextEditingController _add = new TextEditingController();
  final TextEditingController _fn = new TextEditingController();
  final TextEditingController _ln = new TextEditingController();
  final TextEditingController _pho = new TextEditingController();
  final TextEditingController _pass = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  String otpWaitTimeLabel = "";
  TextEditingController otpcontroller = TextEditingController();
  String thisText = "";
  int pinLength = 6;
  bool hasError = false;
  bool showAlertBox = false;
  String errorMessage;
  DateTime target;
  bool hasTimerStopped = false;

  List<CountryModel> _countries = [];
  CountryModel _dropdownValue;

  ValueChanged _onChanged = (val) => print(val);

  @override
  initState() {
    super.initState();

    _countries = new List();
    _countries.add(CountryModel(country: "Select", countryCode: "--"));
    _countries.add(CountryModel(country: "India", countryCode: "IN"));
    _countries.add(CountryModel(country: "America", countryCode: "US"));
  }

  bool _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _email,
      focusNode: _emailFocusNode,
      decoration: new InputDecoration(
        prefixIcon: Icon(
          Icons.email,
        ),
        labelText: "Email",
        border: UnderlineInputBorder(),
        filled: false,
        hintText: 'Your email address',
      ),
      keyboardType: TextInputType.emailAddress,
      onSaved: (String value) {
        print('person');
        print(person);
        person.email = value.trim();
      },
    );
  }

  Widget _buildTermsAndContionsCheck() {
    return FormBuilderCheckbox(
      attribute: 'accept_terms',
      initialValue: false,
      onChanged: _onChanged,
      leadingInput: true,
      label: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'I have read and agree to the ',
              style: TextStyle(color: Colors.black),
            ),
            TextSpan(
                text: 'Terms and Conditions',
                style: TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  // ..onTap = () {
                  //   print("launch url");
                  // },
                  ..onTap = () {}),
          ],
        ),
      ),
      validators: [
        FormBuilderValidators.requiredTrue(
          errorText: "You must accept terms and conditions to continue",
        ),
      ],
    );
  }

  Widget _buildDropdown() {
    return FormBuilderDropdown(
      attribute: "gender",
      decoration: InputDecoration(labelText: "Gender"),
      initialValue: 'Male',
      hint: Text('Select Gender'),
      validators: [FormBuilderValidators.required()],
      items: ['Male', 'Female', 'Other']
          .map((gender) =>
              DropdownMenuItem(value: gender, child: Text("$gender")))
          .toList(),
    );
  }

// Widget _buildCountry() {

//     // _countries = new List();
//     // _countries.add(CountryModel(country: "Select", countryCode: "--"));
//     // _countries.add(CountryModel(country: "India", countryCode: "IN"));
//     // _countries.add(CountryModel(country: "America", countryCode: "US"));
//     return FormBuilderDropdown(
//             attribute: "country",
//             decoration: InputDecoration(
//                       filled: false,
//                       hintText: 'Choose Country',
//                       prefixIcon: Icon(Icons.location_on),
//                       labelText: _countries == null || _countries.length == 0
//                           ? 'Where are you from'
//                           : 'From',
//                       errorText: "Required",
//                     ),
//             initialValue: 'Select',
//             hint: Text('Select Gender'),
//             validators: [FormBuilderValidators.required()],

//             items: _countries
//               .map((CountryModel model) => DropdownMenuItem(
//                  value: model.country,
//                  child: Text("${model.country}")
//             )).toList(),
//           );
// }
  Widget _buildCountry() {
    if (_dropdownValue != null) print(_dropdownValue.country);
    return FormBuilder(
      autovalidate: true,
      initialValue: {},
      child: FormBuilderCustomField(
        attribute: "Country",
        validators: [
          FormBuilderValidators.required(),
        ],
        formField: FormField(
          builder: (FormFieldState<dynamic> field) {
            return DropdownButtonHideUnderline(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new InputDecorator(
                    decoration: InputDecoration(
                      filled: false,
                      hintText: 'Choose Country',
                      prefixIcon: Icon(Icons.location_on),
                      labelText:
                          _countries == null ? 'Where are you from' : 'From',
                      errorText: field.errorText,
                    ),
                    isEmpty: _countries == null,
                    child: new DropdownButton<CountryModel>(
                      value: _dropdownValue,
                      isDense: true,
                      onChanged: (CountryModel newValue) {
                        print('value change');
                        print("${newValue.country} = ${newValue.countryCode}");
                        person.country = newValue.country;
                        // person.countryCode = newValue.countryCode;
                        setState(() {
                          _dropdownValue = newValue;
                          //   phoneController.text = _dropdownValue.countryCode;
                          //   field.didChange(newValue);
                        });
                      },
                      items: _countries.map(
                        (value) {
                          return DropdownMenuItem<CountryModel>(
                            value: value,
                            child: Text(value.country),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSignupButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new FlatButton.icon(
          icon: Icon(Icons.close),
          label: Text('Clear'),
          textColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          onPressed: () {
            // _email.clear();
            // _fn.clear();
            // _ln.clear();
            // _pho.clear();
            // _add.clear();
            // _pass.clear();

            print("form = ${person.email} = ${person.termsAndCondition}");

            formKey.currentState.reset();

            print("form = ${person.email} = ${person.termsAndCondition}");
          },
        ),
        new FlatButton.icon(
            icon: Icon(Icons.accessibility_new),
            label: Text('TUDO Sign Up'),
            color: Colors.amber,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            onPressed: () {
              if (formKey.currentState.validate()) {
                person.email = _email.text;
                person.firstname = _fn.text;
                person.lastname = _ln.text;
                person.password = _pass.text;

                // _onAlertotp(signupVm);
                // } else {
                // print('Error: while sign up the user');
                // print(signupVm.error);
                // }
              }
            }),
        // _buildSignupButton(context, signupVm),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Signup"),
        // leading: Icon(Icons.arrow_back_ios),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SafeArea(
          top: false,
          bottom: false,
          child: Form(
            key: formKey,
            autovalidate: _validate,
            child: Stack(
              children: <Widget>[
                // Background(),
                SingleChildScrollView(
                  dragStartBehavior: DragStartBehavior.down,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: new Container(
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 10),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _counterText(),
                        _buildEmailField(),
                        _buildDropdown(),
                        _buildCountry(),
                        _buildTermsAndContionsCheck(),
                        _buildSignupButton(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _counterText() {
    return FormBuilderTextField(
      attribute: "Counter",
      
      buildCounter: (context, {currentLength, maxLength, isFocused}) {
        return Container(
          color: Colors.red,
          alignment: Alignment.topRight,
          child: Text(
            '$currentLength of $maxLength character',
            semanticsLabel: 'character count',
          ),
        );
      },
      initialValue: "",
      style: TextStyle(
          color: Platform.isAndroid ? Colors.green : Colors.blue, height: 0.8),
      maxLength: 250,
      maxLines: null,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 0, 15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Platform.isAndroid ? Colors.green : Colors.blue),
          borderRadius: BorderRadius.circular(28),
        ),
        icon: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
        ),
      ),
      
    );
  }
}

const List<Color> signInGradients = [
  Color(0xFF0EDED2),
  Color(0xFF03A0FE),
];

const List<Color> signUpGradients = [
  Color(0xFFFF9945),
  Color(0xFFFc6076),
];

class Person {
  String email = '';
  String country = '';
  String countryCode = '';
  String phoneNumber = '';
  String firstname = '';
  String lastname = '';
  String password = '';
  bool termsAndCondition = false;
}

class CountryModel {
  String country = '';
  String countryCode = '';

  CountryModel({
    this.country,
    this.countryCode,
  });
}
