import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/post_controller.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/size_config.dart';

class AddPost extends StatelessWidget {
  PostController _controller = Get.find<PostController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          buildTextField(context),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildActionButtons()
        ],
      ),
    );
  }

  Container buildActionButtons() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildDissmisButton(),
          buildSendButton(),
        ],
      ),
    );
  }

  Expanded buildSendButton() {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          _controller.sendPost();
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            border: Border.all(color: Colors.green),
          ),
          child: Center(
              child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    "Paylaş",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.green,
                ),
              )
            ],
          )),
        ),
      ),
    );
  }

  Expanded buildDissmisButton() {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          Get.back();
        },
        child: Container(
          padding: EdgeInsets.all(10),
          child: Center(
              child: Text(
            "Vazgeç",
            style: TextStyle(color: kIconColor),
          )),
        ),
      ),
    );
  }

  Theme buildTextField(BuildContext context) {
    return Theme(
      data: Theme.of(context)
          .copyWith(inputDecorationTheme: inputDecorationTheme()),
      child: TextField(
        controller: _controller.postTextController,
        minLines: 3,
        maxLines: 6,
        maxLength: 150,
        decoration: InputDecoration(
          hintText: "Ne paylaşmak istersin?",
        ),
      ),
    );
  }
}

InputDecorationTheme inputDecorationTheme() {
  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(color: kPrimaryColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    //floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    focusColor: kPrimaryColor,
    border: outlineInputBorder,
  );
}
