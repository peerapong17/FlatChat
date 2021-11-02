import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:login_ui/auth/services/auth.dart';
import 'package:login_ui/food-shop/models/bill.dart' as M;
import 'package:login_ui/food-shop/models/food_order.dart';
import 'package:login_ui/food-shop/state/bill.dart';
import 'package:login_ui/services/bill_service.dart';
import 'package:login_ui/utils/build_elevated_button.dart';
import 'package:login_ui/utils/show_toast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'helpers/location_helper.dart';
import 'map_screen.dart';

class CheckOut extends StatefulWidget {
  final List<FoodOrder> userCart;
  final int total;

  const CheckOut({Key? key, required this.userCart, required this.total})
      : super(key: key);

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  Auth _auth = new Auth();
  BillService billService = new BillService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  String? _previewImageUrl;
  double? lattitude;
  double? longtitude;

  void _showPreview([double lat = 37.422, double lng = -122.084]) async {
    lattitude = lat;
    longtitude = lng;

    String? previewImageUrl = LocationHelper.getLocationPreviewImage(
      lat: lat,
      lng: lng,
    );

    String placeAddress = await LocationHelper.getPlaceAddress(
      lat,
      lng,
    );

    if (previewImageUrl == null) {
      return;
    }

    setState(
      () {
        _previewImageUrl = previewImageUrl;
        _addressController.text = placeAddress;
      },
    );
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final LocationData? locData = await Location().getLocation();

      if (locData == null) {
        return;
      }

      _showPreview(locData.latitude!, locData.longitude!);
    } catch (error) {
      return;
    }
  }

  Future<void> _selectOnMap(bool isSelected) async {
    if (longtitude == null && longtitude == null) {
      final LocationData? locData = await Location().getLocation();
      if (locData == null) {
        return;
      }

      longtitude = locData.longitude!;
      lattitude = locData.latitude!;
    }

    final LatLng? selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          lat: lattitude!,
          long: longtitude!,
          isSelected: isSelected,
        ),
      ),
    );

    if (selectedLocation == null) {
      return;
    }

    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  void initState() {
    super.initState();
    _getCurrentUserLocation();
    _emailController.text = _auth.currentUser().email!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Check out"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              Text(
                "Your Infomation",
                style: TextStyle(fontSize: 23),
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  label: Text("Name"),
                ),
                validator: RequiredValidator(
                  errorText: "Customer'Name is required",
                ),
              ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  label: Text("Email"),
                ),
                validator: MultiValidator(
                  [
                    RequiredValidator(
                      errorText: "Customer'Email is required",
                    ),
                    EmailValidator(errorText: "Email is not a valid Email")
                  ],
                ),
              ),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  label: Text("Phone"),
                ),
                validator: MultiValidator(
                  [
                    RequiredValidator(
                      errorText: "Customer'Phone number is required",
                    ),
                    MinLengthValidator(10,
                        errorText: "Phone number should be 10 characters long")
                  ],
                ),
              ),
              TextFormField(
                controller: _addressController,
                minLines: 6,
                maxLines: null,
                decoration: InputDecoration(
                  label: Text("Addrees"),
                ),
                validator: MultiValidator(
                  [
                    RequiredValidator(
                      errorText: "Customer'Address number is required",
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await _selectOnMap(true);
                },
                child: Container(
                  height: 170,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                  ),
                  child: _previewImageUrl == null
                      ? Text(
                          'No Location Chosen',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 17),
                        )
                      : Image.network(
                          _previewImageUrl!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _getCurrentUserLocation,
                    child: Text("Get Current Address"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _selectOnMap(false);
                    },
                    child: Text("Open Map"),
                  ),
                ],
              ),
              Consumer<M.Bill>(
                builder: (context, billProvider, child) => buildElevatedButton(
                  label: "CheckOut",
                  color: Colors.green.shade500,
                  height: 40,
                  fontSize: 27,
                  func: () async {
                    if (_formKey.currentState!.validate()) {
                      List<FoodOrder> userCart = [];
                      for (var item in widget.userCart) {
                        FoodOrder cartItem = FoodOrder(
                            id: item.id,
                            image: item.image,
                            name: item.name,
                            price: item.price,
                            amount: item.amount,
                            subTotal: item.calcSubTotal().toString());
                        userCart.add(cartItem);
                      }

                      Map<String, dynamic> bill = new M.Bill(
                        id: Uuid().v1(),
                        userId: _auth.currentUser().uid,
                        name: _nameController.text,
                        email: _emailController.text,
                        phone: _phoneController.text,
                        address: _addressController.text,
                        total: widget.total.toString(),
                        foodOrder: widget.userCart,
                        orderedAt: Timestamp.fromDate(DateTime.now()),
                      ).toJson();

                      await billService.addBill(context, bill);

                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      prefs.clear();

                      showToast("Order success", Colors.green).then(
                        (value) => Navigator.pop(context),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
