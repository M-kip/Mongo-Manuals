# Mongo-Manuals
## Logging into mangodb atlas with mongosh using the connection string 

1. Connection string
- mongodb+srv://<user_name>:<db_password>@basecluster.xygr2us.mongodb.net/?retryWrites=true&w=majority&appName=BaseCluster

2. Connect to the db
- mongosh mongodb+srv://<user_name>:<db_password>@basecluster.xygr2us.mongodb.net/?retryWrites=true&w=majority&appName=BaseCluster

## Query Documents
- Use the db.collection.find() method in the MongoDB Shell to query documents in a collection.

The examples on this page reference the Atlas sample dataset. You can create a free Atlas cluster and populate that cluster with sample data to follow along with these examples. To learn more, see Get Started with Atlas

## Read All Documents in a Collection
To read all documents in the collection, pass an empty document as the query filter parameter to the find method. The query filter parameter determines the select criteria.

### Example
To return all documents from the sample_mflix.movies collection:

``use sample_mflix``
``db.movies.find()``

This operation is equivalent to the following SQL statement:

``SELECT * FROM movies``

## Specify Equality Condition
To select documents which match an equality condition, specify the condition as a <field>:<value> pair in the query filter document.

### Example
To return all movies where the title equals Titanic from the sample_mflix.movies collection:

``use sample_mflix``
``db.movies.find( { "title": "Titanic" } )``

This operation corresponds to the following SQL statement:

``SELECT * FROM movies WHERE title = "Titanic"``

## Specify Conditions Using Query Operators
Use query operators in a query filter document to perform more complex comparisons and evaluations. Query operators in a query filter document have the following form:

``{ <field1>: { <operator1>: <value1> }, ... }``

# Example
To return all movies from the sample_mflix.movies collection which are either rated PG or PG-13:

``use sample_mflix``
``db.movies.find( { rated: { $in: [ "PG", "PG-13" ] } } )``

This operation corresponds to the following SQL statement:

``SELECT * FROM movies WHERE rated in ("PG", "PG-13")``
Note
Although you can express this query using the $or operator, use the $in operator rather than the $or operator when performing equality checks on the same field.

## Specify Logical Operators (AND / OR)
A compound query can specify conditions for more than one field in the collection's documents. Implicitly, a logical AND conjunction connects the clauses of a compound query so that the query selects the documents in the collection that match all the conditions.

## Example
To return movies which were released in Mexico and have an IMDB rating of at least 7:

``use sample_mflix``
``db.movies.find( { countries: "Mexico", "imdb.rating": { $gte: 7 } } )``

Use the $or operator to specify a compound query that joins each clause with a logical OR conjunction so that the query selects the documents in the collection that match at least one condition.

## Example
To return movies from the sample_mflix.movies collection which were released in 2010 and either won at least 5 awards or have a genre of Drama:

``use sample_mflix``
``db.movies.find( {``
     ``year: 2010,``
     ``$or: [ { "awards.wins": { $gte: 5 } }, { genres: "Drama" } ]``
``} )``

# Update Documents
The MongoDB shell provides the following methods to update documents in a collection:

- To update a single document, use ``db.collection.updateOne()``.

- To update multiple documents, use ``db.collection.updateMany()``.

- To replace a document, use ``db.collection.replaceOne()``.

The examples on this page reference the Atlas sample dataset. You can create a free Atlas cluster and populate that cluster with sample data to follow along with these examples. To learn more, see Get Started with Atlas.

## Update Operator Syntax
To update a document, MongoDB provides update operators, such as $set, to modify field values.

To use the update operators, pass to the update methods an update document of the form:

{
  <update operator>: { <field1>: <value1>, ... },
  <update operator>: { <field2>: <value2>, ... },
  ...
}

Some update operators, such as $set, create the field if the field does not exist. See the individual update operator reference for details.

## Update a Single Document
Use the db.collection.updateOne() method to update the first document that matches a specified filter.

