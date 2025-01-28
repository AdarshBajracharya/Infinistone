import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinistone/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  Future _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          //Send image to server
          context.read<RegisterBloc>().add(
                LoadImage(file: _img!),
              );
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        prefixIcon: Icon(icon, color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white54, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
      obscureText: isPassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/reg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        height: double.infinity,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Hello.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.black,
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (context) => Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    checkCameraPermission();
                                    _browseImage(ImageSource.camera);
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.camera,
                                      color: Colors.white),
                                  label: const Text(
                                    'Camera',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    disabledForegroundColor:
                                        Colors.white.withOpacity(0.38),
                                    disabledBackgroundColor:
                                        Colors.white.withOpacity(0.12),
                                    side: const BorderSide(color: Colors.white),
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    _browseImage(ImageSource.gallery);
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.image,
                                      color: Colors.white),
                                  label: const Text(
                                    'Gallery',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    disabledForegroundColor:
                                        Colors.white.withOpacity(0.38),
                                    disabledBackgroundColor:
                                        Colors.white.withOpacity(0.12),
                                    side: const BorderSide(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: _img != null
                              ? FileImage(_img!)
                              : const AssetImage('assets/images/profile.png')
                                  as ImageProvider,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildTextField(
                      controller: firstNameController,
                      label: "First Name",
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: lastNameController,
                      label: "Last Name",
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: emailController,
                      label: "Email",
                      icon: Icons.email,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: phoneController,
                      label: "Phone Number",
                      icon: Icons.phone,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: addressController,
                      label: "Address",
                      icon: Icons.home,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: passwordController,
                      label: "Password",
                      icon: Icons.lock,
                      isPassword: true,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: confirmPasswordController,
                      label: "Confirm Password",
                      icon: Icons.lock_outline,
                      isPassword: true,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          final registerState =
                              context.read<RegisterBloc>().state;
                          final imageName = registerState.imageName;
                          context.read<RegisterBloc>().add(
                                RegisterUser(
                                  context: context,
                                  fName: firstNameController.text,
                                  lName: lastNameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  address: addressController.text,
                                  password: passwordController.text,
                                  image: imageName,
                                ),
                              );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 64),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 6,
                        shadowColor: Colors.grey.withOpacity(0.2),
                      ),
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
