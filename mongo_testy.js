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
  
  print("===== Testy MongoDB =====");
  
  // 1️⃣ Liczba filmów w bazie
  var q1 = () => db.movies.countDocuments();
  print("Zapytanie 1: " + measureTime(q1) + " ms");
  
  // 2️⃣ Liczba ocen użytkownika 123
  var q2 = () => db.ratings.countDocuments({userId: 123});
  print("Zapytanie 2: " + measureTime(q2) + " ms");
  
  // 3️⃣ Średnia ocena filmu 50
  var q3 = () => db.ratings.aggregate([
    {$match: {movieId: 50}},
    {$group: {_id: null, avgRating: {$avg: "$rating"}}}
  ]).toArray();
  print("Zapytanie 3: " + measureTime(q3) + " ms");
  
  // 4️⃣ Top 5 filmów z największą liczbą ocen
  var q4 = () => db.ratings.aggregate([
    {$group: {_id: "$movieId", numRatings: {$sum: 1}}},
    {$sort: {numRatings: -1}},
    {$limit: 5}
  ]).toArray();
  print("Zapytanie 4: " + measureTime(q4) + " ms");
  
  // 5️⃣ Liczba unikalnych użytkowników
  var q5 = () => db.ratings.distinct("userId").length;
  print("Zapytanie 5: " + measureTime(q5) + " ms");
  
  // 6️⃣ Filmy z tytułem zawierającym 'Star'
  var q6 = () => db.movies.find({title: /Star/}).toArray();
  print("Zapytanie 6: " + measureTime(q6) + " ms");
  
  // 7️⃣ Aktualizacja ocen użytkownika 456 dla filmów > 1000
  var q7 = () => db.ratings.updateMany(
    {userId: 456, movieId: {$gt: 1000}},
    {$set: {rating: 5}}
  );
  print("Zapytanie 7: " + measureTime(q7) + " ms");
  
  // 8️⃣ Usunięcie wszystkich ocen filmu 789
  var q8 = () => db.ratings.deleteMany({movieId: 789});
  print("Zapytanie 8: " + measureTime(q8) + " ms");
  
  // 9️⃣ Liczba filmów z roku 1999
  var q9 = () => db.movies.countDocuments({title: /\(1999\)/});
  print("Zapytanie 9: " + measureTime(q9) + " ms");
  
  // 🔟 Liczba tagów filmu 50
  var q10 = () => db.tags.countDocuments({movieId: 50});
  print("Zapytanie 10: " + measureTime(q10) + " ms");
  
  print("===== Koniec Testów =====");
  