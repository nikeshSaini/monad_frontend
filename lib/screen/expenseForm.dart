import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../style/appStyle.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }

// Default selected option
  File? _selectedImage; // Define selectedImage variable
// Define _image variable
  var image;
  bool _isSubmitting = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _localTravelController = TextEditingController();
  final TextEditingController _intercityTravelController =
      TextEditingController();
  final TextEditingController _lodgingAmountController =
      TextEditingController();
  final TextEditingController _mealAmountController = TextEditingController();
  final TextEditingController _otherExpensesController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expense Form',
          style: TextStyle(color: kthirdColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.currency_rupee, color: kthirdColor),
                      Text(
                        "Expenses",
                        style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: kthirdColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: screenHeight * 0.14,
                  child: TextFormField(
                    controller: _descriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the description';
                      }
                      return null; // Return null if the input is valid
                    },
                    maxLines: 10,
                    decoration: const InputDecoration(
                      labelText: "Description",
                      hintText: "Write the description of Work",
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
                        child: Icon(Icons.edit_note),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ktextColor),
                        gapPadding: 10,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                        gapPadding: 10,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .red), // Border color when there's an error
                        gapPadding: 10,
                      ),
                      errorStyle: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _locationController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter the Location";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Location",
                    hintText: "Enter your Location",
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 20,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
                      child: Icon(Icons.location_on_outlined),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ktextColor),
                      gapPadding: 10,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                      gapPadding: 10,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Colors.red), // Border color when there's an error
                      gapPadding: 10,
                    ),
                    errorStyle: TextStyle(
                        color: Colors
                            .red), //used to when its not in used or tapped
                  ),
                ),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    Text('Travel Expenses:'),
                    SizedBox(width: 16),
                  ],
                ),
                const SizedBox(height: 16),

                //ya se
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _localTravelController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Local Travel',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: ktextColor),
                                gapPadding: 10,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kPrimaryColor),
                                gapPadding: 10,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors
                                        .red), // Border color when there's an error
                                gapPadding: 10,
                              ),
                              errorStyle: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          '+',
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _intercityTravelController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Intercity Travel',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: ktextColor),
                                gapPadding: 10,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kPrimaryColor),
                                gapPadding: 10,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors
                                        .red), // Border color when there's an error
                                gapPadding: 10,
                              ),
                              errorStyle: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          '+',
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(width: 6),
                      ],
                    ),
                    const SizedBox(
                        height: 16), // Add some space between the rows
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _lodgingAmountController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Lodging Amount',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: ktextColor),
                                gapPadding: 10,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kPrimaryColor),
                                gapPadding: 10,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors
                                        .red), // Border color when there's an error
                                gapPadding: 10,
                              ),
                              errorStyle: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          '+',
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _mealAmountController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Meal Amount',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: ktextColor),
                                gapPadding: 10,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kPrimaryColor),
                                gapPadding: 10,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors
                                        .red), // Border color when there's an error
                                gapPadding: 10,
                              ),
                              errorStyle: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          '+',
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _otherExpensesController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Other Expenses',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: ktextColor),
                                gapPadding: 10,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kPrimaryColor),
                                gapPadding: 10,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors
                                        .red), // Border color when there's an error
                                gapPadding: 10,
                              ),
                              errorStyle: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                        height: 16), // Add some space between the rows
                    ElevatedButton.icon(
                      onPressed: () async {
                        _pickImage();
                      },
                      icon: const Icon(Icons.upload), // Icon to be displayed
                      label: _selectedImage != null
                          ? const Text('Change the Screenshot')
                          : const Text(
                              'Upload Screenshot'), // Text to be displayed
                    ),

                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (_selectedImage == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please upload Image')),
                            );
                          } else {
                            // setState(() {
                            //   _isSubmitting = true;
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(content: Text('Submitted')),
                            // );
                            //   Future.delayed(const Duration(seconds: 2), () {
                            //     Navigator.of(context).pop();
                            //   });
                            // });
                            // call the api to upload the file
                            _apiSubmit();
                          }

                          // All fields are valid
                          // Update button color to green temporarily to indicate submission
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(content: Text('Processing Data')),
                          // );

                          // Perform your submit logic here
                          // For example, you can pop the screen after a delay
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isSubmitting
                            ? Colors.green
                            : null, // Change button color to green while submitting
                      ),
                      child: _isSubmitting
                          ? const CircularProgressIndicator() // Show a loading indicator while submitting
                          : const Text('Submit'),
                    ),
                    const SizedBox(height: 16),
                    _selectedImage != null
                        ? Image.file(_selectedImage!)
                        : const SizedBox.shrink(),
                    const SizedBox(height: 16),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    setState(() {
      image = pickedImage.path;
      _selectedImage = File(pickedImage.path);
    });
  }

  // Future<void> _apiSubmit() async {
  //   // ScaffoldMessenger.of(context).showSnackBar(
  //   //   // const SnackBar(content: Text('Submitted')),
  //   // );
  //   print(_descriptionController.text);
  //   print("good to go");
  //   try {
  //     final response = await http.post(
  //         Uri.parse('http://172.27.208.1:3000/api/users/expenseform'),
  //         headers: {
  //           'Content-Type': 'application/json',
  //         },
  //         body: {
  //           'expense[description]': _descriptionController.text,
  //           'expense[location]': _locationController.text,
  //           'expense[local]': _locationController.text,
  //           'expense[intercity]': _intercityTravelController.text,
  //           'expense[lodging]': _lodgingAmountController.text,
  //           'expense[meal]': _mealAmountController.text,
  //           'expense[other]': _otherExpensesController.text,
  //           'img': http.MultipartFile.fromPath("img", image),
  //         });
  //     if (response.statusCode == 200) {
  //       // var jsonResponse = jsonDecode(response.body);
  //       // final String token = jsonResponse['token'];
  //       // Navigator.pushReplacement(
  //       //   context,
  //       //   MaterialPageRoute(builder: (context) => const HomePage()),
  //       // );
  //       // Navigator.push(
  //       //     context,
  //       //     MaterialPageRoute(
  //       //         builder: (context) => HomePage(
  //       //               token: token,
  //       //             )));
  //       print("done");
  //       // print(response.body);
  //     } else {
  //       print('failed');
  //       print(response.statusCode);
  //     }
  //   } catch (e) {
  //     print(e);
  //     // Handle exceptions, e.g., network errors
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('An error occurred. Please try again later.'),
  //       ),
  //     );
  //   }
  // }
  Future<void> _apiSubmit() async {
    _isSubmitting = true;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final prefsvar = prefs.getString('token');

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://172.21.192.1:3000/api/users/expenseform'),
      );
      // Add form fields
      request.fields['expense[description]'] = _descriptionController.text;
      request.fields['expense[location]'] = _locationController.text;
      request.fields['expense[local]'] = _localTravelController.text;
      request.fields['expense[intercity]'] = _intercityTravelController.text;
      request.fields['expense[lodging]'] = _lodgingAmountController.text;
      request.fields['expense[meal]'] = _mealAmountController.text;
      request.fields['token'] = prefsvar!;
      request.fields['expense[others]'] = _otherExpensesController.text;

      // Add image file
      if (_selectedImage != null) {
        var imageFile =
            await http.MultipartFile.fromPath('img', _selectedImage!.path);
        request.files.add(imageFile);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        _isSubmitting = false;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Submitted'),
          ),
        );
        print("Upload successful");
        print(response.body);
      } else {
        _isSubmitting = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Upload failed with status code: ${response.statusCode}'),
          ),
        );
        print("Upload failed with status code: ${response.statusCode}");
        print(response.body);
      }
    } catch (e) {
      _isSubmitting = false;

      print("Error uploading: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred. Please try again later.'),
        ),
      );
    }
  }
}

void main() {
  runApp(const MaterialApp(
    home: ExpenseForm(),
  ));
}
