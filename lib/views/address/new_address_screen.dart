// import 'package:dry_fish/Constants/app_colors.dart';
// import 'package:flutter/material.dart';

// class NewAddressScreen extends StatefulWidget {
//   const NewAddressScreen({super.key});

//   @override
//   State<NewAddressScreen> createState() => _NewAddressScreenState();
// }

// class _NewAddressScreenState extends State<NewAddressScreen> {
//   final _formKey = GlobalKey<FormState>();

//   // 🔹 Controllers
//   final _nameController = TextEditingController();
//   final _mobileController = TextEditingController();
//   final _houseController = TextEditingController();
//   final _blockController = TextEditingController();
//   final _buildingController = TextEditingController();
//   final _streetController = TextEditingController();
//   final _landmarkController = TextEditingController();
//   final _pincodeController = TextEditingController();
//   final _localityController = TextEditingController();

//   String selectedTag = "HOME";

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _mobileController.dispose();
//     _houseController.dispose();
//     _blockController.dispose();
//     _buildingController.dispose();
//     _streetController.dispose();
//     _landmarkController.dispose();
//     _pincodeController.dispose();
//     _localityController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // ✅ Cache MediaQuery values (no multiple lookups)
//     final size = MediaQuery.sizeOf(context);
//     final width = size.width;
//     final height = size.height;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.extraLightestPrimary,
//         elevation: 1,
//         centerTitle: true,
//         title: const Text(
//           "Add Address",
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Form(
//         key: _formKey,
//         child: ListView(
//           padding: EdgeInsets.symmetric(horizontal: width * 0.05),
//           children: [
//             SizedBox(height: height * 0.015),
//             _buildTextField(
//               "NAME",
//               "Enter name",
//               _nameController,
//               validator: (v) =>
//                   v == null || v.isEmpty ? "Name is required" : null,
//             ),
//             _buildMobileField(width, height),
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildTextField(
//                     "HOUSE/FLAT NO",
//                     "Flat No",
//                     _houseController,
//                     validator: (v) =>
//                         v == null || v.isEmpty ? "Required" : null,
//                   ),
//                 ),
//                 SizedBox(width: width * 0.03),
//                 Expanded(
//                   child: _buildTextField(
//                     "BLOCK NAME (OPTIONAL)",
//                     "Block Name",
//                     _blockController,
//                   ),
//                 ),
//               ],
//             ),
//             _buildTextField(
//               "BUILDING NAME",
//               "Building Name",
//               _buildingController,
//               validator: (v) => v == null || v.isEmpty ? "Required" : null,
//             ),
//             _buildTextField(
//               "STREET",
//               "Street",
//               _streetController,
//               validator: (v) => v == null || v.isEmpty ? "Required" : null,
//             ),
//             _buildTextField("LANDMARK", "Landmark", _landmarkController),
//             _buildTextField(
//               "PINCODE",
//               "226012",
//               _pincodeController,
//               keyboardType: TextInputType.number,
//               validator: (v) {
//                 if (v == null || v.isEmpty) return "Required";
//                 if (v.length != 6) return "Enter valid 6-digit pincode";
//                 return null;
//               },
//             ),
//             _buildTextField(
//               "LOCALITY",
//               "L D A Colony",
//               _localityController,
//               validator: (v) => v == null || v.isEmpty ? "Required" : null,
//             ),
//             SizedBox(height: height * 0.02),

//             // 🔹 Save As
//             Text(
//               "SAVE AS",
//               style: TextStyle(
//                 fontSize: width * 0.04,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.grey[800],
//               ),
//             ),
//             SizedBox(height: height * 0.01),
//             SaveAsSelector(
//               selected: selectedTag,
//               onSelect: (tag) => setState(() => selectedTag = tag),
//             ),
//             SizedBox(height: height * 0.04),

//             // 🔹 Save Button
//             SafeArea(
//               minimum: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewPadding.bottom + 12,
//               ),
//               child: SizedBox(
//                 width: double.infinity,
//                 height: height * 0.065,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(width * 0.03),
//                     ),
//                   ),
//                   onPressed: _onSavePressed,
//                   child: Text(
//                     "SAVE ADDRESS",
//                     style: TextStyle(
//                       fontSize: width * 0.04,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: height * 0.03),
//           ],
//         ),
//       ),
//     );
//   }

//   // 🔹 TextField builder
//   Widget _buildTextField(
//     String label,
//     String hint,
//     TextEditingController controller, {
//     String? Function(String?)? validator,
//     TextInputType? keyboardType,
//   }) {
//     final size = MediaQuery.sizeOf(context);

//     return Padding(
//       padding: EdgeInsets.only(top: size.height * 0.02),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             maxLines: 1,
//             style: TextStyle(
//               fontSize: size.width * 0.04,
//               fontWeight: FontWeight.w600,
//               color: Colors.green[800],
//             ),
//           ),
//           SizedBox(height: size.height * 0.008),
//           TextFormField(
//             controller: controller,
//             validator: validator,
//             keyboardType: keyboardType,
//             textInputAction: TextInputAction.next,
//             onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
//             decoration: InputDecoration(
//               hintText: hint,
//               hintStyle: TextStyle(
//                 fontSize: size.width * 0.035,
//                 color: Colors.grey,
//               ),
//               contentPadding: EdgeInsets.symmetric(
//                 horizontal: size.width * 0.03,
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(size.width * 0.03),
//                 borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(size.width * 0.03),
//                 borderSide: const BorderSide(color: Colors.green, width: 1.5),
//               ),
//               errorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(size.width * 0.03),
//                 borderSide: const BorderSide(color: Colors.red, width: 1),
//               ),
//               focusedErrorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(size.width * 0.03),
//                 borderSide: const BorderSide(color: Colors.red, width: 1.2),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // 🔹 Mobile number field
//   Widget _buildMobileField(double width, double height) {
//     return Padding(
//       padding: EdgeInsets.only(top: height * 0.02),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "MOBILE NUMBER",
//             style: TextStyle(
//               fontSize: width * 0.04,
//               fontWeight: FontWeight.w600,
//               color: Colors.green[800],
//             ),
//           ),
//           SizedBox(height: height * 0.01),
//           Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: width * 0.025,
//                   vertical: height * 0.014,
//                 ),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey.shade400),
//                   borderRadius: BorderRadius.circular(width * 0.03),
//                 ),
//                 child: const Row(
//                   children: [
//                     Icon(Icons.flag, color: Colors.orange, size: 20),
//                     SizedBox(width: 4),
//                     Text("+91"),
//                   ],
//                 ),
//               ),
//               SizedBox(width: width * 0.03),
//               Expanded(
//                 child: TextFormField(
//                   controller: _mobileController,
//                   keyboardType: TextInputType.phone,
//                   validator: (v) {
//                     if (v == null || v.isEmpty) return "Mobile number required";
//                     if (v.length != 10) return "Enter valid 10-digit number";
//                     return null;
//                   },
//                   textInputAction: TextInputAction.next,
//                   onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
//                   decoration: InputDecoration(
//                     hintText: "9760203435",
//                     hintStyle: TextStyle(
//                       fontSize: width * 0.035,
//                       color: Colors.grey,
//                     ),
//                     contentPadding: EdgeInsets.symmetric(
//                       horizontal: width * 0.03,
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(width * 0.03),
//                       borderSide: BorderSide(
//                         color: Colors.grey.shade400,
//                         width: 1,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(width * 0.03),
//                       borderSide: const BorderSide(
//                         color: Colors.green,
//                         width: 1.5,
//                       ),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(width * 0.03),
//                       borderSide: const BorderSide(color: Colors.red, width: 1),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // 🔹 Save pressed handler
//   void _onSavePressed() {
//     if (_formKey.currentState?.validate() ?? false) {
//       FocusScope.of(context).unfocus(); // close keyboard immediately
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Address saved as $selectedTag"),
//           backgroundColor: Colors.green,
//         ),
//       );
//     }
//   }
// }

// /// 🔸 Separate lightweight widget for "Save As" buttons
// class SaveAsSelector extends StatelessWidget {
//   final String selected;
//   final Function(String) onSelect;

//   const SaveAsSelector({
//     super.key,
//     required this.selected,
//     required this.onSelect,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.sizeOf(context);
//     final width = size.width;
//     final height = size.height;

//     return Row(
//       children: [
//         _buildButton("HOME", Icons.home, width, height),
//         SizedBox(width: width * 0.03),
//         _buildButton("WORK", Icons.business_center, width, height),
//         SizedBox(width: width * 0.03),
//         _buildButton("OTHER", Icons.location_on, width, height),
//       ],
//     );
//   }

//   Widget _buildButton(String text, IconData icon, double width, double height) {
//     final isSelected = selected == text;
//     return Expanded(
//       child: InkWell(
//         borderRadius: BorderRadius.circular(width * 0.03),
//         onTap: () => onSelect(text),
//         child: Container(
//           height: height * 0.05,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(width * 0.03),
//             border: Border.all(
//               color: isSelected ? Colors.green : Colors.grey,
//               width: 1,
//             ),
//             color: isSelected ? Colors.green.shade50 : Colors.transparent,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 icon,
//                 size: width * 0.045,
//                 color: isSelected ? Colors.green : Colors.grey,
//               ),
//               SizedBox(width: width * 0.01),
//               Text(
//                 text,
//                 style: TextStyle(
//                   fontSize: width * 0.035,
//                   fontWeight: FontWeight.w600,
//                   color: isSelected ? Colors.green : Colors.grey[800],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:dry_fish/Constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../repositories/update_address_repo.dart';
import '../../viewmodels/update_address_controller.dart';

class NewAddressScreen extends StatefulWidget {
  const NewAddressScreen({super.key});

  @override
  State<NewAddressScreen> createState() => _NewAddressScreenState();
}

class _NewAddressScreenState extends State<NewAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _houseController = TextEditingController();
  final _blockController = TextEditingController();
  final _buildingController = TextEditingController();
  final _streetController = TextEditingController();
  final _landmarkController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _localityController = TextEditingController();

  String selectedTag = "HOME";

  final AddressController _addressController = Get.put(
    AddressController(Updateaddressrepo()),
  );

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _houseController.dispose();
    _blockController.dispose();
    _buildingController.dispose();
    _streetController.dispose();
    _landmarkController.dispose();
    _pincodeController.dispose();
    _localityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.extraLightestPrimary,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          "Add Address",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          children: [
            SizedBox(height: height * 0.015),
            _buildTextField(
              "NAME",
              "Enter name",
              _nameController,
              validator: (v) =>
                  v == null || v.isEmpty ? "Name is required" : null,
            ),
            _buildMobileField(width, height),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    "HOUSE/FLAT NO",
                    "Flat No",
                    _houseController,
                    validator: (v) =>
                        v == null || v.isEmpty ? "Required" : null,
                  ),
                ),
                SizedBox(width: width * 0.03),
                Expanded(
                  child: _buildTextField(
                    "BLOCK NAME (OPTIONAL)",
                    "Block Name",
                    _blockController,
                  ),
                ),
              ],
            ),
            _buildTextField(
              "BUILDING NAME",
              "Building Name",
              _buildingController,
              validator: (v) => v == null || v.isEmpty ? "Required" : null,
            ),
            _buildTextField(
              "STREET",
              "Street",
              _streetController,
              validator: (v) => v == null || v.isEmpty ? "Required" : null,
            ),
            _buildTextField("LANDMARK", "Landmark", _landmarkController),
            _buildTextField(
              "PINCODE",
              "226012",
              _pincodeController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              validator: (v) {
                if (v == null || v.isEmpty) return "Required";
                if (v.length != 6) return "Enter valid 6-digit pincode";
                return null;
              },
            ),
            _buildTextField(
              "LOCALITY",
              "L D A Colony",
              _localityController,
              validator: (v) => v == null || v.isEmpty ? "Required" : null,
            ),
            SizedBox(height: height * 0.02),

            // 🔹 Save As buttons inline
            Text(
              "SAVE AS",
              style: TextStyle(
                fontSize: width * 0.04,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: height * 0.01),
            Row(
              children: ["HOME", "WORK", "OTHER"].map((tag) {
                final isSelected = selectedTag == tag;
                IconData icon;
                if (tag == "HOME")
                  icon = Icons.home;
                else if (tag == "WORK")
                  icon = Icons.business_center;
                else
                  icon = Icons.location_on;

                return Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(width * 0.03),
                    onTap: () => setState(() => selectedTag = tag),
                    child: Container(
                      height: height * 0.05,
                      margin: EdgeInsets.only(
                        right: tag != "OTHER" ? width * 0.03 : 0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.03),
                        border: Border.all(
                          color: isSelected ? Colors.green : Colors.grey,
                          width: 1,
                        ),
                        color: isSelected
                            ? Colors.green.shade50
                            : Colors.transparent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            icon,
                            size: width * 0.045,
                            color: isSelected ? Colors.green : Colors.grey,
                          ),
                          SizedBox(width: width * 0.01),
                          Text(
                            tag,
                            style: TextStyle(
                              fontSize: width * 0.035,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? Colors.green
                                  : Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: height * 0.04),

            // 🔹 Save Button with loading
            SafeArea(
              minimum: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewPadding.bottom + 12,
              ),
              child: SizedBox(
                width: double.infinity,
                height: height * 0.065,
                child: Obx(() {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(width * 0.03),
                      ),
                    ),
                    onPressed: _addressController.isLoading.value
                        ? null
                        : _onSavePressed,
                    child: _addressController.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "SAVE ADDRESS",
                            style: TextStyle(
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  );
                }),
              ),
            ),
            SizedBox(height: height * 0.03),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController controller, {
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int? maxLength, // optional, only set when needed
  }) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            maxLines: 1,
            style: TextStyle(
              fontSize: size.width * 0.04,
              fontWeight: FontWeight.w600,
              color: Colors.green[800],
            ),
          ),
          SizedBox(height: size.height * 0.008),
          TextFormField(
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            textInputAction: TextInputAction.next,
            maxLines: 1, // ensure single line
            maxLength: maxLength, // will be null for normal fields
            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            decoration: InputDecoration(
              hintText: hint,
              counterText: maxLength != null
                  ? ""
                  : null, // hide counter only if maxLength set
              hintStyle: TextStyle(
                fontSize: size.width * 0.035,
                color: Colors.grey,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: size.width * 0.03,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.03),
                borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.03),
                borderSide: const BorderSide(color: Colors.green, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.03),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.03),
                borderSide: const BorderSide(color: Colors.red, width: 1.2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileField(double width, double height) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "MOBILE NUMBER",
            style: TextStyle(
              fontSize: width * 0.04,
              fontWeight: FontWeight.w600,
              color: Colors.green[800],
            ),
          ),
          SizedBox(height: height * 0.01),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.025,
                  vertical: height * 0.014,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(width * 0.03),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.flag, color: Colors.orange, size: 20),
                    SizedBox(width: 4),
                    Text("+91"),
                  ],
                ),
              ),
              SizedBox(width: width * 0.03),
              Expanded(
                child: TextFormField(
                  maxLength: 10,
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Mobile number required";
                    if (v.length != 10) return "Enter valid 10-digit number";
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  decoration: InputDecoration(
                    hintText: "9760203435",
                    counterText: "",

                    hintStyle: TextStyle(
                      fontSize: width * 0.035,
                      color: Colors.grey,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: width * 0.03,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.03),
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.03),
                      borderSide: const BorderSide(
                        color: Colors.green,
                        width: 1.5,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.03),
                      borderSide: const BorderSide(color: Colors.red, width: 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onSavePressed() async {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();

      await _addressController.updateAddress(
        address:
            "${_houseController.text}, ${_buildingController.text}, ${_streetController.text}",
        city: _localityController.text,
        state: _blockController.text.isEmpty ? "N/A" : _blockController.text,
        country: "India",
        zipcode: _pincodeController.text,
      );

      final response = _addressController.updateResponse.value;
      if (response?.status == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response?.message ?? "Address updated"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _addressController.errorMessage.value.isNotEmpty
                  ? _addressController.errorMessage.value
                  : "Failed to update address",
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
