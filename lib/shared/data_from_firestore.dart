import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower_app/shared/profile_dialog_with_functions.dart';
import 'package:flutter/material.dart';

class GetDataFromFirestore extends StatefulWidget {
  final String documentId;

  const GetDataFromFirestore({Key? key, required this.documentId})
      : super(key: key);

  @override
  State<GetDataFromFirestore> createState() => _GetDataFromFirestoreState();
}

class _GetDataFromFirestoreState extends State<GetDataFromFirestore> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('userS');

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: FutureBuilder<DocumentSnapshot>(
          future: users.doc(widget.documentId).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return const Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 9),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Username: ${data['username'] ?? 'Enter User Name'}",
                        style: const TextStyle(fontSize: 17),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              deleteField(
                                myKey: 'username',
                                setState: setState,
                              );
                            },
                            icon: const Icon(Icons.delete),
                          ),
                          IconButton(
                            onPressed: () {
                              profileEditInfoDialog(
                                context: context,
                                data: data,
                                myKey: 'username',
                                setState: setState,
                              );
                            },
                            icon: const Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Email: ${data['email'] ?? 'Enter Email'}",
                        style: const TextStyle(fontSize: 17),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              deleteField(
                                myKey: 'email',
                                setState: setState,
                              );
                            },
                            icon: const Icon(Icons.delete),
                          ),
                          IconButton(
                            onPressed: () {
                              profileEditInfoDialog(
                                context: context,
                                data: data,
                                myKey: 'email',
                                setState: setState,
                              );
                            },
                            icon: const Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Age: ${data['age'] ?? 'Enter Age'} years old",
                        style: const TextStyle(fontSize: 17),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              deleteField(myKey: 'age', setState: setState);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                          IconButton(
                            onPressed: () {
                              profileEditInfoDialog(
                                context: context,
                                data: data,
                                myKey: 'age',
                                setState: setState,
                              );
                            },
                            icon: const Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Title: ${data['title'] ?? 'Enter Title'} ",
                        style: const TextStyle(fontSize: 17),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              deleteField(
                                myKey: 'title',
                                setState: setState,
                              );
                            },
                            icon: const Icon(Icons.delete),
                          ),
                          IconButton(
                            onPressed: () {
                              profileEditInfoDialog(
                                context: context,
                                data: data,
                                myKey: 'title',
                                setState: setState,
                              );
                            },
                            icon: const Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          users.doc(user!.uid).delete();
                        });
                      },
                      child: const Text(
                        "Delete Data",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              );
            }

            return const Text("loading");
          },
        ),
      ),
    );
  }
}
