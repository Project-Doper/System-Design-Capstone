const db = require("./db.js");

module.exports = {
  products: {
    getProducts: (req, res) => {
      db.pool.query("SELECT * FROM product limit(4)", (err, data) => {
        res.status(200).send(data.rows);
        db.pool.end();
      });
    },
    getProductInfo: (req, res) => {},
    getProductStyles: (req, res) => {},
    getRelatedProducts: (req, res) => {},
  },
};
