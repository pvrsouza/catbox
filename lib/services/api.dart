import 'dart:async';

import 'package:catbox/models/cat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CatApi {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = new GoogleSignIn();

  FirebaseUser firebaseUser;

  CatApi(FirebaseUser user) {
    this.firebaseUser = user;
  }

  static Future<CatApi> signInWithGoogle() async {
    final GoogleSignInAccount googleuser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleuser.authentication;
    final FirebaseUser user = await _auth.signInWithGoogle(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentuser = await _auth.currentUser();
    assert(user.uid == currentuser.uid);

    return new CatApi(user);
  }

  static Future<CatApi> signInOut() async {
    final GoogleSignInAccount googleuser = await _googleSignIn.signOut();
    final isSignedIn = await _googleSignIn.isSignedIn();

    assert(!isSignedIn);

    return new CatApi(null);
  }

  /*static List<Cat> allCatsFromJson(String jsonData) {
    List<Cat> cats = [];
    json.decode(jsonData)['cats'].forEach((cat) => cats.add(_forMap(cat)));
    return cats;
  }*/

  Future<List<Cat>> getAllCats() async {
    return (await Firestore.instance.collection('cats').getDocuments())
        .documents
        .map((snapshot) => _fromDocumentSnapshot(snapshot))
        .toList();
  }

  StreamSubscription watch(Cat cat, void onChange(Cat cat)) {
    return Firestore.instance
        .collection('cats')
        .document(cat.documentId)
        .snapshots()
        .listen((snapshot) => onChange(_fromDocumentSnapshot(snapshot)));
  }

  Future likeCat(Cat cat) async {
    await Firestore.instance
        .collection('likes')
        .document(
            '${cat.documentId}:${this.firebaseUser.uid}') //Junta o id do gato + id do usuario
        .setData({});
  }

  Future unLikeCat(Cat cat) async {
    await Firestore.instance
        .collection('likes')
        .document('${cat.documentId}:${this.firebaseUser.uid}')
        .delete();
  }

  Future<bool> hasLikedCat(Cat cat) async {
    final like = await Firestore.instance
        .collection('likes')
        .document('${cat.documentId}:${this.firebaseUser.uid}')
        .get();

        return like.exists;
  }

  Cat _fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new Cat(
        documentId: snapshot.documentID,
        externalId: data['id'],
        name: data['name'],
        isAdopted: data['adopted'],
        pictures: new List<String>.from(data['pictures']),
        likeCounter: data['like_counter'],
        location: data['location'],
        cattributes: new List<String>.from(data['cattributes']),
        description: data['description'],
        avatarUrl: data['image_url']);
  }

  /*static Cat _forMap(Map<String, dynamic> map) {
    return new Cat(
        externalId: map['id'],
        name: map['name'],
        isAdopted: map['adopted'],
        pictures: new List<String>.from(map['pictures']),
        likeCounter: map['like_counter'],
        location: map['location'],
        cattributes: new List<String>.from(map['cattributes']),
        description: map['description'],
        avatarUrl: map['image_url']);
  }*/
}
