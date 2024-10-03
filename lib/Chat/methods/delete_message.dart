  // Future<dynamic> deleteCategoryMethod(
  //     BuildContext context, List<QueryDocumentSnapshot<Object?>> data, int index) {
  //   return showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       backgroundColor: Colors.grey[100],
  //       surfaceTintColor: Colors.white,
  //       title: const Text('Delete file'),
  //       content: const Text("Are you sure you want to delete?"),
  //       actions: [
  //         TextButton(
  //           onPressed: () async {
  //             Navigator.pop(context);
  //           },
  //           child: Text(
  //             'Cancel',
  //             style: TextStyle(color: Colors.blue[600]),
  //           ),
  //         ),
  //         TextButton(
  //           onPressed: () async {
  //             await FirebaseFirestore.instance.collection("Categories").doc(data[index].id).delete();
  //             Navigator.pop(context);
  //             setState(() {});
  //           },
  //           child: Text(
  //             'Delete',
  //             style: TextStyle(color: Colors.red[600]),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  