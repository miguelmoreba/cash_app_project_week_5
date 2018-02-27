DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS tags;

CREATE TABLE tags
(
  id SERIAL8 primary key,
  name VARCHAR(255)
);

CREATE TABLE transactions
(
  id SERIAL8 primary key,
  name VARCHAR(255),
  amount DECIMAL,
  tag_id INT8 REFERENCES tags(id)
);
