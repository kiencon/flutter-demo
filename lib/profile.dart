import 'package:flutter/material.dart';
import 'package:hello_world/data_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _firstNameController = TextEditingController(
    text: '',
  );

  final TextEditingController _lastNameController = TextEditingController(
    text: '',
  );

  final TextEditingController _phoneNumberController = TextEditingController(
    text: '',
  );

  final TextEditingController _emailController = TextEditingController(
    text: '',
  );

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  _loadProfileData() async {
    await DataRepository.loadProfileData();
    _firstNameController.text = DataRepository.firstName;
    _lastNameController.text = DataRepository.lastName;
    _phoneNumberController.text = DataRepository.phoneNumber;
    _emailController.text = DataRepository.email;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Profile'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text("Welcome back ${DataRepository.loginName}!"),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'First name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Last name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: _phoneNumberController,
                        decoration: const InputDecoration(
                          labelText: 'Phone number',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed:
                          () => {
                            canLaunch(
                              "tel:${_phoneNumberController.text}",
                            ).then((isAbleToLaunch) {
                              if (isAbleToLaunch) {
                                launch("tel:${_phoneNumberController.text}");
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "You can't make phone calls from this device",
                                    ),
                                  ),
                                );
                              }
                            }),
                          },
                      icon: Icon(Icons.call),
                    ),
                    IconButton(
                      onPressed:
                          () => {
                            canLaunch(
                              "sms:${_phoneNumberController.text}",
                            ).then((isAbleToLaunch) {
                              if (isAbleToLaunch) {
                                launch("sms:${_phoneNumberController.text}");
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "You can't make a sms from this device",
                                    ),
                                  ),
                                );
                              }
                            }),
                          },
                      icon: Icon(Icons.sms),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email address',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed:
                          () => {
                            canLaunch("mailto:${_emailController.text}").then((
                              isAbleToLaunch,
                            ) {
                              if (isAbleToLaunch) {
                                launch("mailto:${_emailController.text}");
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "You can't send email from this device",
                                    ),
                                  ),
                                );
                              }
                            }),
                          },
                      icon: Icon(Icons.mail),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await DataRepository.saveProfileData(
                    _firstNameController.text,
                    _lastNameController.text,
                    _phoneNumberController.text,
                    _emailController.text,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Save data successfully")),
                  );
                },
                child: Text('Save Profile Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
