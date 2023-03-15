// ignore_for_file: file_names

import 'package:flutter/material.dart';

class RatingStars extends StatefulWidget {
  final double rating;
  final int nbrRating;
  final bool withNumber;
  const RatingStars(
      {super.key,
      required this.rating,
      required this.nbrRating,
      required this.withNumber});

  @override
  State<RatingStars> createState() => _RatingStarsState();
}

class _RatingStarsState extends State<RatingStars> {
  @override
  Widget build(BuildContext context) {
    return widget.rating <= 0.5
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: Colors.grey),
              const Icon(Icons.star, color: Colors.grey),
              const Icon(Icons.star, color: Colors.grey),
              const Icon(Icons.star, color: Colors.grey),
              const Icon(Icons.star, color: Colors.grey),
              widget.withNumber
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "(${widget.nbrRating})",
                        style: const TextStyle(fontSize: 10),
                      ),
                    )
                  : const SizedBox()
            ],
          )
        : widget.rating <= 0.6 && widget.rating <= 1.5
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star,
                      color: Color.fromARGB(255, 255, 215, 16)),
                  const Icon(Icons.star, color: Colors.grey),
                  const Icon(Icons.star, color: Colors.grey),
                  const Icon(Icons.star, color: Colors.grey),
                  const Icon(Icons.star, color: Colors.grey),
                  widget.withNumber
                      ? Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "(${widget.nbrRating})",
                            style: const TextStyle(fontSize: 10),
                          ),
                        )
                      : const SizedBox()
                ],
              )
            : widget.rating > 1.6 && widget.rating <= 2.5
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star,
                          color: Color.fromARGB(255, 255, 215, 16)),
                      const Icon(Icons.star,
                          color: Color.fromARGB(255, 255, 215, 16)),
                      const Icon(Icons.star, color: Colors.grey),
                      const Icon(Icons.star, color: Colors.grey),
                      const Icon(Icons.star, color: Colors.grey),
                      widget.withNumber
                          ? Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "(${widget.nbrRating})",
                                style: const TextStyle(fontSize: 10),
                              ),
                            )
                          : const SizedBox()
                    ],
                  )
                : widget.rating > 2.6 && widget.rating <= 3.5
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.star,
                              color: Color.fromARGB(255, 255, 215, 16)),
                          const Icon(Icons.star,
                              color: Color.fromARGB(255, 255, 215, 16)),
                          const Icon(Icons.star,
                              color: Color.fromARGB(255, 255, 215, 16)),
                          const Icon(Icons.star, color: Colors.grey),
                          const Icon(Icons.star, color: Colors.grey),
                          widget.withNumber
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "(${widget.nbrRating})",
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                )
                              : const SizedBox()
                        ],
                      )
                    : widget.rating > 3.6 && widget.rating <= 4.5
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.star,
                                  color: Color.fromARGB(255, 255, 215, 16)),
                              const Icon(Icons.star,
                                  color: Color.fromARGB(255, 255, 215, 16)),
                              const Icon(Icons.star,
                                  color: Color.fromARGB(255, 255, 215, 16)),
                              const Icon(Icons.star,
                                  color: Color.fromARGB(255, 255, 215, 16)),
                              const Icon(Icons.star, color: Colors.grey),
                              widget.withNumber
                                  ? Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "(${widget.nbrRating})",
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          )
                        : widget.rating > 4.6 && widget.rating <= 5
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.star,
                                      color: Color.fromARGB(255, 255, 215, 16)),
                                  const Icon(Icons.star,
                                      color: Color.fromARGB(255, 255, 215, 16)),
                                  const Icon(Icons.star,
                                      color: Color.fromARGB(255, 255, 215, 16)),
                                  const Icon(Icons.star,
                                      color: Color.fromARGB(255, 255, 215, 16)),
                                  const Icon(Icons.star,
                                      color: Color.fromARGB(255, 255, 215, 16)),
                                  widget.withNumber
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            "(${widget.nbrRating})",
                                            style:
                                                const TextStyle(fontSize: 10),
                                          ),
                                        )
                                      : const SizedBox()
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.star,
                                      color: Color.fromARGB(255, 255, 215, 16)),
                                  const Icon(Icons.star,
                                      color: Color.fromARGB(255, 255, 215, 16)),
                                  const Icon(Icons.star,
                                      color: Color.fromARGB(255, 255, 215, 16)),
                                  const Icon(Icons.star,
                                      color: Color.fromARGB(255, 255, 215, 16)),
                                  const Icon(Icons.star, color: Colors.grey),
                                  widget.withNumber
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            "(${widget.nbrRating})",
                                            style:
                                                const TextStyle(fontSize: 10),
                                          ),
                                        )
                                      : const SizedBox()
                                ],
                              );
  }
}
