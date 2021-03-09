import 'dart:io';

import 'package:contacts/helpers/contact_helpers.dart';
import 'package:contacts/ui/contact_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();

  List<Contact> contactsList = [];

  @override
  void initState() {
    super.initState();

    _getAllContacts();
  }

  @override
  build(_) => Scaffold(
        appBar: AppBar(
          title: Text("Contatos"),
          backgroundColor: Colors.red,
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showContactPage();
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
        ),
        body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: contactsList.length,
          itemBuilder: (context, index) {
            return _contactCard(context, index);
          },
        ),
      );

  Widget _contactCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: contactsList[index].image != null
                        ? FileImage(File(contactsList[index].image))
                        : AssetImage('images/user.png'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contactsList[index].name ?? 'Usuário sem nome',
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      contactsList[index].email ?? '',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      contactsList[index].phone ?? '',
                      style: TextStyle(fontSize: 18.0),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        _showContactPage(contact: contactsList[index]);
      },
    );
  }

  void _showContactPage({Contact contact}) async {
    final recContact = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactPage(
          contact: contact,
        ),
      ),
    );
    print('recContact: $recContact');
    print('contact: $contact');
    if (recContact != null) {
      if (contact != null) {
        print('=== Editou ===');
        await helper.updateContact(recContact);
      } else {
        print('=== Salvou ===');
        await helper.saveContact(recContact);
      }
      _getAllContacts();
    }
  }

  void _getAllContacts() {
    helper.getAllContact().then((list) {
      setState(() {
        contactsList = list;
      });
    });
  }
}
