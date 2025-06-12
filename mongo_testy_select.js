function measureTime(fn) {
    var times = [];
    for (let i = 0; i < 10; i++) {
        var start = new Date();
        fn();
        var end = new Date();
        times.push(end - start);
    }
    var avg = times.reduce((a, b) => a + b, 0) / times.length;
    return avg;
}

print("===== Testy MongoDB – SELECT =====");

// Średnia ocena dla każdego gatunku
var q1 = () => db.movies.aggregate([
    {
        $lookup: {
            from: "ratings",
            localField: "movieId",
            foreignField: "movieId",
            as: "ratings"
        }
    },
    { $unwind: "$ratings" },
    { $unwind: { path: "$genres", preserveNullAndEmptyArrays: true } },
    {
        $group: {
            _id: "$genres",
            avg_rating: { $avg: "$ratings.rating" }
        }
    }
]).toArray();
print("Zapytanie 1: " + measureTime(q1) + " ms");

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
print("Zapytanie 2: " + measureTime(q2) + " ms");

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
print("Zapytanie 3: " + measureTime(q3) + " ms");

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
print("Zapytanie 4: " + measureTime(q4) + " ms");

print("===== Koniec testów SELECT =====");
