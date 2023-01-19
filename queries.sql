/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-12-12' and '2019-12-12';

SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.50;

SELECT * FROM animals WHERE neutered = true;

SELECT * FROM animals WHERE name != 'Gabumon';

SELECT * FROM animals WHERE weight_kg >= 10.40 and weight_kg <= 17.30;

/*transactions*/
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';


UPDATE animals
SET species = 'pokemon'
WHERE name NOT LIKE '%mon';

DELETE FROM animals;

DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

SAVEPOINT first_transaction;

UPDATE animals
SET weight_kg = weight_kg * -1;

ROLLBACK TO first_transaction;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 00.00;

COMMIT;