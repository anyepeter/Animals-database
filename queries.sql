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

BEGIN;

UPDATE animals
SET species = 'unspecified';

ROLLBACK;


BEGIN;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';


UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;


BEGIN;

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

/* Queries */
SELECT COUNT(id) FROM animals;

SELECT COUNT(id) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT COUNT(escape_attempts) AS escape_attempts, neutered FROM animals GROUP BY neutered;

SELECT MAX(weight_kg), MIN(weight_kg), species FROM animals GROUP BY species;

SELECT AVG(escape_attempts) AS escape_attempts, species FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

-- Modify your inserted animals so it includes the species_id value:
UPDATE animals 
SET species_id = 2
WHERE name LIKE '%mon';

UPDATE animals 
SET species_id = 1
WHERE species_id IS NULL;

--queries using JOIN
-- What animals belong to Melody Pond?
SELECT name AS "animal name" FROM animals INNER JOIN owners 
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT * FROM animals
INNER JOIN species
ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT full_name AS "Owners name", name AS "Animals name" FROM owners lEFT JOIN animals
ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT COUNT(animals.name) AS "animals N0", species.name 
FROM animals INNER JOIN species
ON animals.species_id = species.id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name FROM animals INNER JOIN species
ON animals.species_id = species.id
INNER JOIN Owners
ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name FROM animals 
INNER JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' 
AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT owners.full_name , COUNT(*)
  FROM owners
  INNER JOIN animals
  ON owners.id = animals.owner_id
  GROUP BY owners.full_name
  ORDER BY count DESC LIMIT 1;