class ReviewModel {
  ReviewModel({
      this.id, 
      this.reviewerName, 
      this.review, 
      this.score, 
      this.movieId,});

  ReviewModel.fromJson(dynamic json) {
    id = json['Id'];
    reviewerName = json['ReviewerName'];
    review = json['Review'];
    score = json['Score'];
    movieId = json['movieId'];
  }
  int? id;
  String? reviewerName;
  String? review;
  int? score;
  int? movieId;
ReviewModel copyWith({  int? id,
  String? reviewerName,
  String? review,
  int? score,
  int? movieId,
}) => ReviewModel(  id: id ?? this.id,
  reviewerName: reviewerName ?? this.reviewerName,
  review: review ?? this.review,
  score: score ?? this.score,
  movieId: movieId ?? this.movieId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = id;
    map['ReviewerName'] = reviewerName;
    map['Review'] = review;
    map['Score'] = score;
    map['movieId'] = movieId;
    return map;
  }

}