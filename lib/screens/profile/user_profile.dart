import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:intl/intl.dart';
import 'package:media_picker_widget/media_picker_widget.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_management/constants.dart';
import 'package:vehicle_management/models/user_model.dart';
import 'package:vehicle_management/providers/auth_provider.dart';
import 'package:vehicle_management/screens/booking/payment_screen.dart';
import 'package:vehicle_management/widgets/done_icon.dart';

class UserProfile extends StatefulWidget {
  bool isFromDrawer = false;
  UserProfile({this.isFromDrawer});
  static const routeName = '/user-profile';
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  // final nameController = TextEditingController();
  // final emailController = TextEditingController();
  // final phoneController = TextEditingController();
  // final idController = TextEditingController();
  // final dateofBirthController = TextEditingController();
  // final postalController = TextEditingController();

  String fullName = '';
  String email = '';
  String phoneNumber = '';
  String nationalId = '123';
  String dateofBirth = '';
  bool isAdmin;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context, listen: false);
    UserModel user = authData.user;
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: GestureDetector(
              onTap: () => widget.isFromDrawer != null
                  ? ZoomDrawer.of(context).open()
                  : Navigator.of(context).pop(),
              child: Icon(
                Icons.arrow_back_ios_new,
              )),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UserPicture(),
              ],
            ),
            SizedBox(height: size.height * 0.05),
//FORM INPUT

            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    height: 50,
                    child: TextFormField(
                      // controller: controller,
                      initialValue: user.fullName != null
                          ? user.fullName
                          : 'Enter your full name',
                      onChanged: (val) {
                        setState(() {
                          fullName = val;
                        });
                      },
                      validator: (val) {
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          fullName = val;
                        });
                      },
                      decoration: InputDecoration(
                          labelText: 'Full name',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                  ///////////////////////////////////////////
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    height: 50,
                    child: TextFormField(
                      // controller: controller,
                      validator: (val) {
                        return null;
                      },
                      initialValue: user.email != null
                          ? user.email
                          : 'Enter your email address',
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      onSaved: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      decoration: InputDecoration(
                          labelText: 'Email address',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                  //////////////////////////////////////////
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    height: 50,
                    child: TextFormField(
                      initialValue: user.phoneNumber != null
                          ? user.phoneNumber
                          : 'Enter your phone number',
                      onChanged: (val) {
                        setState(() {
                          phoneNumber = val;
                        });
                      },
                      validator: (val) {
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          phoneNumber = val;
                        });
                      },
                      decoration: InputDecoration(
                          labelText: 'Phone number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                  //////////////////////////////
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    height: 50,
                    child: TextFormField(
                      // controller: controller,
                      initialValue: user.nationalId != null
                          ? user.nationalId
                          : 'Enter your National Id/Passport',
                      onChanged: (val) {
                        setState(() {
                          nationalId = val;
                        });
                      },
                      onSaved: (val) {
                        setState(() {
                          nationalId = val;
                        });
                      },
                      validator: (val) {
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'National Id/Passport',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                  //////////////////////////////////////////
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    height: 50,
                    child: TextFormField(
                      // controller: controller,
                      validator: (val) {
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          dateofBirth = val;
                        });
                      },
                      initialValue: user.dateOfBirth != null
                          ? user.dateOfBirth
                          : 'Enter your Date of birth',
                      onChanged: (val) {
                        setState(() {
                          dateofBirth = val;
                        });
                      },
                      decoration: InputDecoration(
                          labelText: 'Date of Birth',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),

                  //////////////////////////////
                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  //   height: 50,
                  //   child: TextFormField(
                  //     // controller: controller,
                  //     validator: (val) {
                  //       return null;
                  //     },
                  //     onSaved: (val) {
                  //       setState(() {
                  //         isAdmin = val;
                  //       });
                  //     },
                  //     initialValue: user.isAdmin != null
                  //         ? user.isAdmin
                  //         : 'Enter your Postal address',
                  //     onChanged: (val) {
                  //       setState(() {
                  //         isAdmin = val;
                  //       });
                  //     },
                  //     decoration: InputDecoration(
                  //         labelText: 'Postal Address',
                  //         border: OutlineInputBorder(
                  //           borderSide: BorderSide(color: Colors.grey),
                  //           borderRadius: BorderRadius.circular(10),
                  //         )),
                  //   ),
                  // ),
                ],
              ),
            ),

            SizedBox(height: size.height * 0.05),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () async {
                _formKey.currentState.save();
                authData.updateProfile(UserModel(
                  email: email,
                  isAdmin:
                      isAdmin != 'Enter your Postal address' ? isAdmin : null,
                  dateOfBirth: dateofBirth == 'Enter your Date of birth'
                      ? null
                      : DateTime.parse(dateofBirth),
                  fullName: fullName,
                  nationalId: nationalId != 'Enter your National Id/Passport'
                      ? nationalId
                      : null,
                  phoneNumber: phoneNumber,
                ));

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      content: DoneIcon(),
                    );
                  },
                );

                Navigator.pop(context);
              },
              color: kPrimary,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60.0, vertical: 15),
                child: Text(
                  'Save Changes',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ]),
        ));
  }
}

class UserPicture extends StatefulWidget {
  @override
  _UserPictureState createState() => _UserPictureState();
}

class _UserPictureState extends State<UserPicture> {
  List<Media> mediaList = [];
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<AuthProvider>(context).user;
    return Container(
      height: 110,
      width: 110,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 10),
                    )
                  ])),
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: user.imageUrl != null
                  ? CachedNetworkImageProvider(user.imageUrl)
                  : AssetImage('assets/images/avatar.png'),
            ),
          ),
          Positioned(
            right: -10,
            bottom: -2,
            child: GestureDetector(
              onTap: () => openImagePicker(context),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  backgroundColor: kPrimary,
                  radius: 16,
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openImagePicker(BuildContext context) {
    // openCamera(onCapture: (image){
    //   setState(()=> mediaList = [image]);
    // });
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20)),
        ),
        context: context,
        builder: (context) {
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).pop(),
              child: DraggableScrollableSheet(
                initialChildSize: 0.6,
                maxChildSize: 0.95,
                minChildSize: 0.6,
                builder: (ctx, controller) => AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    color: Colors.white,
                    child: MediaPicker(
                      scrollController: controller,
                      mediaList: mediaList,
                      onPick: (selectedList) {
                        setState(() => mediaList = selectedList);
                        Navigator.pop(context);
                      },
                      onCancel: () => Navigator.pop(context),
                      mediaCount: MediaCount.single,
                      mediaType: MediaType.image,
                      decoration: PickerDecoration(
                        cancelIcon: Icon(Icons.close),
                        albumTitleStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        actionBarPosition: ActionBarPosition.top,
                        blurStrength: 2,
                        completeText: 'Change',
                      ),
                    )),
              ));
        }).then((_) async {
      if (mediaList.isNotEmpty) {
        double mediaSize =
            mediaList.first.file.readAsBytesSync().lengthInBytes /
                (1024 * 1024);

        if (mediaSize < 1.0001) {
          final image = await FirebaseStorage.instance
              .ref(
                  'userData/profilePics/${FirebaseAuth.instance.currentUser.uid}')
              .putFile(mediaList.first.file);

          final url = await image.ref.getDownloadURL();
          await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser.uid)
              .update({
            'profilePic': url,
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Image should be less than 1 MB')));
        }

        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  content: DoneIcon(),
                ));

        Future.delayed(Duration(milliseconds: 2000))
            .then((_) => Navigator.pop(context));
      }
    });
  }
}
