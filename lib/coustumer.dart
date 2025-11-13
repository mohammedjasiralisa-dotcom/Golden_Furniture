import 'package:flutter/material.dart';
import 'strings.dart';
import 'language.dart';

class CoustumerScreen extends StatefulWidget {
	final String? initialName;
	final String? initialPhone;

	const CoustumerScreen({super.key, this.initialName, this.initialPhone});

	@override
	State<CoustumerScreen> createState() => _CoustumerScreenState();
}

class _CoustumerScreenState extends State<CoustumerScreen> {
		final _formKey = GlobalKey<FormState>();
		final TextEditingController _amountController = TextEditingController();
		final TextEditingController _nameController = TextEditingController();
		final TextEditingController _phoneController = TextEditingController();
		final TextEditingController _productController = TextEditingController();
		final TextEditingController _addressController = TextEditingController();

	@override
	void initState() {
		super.initState();
		if (widget.initialName != null) _nameController.text = widget.initialName!;
		if (widget.initialPhone != null) _phoneController.text = widget.initialPhone!;
	}

	void _submit() {
		if (!_formKey.currentState!.validate()) return;
		final data = {
			'amount': _amountController.text.trim(),
			'name': _nameController.text.trim(),
			'mobile': _phoneController.text.trim(),
			'product': _productController.text.trim(),
			'address': _addressController.text.trim(),
		};
		Navigator.pop(context, data);
	}

	InputDecoration _fieldDecoration() {
		return InputDecoration(
			hintText: Strings.get('value', globalLanguageCode),
			filled: true,
			fillColor: const Color.fromARGB(192, 255, 255, 255),
			contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
			border: OutlineInputBorder(
				borderRadius: BorderRadius.circular(10),
				borderSide: BorderSide(color: Colors.grey.shade300),
			),
			enabledBorder: OutlineInputBorder(
				borderRadius: BorderRadius.circular(10),
				borderSide: BorderSide(color: Colors.grey.shade300),
			),
		);
	}	@override
	Widget build(BuildContext context) {
		return Scaffold(
					appBar: AppBar(
						title: Text(Strings.get('add_customer_form', globalLanguageCode)),
						centerTitle: true,
						backgroundColor: const Color.fromRGBO(255, 255, 255, 0.9),
						foregroundColor: Colors.black87,
						elevation: 0,
					),
					body: SafeArea(
						child: Container(
							padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
							// subtle background tint
							decoration: const BoxDecoration(
								color: Color.fromRGBO(235, 247, 245, 0.86),
							),
							child: Form(
								key: _formKey,
								child: SingleChildScrollView(
									padding: const EdgeInsets.only(bottom: 96),
									child: Column(
										crossAxisAlignment: CrossAxisAlignment.start,
										children: [
											// Name
											Text(Strings.get('name', globalLanguageCode), style: const TextStyle(fontSize: 14)),
											const SizedBox(height: 8),
											TextFormField(
												controller: _nameController,
												decoration: _fieldDecoration(),
												validator: (v) => (v == null || v.trim().isEmpty) ? Strings.get('enter_name', globalLanguageCode) : null,
											),

											const SizedBox(height: 14),
											// Mobile Number
											Text(Strings.get('mobile_no', globalLanguageCode), style: const TextStyle(fontSize: 14)),
											const SizedBox(height: 8),
											TextFormField(
												controller: _phoneController,
												keyboardType: TextInputType.phone,
												decoration: _fieldDecoration(),
												validator: (v) => (v == null || v.trim().isEmpty) ? Strings.get('enter_mobile_number', globalLanguageCode) : null,
											),

											const SizedBox(height: 14),
											// Product
											Text(Strings.get('product', globalLanguageCode), style: const TextStyle(fontSize: 14)),
											const SizedBox(height: 8),
											TextFormField(
												controller: _productController,
												decoration: _fieldDecoration(),
											),

											const SizedBox(height: 14),
											// Price (Product Amount)
											Text(Strings.get('product_amount', globalLanguageCode), style: const TextStyle(fontSize: 14)),
											const SizedBox(height: 8),
											Container(
												height: 40,
												decoration: BoxDecoration(
													color: const Color.fromARGB(189, 240, 240, 240),
													borderRadius: BorderRadius.circular(8),
												),
												child: TextFormField(
													controller: _amountController,
													keyboardType: TextInputType.numberWithOptions(decimal: true),
													decoration: InputDecoration(
														hintText: Strings.get('value', globalLanguageCode),
														border: InputBorder.none,
														contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
													),
													validator: (v) => (v == null || v.trim().isEmpty) ? Strings.get('enter_amount', globalLanguageCode) : null,
												),
											),

											const SizedBox(height: 14),
											// Address
											Text(Strings.get('address', globalLanguageCode), style: const TextStyle(fontSize: 14)),
											const SizedBox(height: 8),
											TextFormField(
												controller: _addressController,
												decoration: _fieldDecoration(),
												keyboardType: TextInputType.multiline,
												maxLines: 4,
											),

											const SizedBox(height: 18),
										],
									),
								),
							),
						),
					),
					bottomNavigationBar: Padding(
						padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
						child: SizedBox(
							height: 56,
							child: ElevatedButton(
								onPressed: _submit,
								style: ElevatedButton.styleFrom(
									backgroundColor: const Color.fromARGB(255, 229, 229, 231),
									shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
									elevation: 4,
								),
								child: Text(Strings.get('submit', globalLanguageCode), style: const TextStyle(fontSize: 16)),
							),
						),
					),
		);
	}
}
