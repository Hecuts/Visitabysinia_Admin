import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visab_admin/ui/widgets/bottom_button.dart';
import 'package:visab_admin/util/const_ui_group.dart';

class AddGuides extends StatefulWidget {

  //Constants
  @override
  _AddGuidesState createState() => _AddGuidesState();
}

class _AddGuidesState extends State<AddGuides> {


  String _name = '';
  String _password = '' ;
  String _confirm = '';
  String _sex = '';
  String _email = '';
  String _language = '';
  String _phoneNumber = '';
  String _maritalStatus = 'Married';
  String dropdownValue = 'Male';
  String lang_Value = 'Amharic';



  //for the image
  File _image;
  final picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget _buildName(){
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Name',
          hintText: 'Enter your name here',
          prefixIcon: Icon(Icons.person),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          )
      ),
      validator: (String value){
        if(value.isEmpty || value == null){
          return 'Name is required';
        }
        return null;
      },
      onSaved: (String value){
        _name = value;
      },
    );
  }
  Widget _buildEmail(){
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'ZelekeGessesse@gmail.com',
          prefixIcon: Icon(Icons.mail),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          )),
      validator: (String value){
        if(!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a"
            r"-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0"
            r"-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9]"
            r"(?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please insert a valid email';
        }
        return null;
      },
      onSaved: (String value){
        _email = value;
      },
    );
  }
  Widget _buildPassword(){
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Password',
          hintText: '',
          prefixIcon: Icon(Icons.lock),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          )),

      keyboardType: TextInputType.visiblePassword,
      validator: (String value){
        if(value.isEmpty) {
          return 'Password is required';
        }
        return null;
      },
      onSaved: (String value){
        _password = value;
      },
    );
  }
  Widget _confirmPassword(){
    return TextFormField(
      decoration: InputDecoration(
          labelText: ' Confirm Password',
          hintText: '',
          prefixIcon: Icon(Icons.lock),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          )),
      keyboardType: TextInputType.visiblePassword,
      validator: (String value){
        if(value.isEmpty && value != _password) {
          return 'Incorrect Input';
        }
        return null;
      },
      onSaved: (String value){
        _confirm = value;
      },
    );
  }
  Widget _buildPhoneNumber(){
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Phone Number',
          prefixText: "+251",
          hintText: '912121212',
          prefixIcon: Icon(Icons.phone),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          )),
      validator: (String value) {
        if(value.isEmpty){
          return 'Phone number is required';
        }
        return null;
      },
    );
  }
  Widget _buildSex(){
    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey,

          )
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: dropdownValue,
        icon: const Icon(Icons.arrow_drop_down_circle_outlined),
        iconSize: 20,
        elevation: 15,
        style: const TextStyle(
        ),
        onChanged: (String newValue){
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: <String> ['Male', 'Female']
            .map<DropdownMenuItem<String>>((String value){
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
  Widget _buildLanguage(){
    // I wanna make this a check box
    return  Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: Colors.grey),
      ),
      child: DropdownButton(
        isExpanded: true,
        value: lang_Value,
        icon: const Icon(Icons.arrow_drop_down_circle_outlined),
        iconSize: 20,
        elevation: 15,
        style: const TextStyle(
        ),
        onChanged: (String newValue){
          setState(() {
            lang_Value = newValue;
          });
        },
        items: <String> ['Amharic','Tigrigna', 'Oromifa','English', 'Spanish', 'French']
            .map<DropdownMenuItem<String>>((String value){
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
  Widget _takePicture() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: Colors.grey),
      ),
      child: Row(
        children: [
          Center(
            child: _image == null
                ? Text('No image selected.')
                : Image.file(_image),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add Guides',
          style: kTitleTextStyle,),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildName(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildEmail(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildPassword(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _confirmPassword(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildPhoneNumber(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildSex(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildLanguage(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _takePicture(),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: FloatingActionButton(
                  onPressed: getImage,
                  tooltip: 'Pick Image',
                  child: Icon(Icons.add_a_photo),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Expanded(
                  child: BottomButton(
                      buttonTitle: 'Submit',
                      onTap: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if(_formKey.currentState.validate()){
                          // if the form is valid call the server or save the information
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Processing Data')));
                        }
                        print("submit all the information");
                        _formKey.currentState.save();
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}