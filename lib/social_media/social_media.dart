import 'package:flutter/material.dart';

import 'create_post_sheet.dart';
import 'post.dart';
import 'post_card.dart';

class SocialMediaPage extends StatefulWidget {
  final String username;

  const SocialMediaPage({super.key, required this.username});

  static final List<Post> feedPosts = [
    const Post(
      username: 'JohnDoe',
      caption: 'Enjoying the sunny weather!',
      imageUrl: 'https://picsum.photos/id/20/600/400',
    ),
    const Post(
      username: 'JaneSmith',
      caption: 'Just finished a great book!',
      imageUrl: 'https://picsum.photos/id/24/600/400',
    ),
  ];

  @override
  State<SocialMediaPage> createState() => _SocialMediaPageState();
}

class _SocialMediaPageState extends State<SocialMediaPage> {
  Future<void> openCreatePostSheet() async {
    final Post? newPost = await showModalBottomSheet<Post>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return CreatePostSheet(username: widget.username);
      },
    );

    if (!mounted || newPost == null) {
      return;
    }

    setState(() {
      SocialMediaPage.feedPosts.insert(0, newPost);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Social Media')),
      body: SocialMediaPage.feedPosts.isEmpty
          ? const Center(child: Text('No posts yet. Create one!'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: SocialMediaPage.feedPosts.length,
              itemBuilder: (context, index) {
                final post = SocialMediaPage.feedPosts[index];

                return PostCard(key: ObjectKey(post), post: post);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: openCreatePostSheet,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        tooltip: 'Create Post',
        child: const Icon(Icons.add),
      ),
    );
  }
}
