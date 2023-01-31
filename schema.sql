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

/*modify the animals table */
ALTER TABLE animals
DROP species;

ALTER TABLE animals
ADD species_id INT REFERENCES species;

ALTER TABLE animals 
ADD owner_id INT REFERENCES owners(id);


-- table vets

CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    date_of_graduation DATE
);

-- specialization table to join the species and vets

CREATE TABLE specialization (
    vet_id INT,
    species_id INT,
    PRIMARY KEY (vet_id, species_id),
    FOREIGN KEY (vet_id) REFERENCES vets(id),
    FOREIGN KEY (species_id) REFERENCES species(id)
);

--visit table
CREATE TABLE visits(
  id INT GENERATED ALWAYS AS IDENTITY,
  animal_id INT REFERENCES animals(id),
  vet_id INT REFERENCES vets(id),
  date_of_visit DATE,
  PRIMARY KEY(id)
);

-- Add an email column to your owners table
ALTER TABLE owners
 ADD email VARCHAR(120);

 