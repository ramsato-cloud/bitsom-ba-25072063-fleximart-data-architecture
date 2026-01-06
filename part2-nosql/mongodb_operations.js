// ------------------------------------------------------------
// MongoDB Operations for FlexiMart
// Student: Ramanathan Sathappan
// Part 2 – Task 2.2 (10 marks)
// ------------------------------------------------------------

// ------------------------------------------------------------
// OPERATION 1: Load Data (1 mark)
// Import the provided JSON file into the 'products' collection
// Command to run in terminal (NOT inside this JS file):
//
// mongoimport --db fleximart --collection products --file products_catalog.json --jsonArray
// ------------------------------------------------------------


// ------------------------------------------------------------
// OPERATION 2: Basic Query (2 marks)
// Find all products in "Electronics" category with price < 50000
// Return only: name, price, stock
// ------------------------------------------------------------
db.products.find(
  { category: "Electronics", price: { $lt: 50000 } },
  { _id: 0, name: 1, price: 1, stock: 1 }
);


// ------------------------------------------------------------
// OPERATION 3: Review Analysis (2 marks)
// Find all products with average rating >= 4.0
// Use aggregation to compute average from reviews array
// ------------------------------------------------------------
db.products.aggregate([
  {
    $project: {
      name: 1,
      category: 1,
      avg_rating: { $avg: "$reviews.rating" }
    }
  },
  {
    $match: { avg_rating: { $gte: 4.0 } }
  }
]);


// ------------------------------------------------------------
// OPERATION 4: Update Operation (2 marks)
// Add a new review to product "ELEC001"
// Review: {user: "U999", rating: 4, comment: "Good value", date: ISODate()}
// ------------------------------------------------------------
db.products.updateOne(
  { product_id: "ELEC001" },
  {
    $push: {
      reviews: {
        user: "U999",
        rating: 4,
        comment: "Good value",
        date: new Date()
      }
    }
  }
);


// ------------------------------------------------------------
// OPERATION 5: Complex Aggregation (3 marks)
// Calculate average price by category
// Return: category, avg_price, product_count
// Sort by avg_price descending
// ------------------------------------------------------------
db.products.aggregate([
  {
    $group: {
      _id: "$category",
      avg_price: { $avg: "$price" },
      product_count: { $sum: 1 }
    }
  },
  {
    $project: {
      _id: 0,
      category: "$_id",
      avg_price: 1,
      product_count: 1
    }
  },
  {
    $sort: { avg_price: -1 }
  }
]);
