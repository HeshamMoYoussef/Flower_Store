import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final dialogEditingController = TextEditingController();
final user = FirebaseAuth.instance.currentUser;
CollectionReference users = FirebaseFirestore.instance.collection('userS');

profileEditInfoDialog({context, data, myKey, setState}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: const EdgeInsets.all(15),
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: dialogEditingController,
                maxLength: 20,
                decoration: InputDecoration(
                  hintText: "${data[myKey] ?? ' Enter $myKey'}",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      editFunc(
                        myKey: myKey,
                        context: context,
                        setState: setState,
                      );
                    },
                    child: const Text("Edit", style: TextStyle(fontSize: 17)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel", style: TextStyle(fontSize: 17)),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

editFunc({myKey, context, setState}) {
  users.doc(user!.uid).update({myKey: dialogEditingController.text});
  setState(() {
    Navigator.pop(context);
  });
}

deleteField({setState, myKey}) {
  setState(() {
    users.doc(user!.uid).update({myKey: FieldValue.delete()});
  });
}

deleteUser(context) {
  users.doc(user!.uid).delete();
  user!.delete();

  Navigator.pop(context);
}
