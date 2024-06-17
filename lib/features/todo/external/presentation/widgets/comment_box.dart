import 'package:flutter/material.dart';
import 'package:trackt/features/todo/external/models/comment/comment.dart';

class CommentBox extends StatelessWidget {
  const CommentBox({super.key, required this.comment, required this.onDeleted});

  final Comment comment;
  final VoidCallback onDeleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(comment.content),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onDeleted,
          ),
        ],
      ),
    );
  }
}
