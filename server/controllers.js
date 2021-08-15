const db = require("./db.js");

module.exports = {
  products: {
    getProducts: (req, res) => {
      const count = !req.query.count ? 5 : req.query.count;
      db.pool.query(`SELECT * FROM product limit(${count})`, (err, data) => {
        if (err) {
          res.status(404).send(err);
        } else {
          res.status(200).send(data.rows);
        }
      });
    },
    getProductInfo: (req, res) => {
      const id = req.params.id;
      db.pool.query(
        `SELECT product.*, array_agg(json_build_object('feature', features.feature, 'value', features.value)) AS features FROM product LEFT JOIN (SELECT product_id, feature, value FROM features) AS features ON product.id=features.product_id WHERE id=${id} GROUP BY product.id`,
        (err, data) => {
          if (err) {
            res.status(404).send(err);
          } else {
            res.status(200).send(data.rows);
          }
        }
      );
    },
    getProductStyles: (req, res) => {
      const product_id = req.params.id;
      db.pool.query(
        // `SELECT product.id AS product_id, array_agg(json_build_object('style_id', styles.style_id, 'name', styles.name, 'original_price', styles.original_price, 'sale_price', styles.sale_price, 'default?', styles.default_style, 'photos', styles.photos, 'skus', styles.skus)) AS results FROM product

        // LEFT JOIN (SELECT id AS style_id, product_id, name, original_price, sale_price, default_style, array_agg(json_build_object('thumbnail_url', photos.thumbnail_url, 'url', photos.url)) AS photos, json_object_agg(skus.sku, json_build_object('quantity', skus.quantity, 'size', skus.size)) AS skus FROM styles

        // LEFT JOIN (SELECT style_id, url, thumbnail_url FROM photos) AS photos ON styles.id=photos.style_id

        // LEFT JOIN (SELECT id AS sku, style_id, quantity, size FROM skus) AS skus ON styles.id=skus.style_id

        // GROUP BY styles.id) AS styles ON product.id=styles.product_id
        // WHERE id=${product_id}
        // GROUP BY product.id`,
        `SELECT id AS style_id, name, original_price, sale_price, default_style,
        (SELECT array_agg(json_build_object('thumbnail_url', photos.thumbnail_url, 'url', photos.url)) AS photos FROM photos WHERE photos.style_id=styles.id),
        (SELECT json_object_agg(skus.id, json_build_object('quantity', skus.quantity, 'size', skus.size)) AS skus FROM skus WHERE skus.style_id=styles.id)
        FROM styles
        WHERE styles.product_id=${product_id}`,
        (err, data) => {
          if (err) {
            res.status(404).send(err);
          } else {
            const result = { product_id };
            result.result = data.rows;
            res.status(200).send(result);
          }
        }
      );
    },
    getRelatedProducts: (req, res) => {
      const id = req.params.id;
      db.pool.query(
        `SELECT array_agg(related.related_product_id) AS result FROM product LEFT JOIN (SELECT current_product_id, related_product_id FROM related) AS related ON product.id=related.current_product_id WHERE id=${id} GROUP BY product.id`,
        (err, data) => {
          if (err) {
            res.status(404).send(err);
          } else {
            res.status(200).send(!data.rows[0] ? [] : data.rows[0].result);
          }
        }
      );
    },
  },
};
