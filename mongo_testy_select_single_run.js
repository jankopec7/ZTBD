function measureOnce(fn) {
    var start = new Date();
    fn();
    var end = new Date();
    return end - start;
}

print("===== Testy MongoDB – SELECT (pojedyncze wykonanie) =====");

// Średnia ocena dla każdego gatunku
var q1 = () => db.ratings.aggregate([
  {
    $lookup: {
      from: "movies",
      localField: "movieId",
      foreignField: "movieId",
      as: "movie"
    }
  },
  { $unwind: "$movie" },
  {
    $addFields: {
      genres: { $split: ["$movie.genres", "|"] }
    }
  },
  { $unwind: "$genres" },
  {
    $group: {
      _id: "$genres",
      avg_rating: { $avg: "$rating" }
    }
  }
]).toArray();

print("Zapytanie 1: " + measureOnce(q1) + " ms");

// Liczba ocen dla każdego tytułu
var q2 = () => db.ratings.aggregate([
    {
        $lookup: {
            from: "movies",
            localField: "movieId",
            foreignField: "movieId",
            as: "movie"
        }
    },
    { $unwind: "$movie" },
    {
        $group: {
            _id: "$movie.title",
            rating_count: { $sum: 1 }
        }
    }
]).toArray();
print("Zapytanie 2: " + measureOnce(q2) + " ms");

// Średnia ocena dla każdego imdbId
var q3 = () => db.ratings.aggregate([
    {
        $lookup: {
            from: "links",
            localField: "movieId",
            foreignField: "movieId",
            as: "link"
        }
    },
    { $unwind: "$link" },
    {
        $group: {
            _id: "$link.imdbId",
            avg_rating: { $avg: "$rating" }
        }
    }
]).toArray();
print("Zapytanie 3: " + measureOnce(q3) + " ms");

// Filmy ocenione przez usera 6550 z tagiem
var q4 = () => db.ratings.aggregate([
    { $match: { userId: 6550, rating: { $gte: 4.5 } } },
    {
        $lookup: {
            from: "tags",
            let: { movieId: "$movieId", userId: "$userId" },
            pipeline: [
                {
                    $match: {
                        $expr: {
                            $and: [
                                { $eq: ["$movieId", "$$movieId"] },
                                { $eq: ["$userId", "$$userId"] }
                            ]
                        }
                    }
                }
            ],
            as: "tags"
        }
    },
    { $unwind: "$tags" },
    {
        $lookup: {
            from: "movies",
            localField: "movieId",
            foreignField: "movieId",
            as: "movie"
        }
    },
    { $unwind: "$movie" },
    {
        $project: {
            title: "$movie.title",
            rating: 1,
            tag: "$tags.tag"
        }
    }
]).toArray();
print("Zapytanie 4: " + measureOnce(q4) + " ms");

print("===== Koniec testów SELECT (1x) =====");
