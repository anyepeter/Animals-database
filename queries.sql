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

  --  Write queries to answer the following:
  -- Who was the last animal seen by William Tatcher?
SELECT vets.name AS "Vet Name", animals.name AS "Animal Name", visits.date_of_visit
  FROM vets
  INNER JOIN visits
    ON vets.id = visits.vet_id
  INNER JOIN animals
    ON visits.animal_id = animals.id
  WHERE vets.name = 'William Tatcher'
  ORDER by date_of_visit DESC LIMIT 1;

  -- [X] How many different animals did Stephanie Mendez see?
SELECT vets.name AS "Vet Name", COUNT(DISTINCT animals.name)
   FROM vets
   INNER JOIN visits
     ON vets.id = visits.vet_id
   INNER JOIN animals
     ON visits.animal_id = animals.id
   WHERE vets.name = 'Stephanie Mendez'
   GROUP BY vets.name;

   
-- [X] List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name AS "Species"
  FROM vets
  FULL OUTER JOIN specialization
    ON vets.id = specialization.vet_id
  FULL OUTER JOIN species
    ON species.id = specialization.species_id;

-- [X] List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name AS "Animal", visits.date_of_visit
  FROM animals
  JOIN visits
    ON animals.id = visits.animal_id
  WHERE visits.vet_id = (SELECT id FROM vets WHERE vets.name = 'Stephanie Mendez')
  AND
  visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- [X] What animal has the most visits to vets?
SELECT animals.name, COUNT(*)
  FROM animals
  JOIN visits
    ON animals.id = visits.animal_id
  GROUP BY animals.name
  ORDER BY count DESC LIMIT 1;

-- [X] Who was Maisy Smith's first visit?
SELECT vets.name AS "Vet", animals.name AS "Animal", visits.date_of_visit
  FROM vets
  JOIN visits
    ON vets.id = visits.vet_id
  JOIN animals
    ON visits.animal_id = animals.id
  WHERE vets.name = 'Maisy Smith'
  ORDER BY date_of_visit LIMIT 1;

-- [X] Details for most recent visit: animal information, vet information, and date of visit.
SELECT vets.id AS "Vet id", vets.name AS "Vet", date_of_graduation, visits.date_of_visit,
animals.id AS "Animal id", animals.name AS "Animal", date_of_birth, escape_attempts, neutered, weight_kg, species_id, owner_id
  FROM vets
  JOIN visits
    ON vets.id = visits.vet_id
  JOIN animals
    ON visits.animal_id = animals.id
  ORDER BY date_of_visit DESC LIMIT 1;

-- [X] How many visits were with a vet that did not specialize in that animal's species?
SELECT vets.name
  FROM vets
  JOIN visits
    ON vets.id = visits.vet_id
  LEFT JOIN specialization
    ON vets.id = specialization.vet_id
  WHERE specialization.vet_id IS NULL
  GROUP BY vets.name;

-- [X] What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name AS "species", COUNT(animals.species_id)
  FROM vets
  JOIN visits
    ON vets.id = visits.vet_id
  JOIN animals
    ON animals.id = visits.animal_id
  JOIN species
    ON species.id = animals.species_id
  WHERE vets.name = 'Maisy Smith'
  GROUP BY species.name
  ORDER BY count DESC LIMIT 1;