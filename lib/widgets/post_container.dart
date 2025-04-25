import 'package:flutter/material.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/services/auth_service.dart';
import 'package:social_media_app/services/firestore_service.dart';

class PostContainer extends StatelessWidget {
  final PostModel post;
  final String docID;

  const PostContainer({super.key, required this.post, required this.docID});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person, color: Colors.white),
                  SizedBox(width: 6.0),
                  Text(post.username, style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(post.content, style: TextStyle(color: Colors.white)),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (post.whoLiked.contains(
                      authService.value.currentUser!.email,
                    )) {
                      firestoreService.value.removeLike(docID);
                    } else {
                      firestoreService.value.addLike(docID);
                    }
                  },
                  icon: Icon(
                    post.whoLiked.contains(authService.value.currentUser!.email)
                        ? Icons.favorite
                        : Icons.favorite_border,

                    color: Colors.white,
                  ),
                ),
                Text(
                  post.likes.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          post.email == authService.value.currentUser!.email
              ? Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  onPressed: () async {
                    await firestoreService.value.removePost(docID);
                  },
                  icon: Icon(Icons.delete, color: Colors.white),
                ),
              )
              : SizedBox(),
        ],
      ),
    );
  }
}
