----------------------------------
-- use sample_mflix;
-----------------------------------
db.movies.insertOne(
  {
    title: "The Favourite",
    genres: [ "Drama", "History" ],
    runtime: 121,
    rated: "R",
    year: 2018,
    directors: [ "Yorgos Lanthimos" ],
    cast: [ "Olivia Colman", "Emma Stone", "Rachel Weisz" ],
    type: "movie"
  }
);
---------------------------------------------
-- insert many document to the collection
---------------------------------------------
db.movies.insertMany([
   {
      title: "Jurassic World: Fallen Kingdom",
      genres: [ "Action", "Sci-Fi" ],
      runtime: 130,
      rated: "PG-13",
      year: 2018,
      directors: [ "J. A. Bayona" ],
      cast: [ "Chris Pratt", "Bryce Dallas Howard", "Rafe Spall" ],
      type: "movie"
    },
    {
      title: "Tag",
      genres: [ "Comedy", "Action" ],
      runtime: 105,
      rated: "R",
      year: 2018,
      directors: [ "Jeff Tomsic" ],
      cast: [ "Annabelle Wallis", "Jeremy Renner", "Jon Hamm" ],
      type: "movie"
    }
]);
-------------------------------------------
-- Read documents from the coll with .find
-------------------------------------------
db.movies.find({});

----------------------------------------
-- Filter the document
----------------------------------------
db.movies.find( { "title": "Titanic" } );

---------------------------------------------
-- Specificy conditions for query operations
---------------------------------------------

db.movies.find( { rated: { $in: [ "PG", "PG-13" ] } } );
---------------------------------------------
-- Specificy Logical Operators AND/OR
---------------------------------------------

--------------------------------------------------------------------------------
-- Use the $or operator to specify a compound query that joins each 
-- clause with a logical OR conjunction so that the query selects the
-- documents in the collection that match at least one condition.
-- Example
-- To return movies from the sample_mflix.movies collection which were
-- released in 2010 and either won at least 5 awards or have a genre of Drama:
-------------------------------------------------------------------------------
db.movies.find( { countries: "Mexico", "imdb.rating": { $gte: 7 } } );

db.movies.find( {
     year: 2010,
     $or: [ { "awards.wins": { $gte: 5 } }, { genres: "Drama" } ]
} );

---------------------------------------------
-- Update a single document
---------------------------------------------

db.movies.updateOne( { title: "Twilight" },
{
  $set: {
    plot: "A teenage girl risks everything–including her life–when she falls in love with a vampire."
  },
  $currentDate: { lastUpdated: true }
});
---------------------------------------------
-- Update a multiple documents
---------------------------------------------

db.listingsAndReviews.updateMany(
  { security_deposit: { $lt: 100 } },
  {
    $set: { security_deposit: 100, minimum_nights: 1 }
  }
);

---------------------------------------------
-- Update a multiple documents
--------------------------------------------

-- To replace the entire content of a document 
-- except for the _id field, pass an entirely 
-- new document as the second argument to 
-- db.collection.replaceOne(). When replacing a document,
-- the replacement document must contain only field/value pairs. 
-- Do not include update operators expressions.
---------------------------------------------
db.accounts.replaceOne(
  { account_id: 371138 },
  { account_id: 893421, limit: 5000, products: [ "Investment", "Brokerage" ] }
);

---------------------------------------------
-- Delete all documents
--------------------------------------------
db.movies.deleteMany({});
db.movies.drop(); -- If you want to delete all documents from a large collection,may have faster performance than deleting documents with the db.collection.deleteMany() method.

---------------------------------------------
-- Delete all documents that Match a Condition
----------------------------------------------
db.movies.deleteMany( { title: "Titanic" } );
db.movies.deleteOne( { cast: "Brad Pitt" } ); -- Delete Only One Document that Matches a Condition