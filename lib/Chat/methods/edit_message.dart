// Future<dynamic> editCategoryMethod(BuildContext context, List<QueryDocumentSnapshot<Object?>> data,
  //     int index, GlobalKey<FormState> formState) {
  //   return showDialog(
  //     context: context,
  //     builder: (context) => Form(
  //       key: formState,
  //       child: AlertDialog(
  //         backgroundColor: Colors.grey[100],
  //         surfaceTintColor: Colors.white,
  //         title: const Text('Edit title'),
  //         content: CustomTextField(myController: editCategoryTitle, hint: "Enter the new title"),
  //         actions: [
  //           TextButton(
  //             onPressed: () async {
  //               Navigator.pop(context);
  //             },
  //             child: Text(
  //               'Cancel',
  //               style: TextStyle(color: Colors.blue[600]),
  //             ),
  //           ),
  //           TextButton(
  //             onPressed: () async {
  //               if (formState.currentState!.validate()) {
  //                 CollectionReference category = FirebaseFirestore.instance.collection('Categories');

  //                 await category
  //                     .doc(data[index].id)
  //                     .update({"name": editCategoryTitle.text})
  //                     .then((value) => showCustomSnackBar(context, "Name edited"))
  //                     .catchError((error) => showCustomSnackBar(context, "Failed to edit name: $error"));

  //                 setState(() {});
  //                 Navigator.pop(context);
  //               }
  //             },
  //             child: Text(
  //               'Save',
  //               style: TextStyle(color: Colors.blue[600]),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
