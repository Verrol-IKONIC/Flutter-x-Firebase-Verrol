part of 'services.dart';

class ProductServices {
  static CollectionReference productCollection =
      FirebaseFirestore.instance.collection("products");
  static DocumentReference productDoc;

  static Reference ref;
  static UploadTask uploadTask;
  static FirebaseStorage storage =
      FirebaseStorage(storageBucket: 'gs://latihan-8b69a.appspot.com/');

  static String imgUrl;

  static Future<bool> addProduct(Products product, PickedFile imgFile) async {
    await Firebase.initializeApp();

    productDoc = await productCollection.add(
        {'id': "", 'name': product.name, 'price': product.price, 'image': ""});

    if (productDoc.id != null) {
      ref = FirebaseStorage.instance
          .ref()
          .child("images")
          .child(productDoc.id + ".png");
      uploadTask = ref.putFile(File(imgFile.path));

      await uploadTask.whenComplete(
          () => ref.getDownloadURL().then((value) => imgUrl = value));

      productCollection.doc(productDoc.id).update({
        'id': productDoc.id,
        'image': imgUrl,
      });

      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateProduct(Products product) async {
    await productCollection.doc(product.id).update(
      {'name': product.name, 'price': product.price},
    );
    return true;
  }

  static Future<void> deleteProduct(Products product) async {
    await productCollection.doc(product.id).delete();
    storage.ref().child('images/' + product.id + '.png').delete();
  }
}
