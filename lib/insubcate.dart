library insubcate;

import 'package:animatedfloat/animatedfloat.dart';
import 'package:custom_dialog/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:net_store/mian.dart';
import 'package:flutter_svg/svg.dart';

class Insubcate extends StatefulWidget {
  final Color color;
  final String title;
  final Color scaffoldColor;

  const Insubcate({
    super.key,
    required this.color,
    required this.title,
    required this.scaffoldColor,
  });

  @override
  _InsubcateState createState() => _InsubcateState();
}

class _InsubcateState extends State<Insubcate> {
  final List<Widget> containers = [];
  final ScrollController scrollController = ScrollController();

  void _addProductContainer(String title, String price) {
    if (title.isNotEmpty && price.isNotEmpty) {
      setState(() {
        containers.add(buildProductContainer(title, price, context));
      });
    }
  }

  Widget buildProductContainer(
      String title, String price, BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NetStore.editProduct(color: widget.color),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                SvgPicture.asset(
                  'lib/images/product.svg',
                  package: 'subcate',
                  height: 33,
                  width: 33,
                ),
                const SizedBox(width: 16),
                Text(title,
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w300))),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.scaffoldColor,
      appBar: AppBar(
        title: Row(
          children: [
            // IconButton(
            //   icon: const Icon(Icons.arrow_back),
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            // ),
            const SizedBox(width: 8),
            Text(widget.title,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                )),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: containers.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        containers[index],
                        //  if (index != containers.length - 1)
                        const Divider(
                          thickness: 1,
                          height: 1,
                          color: Color(0xFFF4F4F4),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomAnimatedFloatingActionButton(
                  svgPath: 'lib/images/addProduct.svg',
                  package: 'insubcate',
                  text: 'Add product',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        final firstFieldController = TextEditingController();
                        final secondFieldController = TextEditingController();

                        return CustomDialog(
                          secicon: Icons.currency_rupee,
                          title: 'Add Product',
                          firstButtonColor: Colors.white,
                          firstButtonIconColor: const Color(0xFF03A758),
                          firstButtonAction: (String title) {
                            _addProductContainer(
                                title, secondFieldController.text);
                            Navigator.of(context).pop();
                          },
                          secondButtonColor: Colors.white,
                          firstFieldController: firstFieldController,
                          secondFieldController: secondFieldController,
                          maxLength: 100,
                          titleBackgroundColor: const Color(0xFF04938D),
                          secondButtonIconColor: const Color(0xFFFF1C1C),
                          firstButtonIcon: Icons.check,
                          secondButtonIcon: Icons.close,
                          secondButtonAction: () {
                            Navigator.of(context).pop();
                          },
                          hintText: 'Product Title',
                          hintText2: 'Selling price',
                        );
                      },
                    );
                  },
                  scrollController: scrollController,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
