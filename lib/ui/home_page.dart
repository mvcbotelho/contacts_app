import 'package:contacts/helpers/contact_helpers.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();

  @override
  void initState() {
    super.initState();

    // Contact c = Contact();
    // c.name = "Agatha";
    // c.email = "agatha@mail.com";
    // c.phone = "999776600";
    // c.image = "imgTest";

    // helper.saveContact(c);

    helper.getAllContact().then((list) {
      print(list);
    });
  }

  @override
  build(_) => Container(
        child: Text("Corpo do app"),
      );
}
