-- DROP DATABASE address_book;
-- CREATE DATABASE address_book;
DROP TABLE contacts;
CREATE TABLE contacts
(
  id serial primary key,
  first VARCHAR(25),
  last  VARCHAR(25),
  age INT,
  gender CHAR(1),
  dtgd  BOOLEAN,
  phone VARCHAR(12)
);