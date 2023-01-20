/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
 id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
name VARCHAR(100) NOT NULL,
date_of_birth DATE NOT NULL,
escape_attempts INT NOT NULL,
neutered BOOLEAN,
weight_kg DECIMAL(10,2)
);

ALTER TABLE animals 
ADD species VARCHAR(100);

/* table owners */
CREATE TABLE owners(
 id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
full_name VARCHAR(100),
age INT
);

/* table species */

CREATE TABLE species (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
name VARCHAR(100)
);