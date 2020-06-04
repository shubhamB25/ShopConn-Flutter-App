import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/api/uploadProduct.dart';
import 'package:shopconn/models/SavedProductData.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:shopconn/notifier/bookNotifier.dart';
import '../const/Theme.dart';

class AddProuctScreen_Book extends StatefulWidget {
  String name;
  AddProuctScreen_Book({Key key, @required this.name}) : super(key: key);

  @override
  _AddProuctScreen_BookState createState() => _AddProuctScreen_BookState(name);
}

class _AddProuctScreen_BookState extends State<AddProuctScreen_Book> {
  Book _currentBook;
  String name;
  List<File> imageList = List(); //To store Path of each Images
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  initBook()
  {
    print("Initial Constructor");
    Future<FirebaseUser> user = getCurrendFirebaseUser();
    user.then((value) => {
      _currentBook.ownerId= value.uid,
      _currentBook.timestamp=Timestamp.now()

    });
    print("After firebase user call");
  }

  void _SelectImage() async //Function to keep track of all the image files that are needed to be uploaded
  {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageList.add(image);
    });
  }

  uploadData() async
  {
    print("Upload starting");
    bool ans =await  uploadProduct(_currentBook, imageList);

    print("Upload Finisehd");
    if(ans==true)
    {
        print("\n*******Upload Status********\n");
    print("Success");
    print("\n***************\n");

    }
    else
    {
        print("\n*******book screen********\n");
        print("FAILURE");
    print("\n***************\n");
    }

  }


  _AddProuctScreen_BookState(this.name)
  {
    initBook();
  }
  @override
  void initState() {
    super.initState();
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    BookNotifier bookNotifier =
        Provider.of<BookNotifier>(context, listen: false);
    _currentBook = Book();
    // String uid = getCurrentUser(authNotifier);
    // if (bookNotifier.currentBook != null) {
    //   _currentBook = bookNotifier.currentBook;
    // } else {
    //   _currentBook = Book();
    // }
    // _imageUrl = _currentFood.image;
  }

  // -----------------Author name Starts here-----------------//
  Widget _buildAuthorNameField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
          fillColor: sc_InputBackgroundColor,
          filled: true,
          prefixIcon: Icon(
            Icons.print,
            color: sc_ItemTitleColor,
          ),
          hintText: "Author Name",
          hintStyle: TextStyle(
            color: sc_InputHintTextColor,
            fontSize: 16.0,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
        ),
        keyboardType: TextInputType.text,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Author Name is required';
          }

          if (value.length < 5 || value.length > 50) {
            return 'Author Name must be betweem 5 and 50 characters';
          }

          return null;
        },
        onSaved: (String value) {
          _currentBook.name = value;
          print(value);
        },
      ),
    );
  }
  // -----------------Author name ends here-----------------//

  // -----------------Edition Starts here-----------------//
  Widget _buildEditionField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
          fillColor: sc_InputBackgroundColor,
          filled: true,
          prefixIcon: Icon(
            Icons.print,
            color: sc_ItemTitleColor,
          ),
          hintText: "Edition",
          hintStyle: TextStyle(
            color: sc_InputHintTextColor,
            fontSize: 16.0,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
        ),
        keyboardType: TextInputType.numberWithOptions(signed: true),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Edition is required';
          }

          if (value.length < 1 || value.length > 2) {
            return 'Edition must be betweem 1 and 2 characters';
          }

          return null;
        },
        onSaved: (String value) {
          _currentBook.edition = value;
          print(value);
        },
      ),
    );
  }
  // -----------------Edition ends here-----------------//