**Note**
MongoDB preserves a natural sort order for documents. This ordering is an internal implementation feature, and you should not rely on any particular structure within it. To learn more, see natural order.

## Example
To update the first document in the sample_mflix.movies collection where title equals "Twilight":

``use sample_mflix``
``db.movies.updateOne( { title: "Twilight" },``
``{``
  ``$set: {``
    ``plot: "A teenage girl risks everything–including her life–when she falls in love with a vampire."``
  ``},``
  ``$currentDate: { lastUpdated: true }``
``})``

##The update operation:

Uses the $set operator to update the value of the plot field for the movie Twilight.

Uses the $currentDate operator to update the value of the lastUpdated field to the current date. If lastUpdated field does not exist, $currentDate will create the field. See $currentDate for details.

Update Multiple Documents
Use the db.collection.updateMany() to update all documents that match a specified filter.

## Example
To update all documents in the sample_airbnb.listingsAndReviews collection to update where security_deposit is less than 100:

``use sample_airbnb``
``db.listingsAndReviews.updateMany(``
  ``{ security_deposit: { $lt: 100 } },``
  ``{``
    ``$set: { security_deposit: 100, minimum_nights: 1 }``
  ``}``
``)``

The update operation uses the $set operator to update the value of the security_deposit field to 100 and the value of the minimum_nights field to 1.

## Replace a Document
To replace the entire content of a document except for the _id field, pass an entirely new document as the second argument to db.collection.replaceOne().

When replacing a document, the replacement document must contain only field/value pairs. Do not include update operators expressions.

The replacement document can have different fields from the original document. In the replacement document, you can omit the _id field since the _id field is immutable; however, if you do include the _id field, it must have the same value as the current value.

## Example
To replace the first document from the sample_analytics.accounts collection where account_id: 371138:

``db.accounts.replaceOne(``
  ``{`` account_id: 371138 },``
  ``{ account_id: 893421, limit: 5000, products: [ "Investment", "Brokerage" ] }``
``)``

## Run the following command to read your updated document:

``db.accounts.findOne( { account_id: 893421 } )``

## Delete Documents
1. The MongoDB shell provides the following methods to delete documents from a collection:
- To delete multiple documents, use ``db.collection.deleteMany()``.
- To delete a single document, use ``db.collection.deleteOne()``.

The examples on this page reference the Atlas sample dataset. You can create a free Atlas cluster and populate that cluster with sample data to follow along with these examples. To learn more, see Get Started with Atlas.
``use sample_mflix``

``db.movies.deleteMany({})``

The method returns a document with the status of the operation. For more information and examples, see deleteMany().

 **Note**
If you want to delete all documents from a large collection, dropping with the db.collection.drop() method. and recreating the collection may have faster performance than deleting documents with the db.collection.deleteMany() method. When you recreate the collection, you must also recreate any specified collection parameters such as collection indexes.

## Delete All Documents that Match a Condition
You can specify criteria, or filters, that identify the documents to delete. The filters use the same syntax as read operations.

To specify equality conditions, use <field>:<value> expressions in the query filter document.

To delete all documents that match a deletion criteria, pass a filter parameter to the deleteMany() method.

# Example
To delete all documents from the sample_mflix.movies collection where the title equals "Titanic":

``use sample_mflix``
``db.movies.deleteMany( { title: "Titanic" } )``

The method returns a document with the status of the operation. For more information and examples, see deleteMany().

## Delete Only One Document that Matches a Condition
To delete at most a single document that matches a specified filter (even though multiple documents may match the specified filter) use the db.collection.deleteOne() method.

## Example
To delete the first document from the sample_mflix.movies collection where the cast array contains "Brad Pitt":

``use sample_mflix``
``db.movies.deleteOne( { cast: "Brad Pitt" } )``

**Note**
MongoDB preserves a natural sort order for documents. This ordering is an internal implementation feature, and you should not rely on any particular structure within it. To learn more, see natural order.