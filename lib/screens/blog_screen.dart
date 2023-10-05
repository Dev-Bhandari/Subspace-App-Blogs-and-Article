import 'package:flutter/material.dart';
import 'package:subspace/models/blog.dart';

class BlogScreen extends StatefulWidget {
  final Blog blog;
  const BlogScreen({super.key, required this.blog});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        title: const Text(
          "Detailed Blog Post",
          style: TextStyle(fontSize: 26),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Blog Id : ${widget.blog.id}",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(widget.blog.imageUrl)),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.blog.title,
                style: const TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