// -----------------Edition Starts here-----------------//
  Widget _buildDescriptionField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        maxLines: 5,
        decoration: InputDecoration(
          fillColor: sc_InputBackgroundColor,
          filled: true,
          prefixIcon: Icon(
            Icons.print,
            color: sc_ItemTitleColor,
          ),
          hintText: "Description",
          hintStyle: TextStyle(
            color: sc_InputHintTextColor,
            fontSize: 16.0,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
        ),
        keyboardType: TextInputType.text,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Description is required';
          }

          if (value.length < 5 || value.length > 100) {
            return 'Description must be betweem 4 and 100 characters';
          }

          return null;
        },
        onSaved: (String value) {
          _currentBook.description = value;
          print(value);
        },
      ),
    );
  }
  // -----------------Description ends here-----------------//

  @override
  Widget build(BuildContext context) {
    _currentBook.name = name;
    print("\n*******book screen********\n");
    print(_currentBook.name);
    print("\n***************\n");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Product",
          style: TextStyle(
            color: sc_AppBarTextColor,
          ),
        ),
        backgroundColor: sc_AppBarBackgroundColor,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //    onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Text(
                  "You Are Almost Done !!!!!!",
                  style: TextStyle(
                    color: sc_ItemInfoColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
              ),
              _buildAuthorNameField(),
              _buildEditionField(),
              _buildDescriptionField(),

              // -----------------Price Starts here-----------------//
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                color: sc_InputBackgroundColor,
                child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.print,
                        color: sc_ItemTitleColor,
                      ),
                      hintText: "Price",
                      hintStyle: TextStyle(
                        color: sc_InputHintTextColor,
                        fontSize: 16.0,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: sc_InputHintTextColor, width: 3.0),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: sc_PrimaryColor, width: 3.0),
                      ),
                      border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: sc_PrimaryColor, width: 3.0),
                      ),
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Author Name is required';
                      }

                      if (value.length> 5) {
                        return 'Price Cannot be greater than 99999';
                      }

                      return null;
                    },
                    onSaved: (String value){
                      _currentBook.price=double.tryParse(value);
                    },),

              ),
              // -----------------Price ends here-----------------//

              SizedBox(
                height: 30.0,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: sc_InputBackgroundColor,
                    child: Text('Choose Photo'),
                    onPressed: () {
                      _SelectImage();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => SavedProductScreen()),
                      // );
                    },
                  ),
                  Column(
                    children: <Widget>[
                      Text("image1.jpeg"),
                      Text("image2.jpeg"),
                      Text("image3.jpeg"),
                      Text("image4.jpeg"),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              GridView.count(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.fromLTRB(8, 2, 8, 0),
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  children: List.generate(imageList.length, (index) {
                    return Expanded(
                      child: Image(image: FileImage(imageList[index])),
                    );
                  })),

              //To Show the users the selected Images
              // GridView.count(crossAxisCount: 2,
              // children: List.generate(imageList.length, (index) {
              //   return Container(alignment: Alignment.center,
              //   height: 100,
              //   width: 100,
              //   child: Image(image: FileImage(imageList[index]) ),
              //   );
              // }),
              // ),
              //  Padding(
              //    padding: const EdgeInsets.all(8.0),
              //    child: GridView.count(crossAxisCount: 2,
              //    children: <Widget>[
              //      Text("hello")
              //    ],)

              //  ),
              // for(File image in imageList)
              //   Expanded(

              //       child: Image(image: FileImage(image),)),

// TODO: FOLLOWING ACTIONS SHOULD STICK TO BOTTOM
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      color: sc_InputBackgroundColor,
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => SavedProductScreen()),
                        // );
                      },
                    ),
                    RaisedButton(
                      color: sc_PrimaryColor,
                      child: Text(
                        'Post',
                        style: TextStyle(
                          color: sc_AppBarTextColor,
                          fontSize: 18.0,
                        ),
                      ),
                      onPressed: () {
                        if (!_formKey.currentState.validate()) {
                          print("Errororororororo");
                        } else { // No Error upload all the details to the database!!

                          
                          
                          _formKey.currentState.save();
                          uploadData();
                          print(_currentBook.toMap());
                        }
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => SavedProductScreen()),
                        // );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
