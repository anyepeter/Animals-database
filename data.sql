/* Populate database with sample data. */

INSERT INTO animals (
name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Agumon','Feb 3, 2020',0, true, 10.23);

INSERT INTO animals (
name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Gabumon','Nov 15, 2018',2, true, 08.00);

INSERT INTO animals (
name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Pikachu','Jan 7, 2021',1, false, 15.00);

INSERT INTO animals (
name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Devimon','May 12, 2017',5, true, 11.00);

INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Charmander', 'Feb 8, 2020', 0, false, -11.00); 

INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Plantmon', 'Nov 15, 2021', 2, true, -05.70),
('Squirtle', 'Apr 2, 1993', 3, false, -12.13),
('Angemon', 'Jun 12, 2005', 1, true, -45.00),
('Boarmon', 'Jun 7, 2005', 7, true, 20.40),
('Blossom', 'Oct 13, 1998', 3, true, 17.00),
('Ditto', 'May 14, 2022', 4, true, 22.00); 

/* insert data into the owners table*/

INSERT INTO owners(full_name, age)
VALUES('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

/* insert data into the species table*/
INSERT INTO species (name)
VALUES ('Pokemon'),
('Digimon');


-- Modify your inserted animals so it includes the species_id value:
UPDATE animals 
SET species_id = 2
WHERE name LIKE '%mon';

UPDATE animals 
SET species_id = 1
WHERE species_id IS NULL;

-- Modify your inserted animals to include owner information (owner_id):

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name = 'Gabumon' OR name = 'Pikachu';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name = 'Devimon' OR name = 'Plantmon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon', 'Boarmon');
