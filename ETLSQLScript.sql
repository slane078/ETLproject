-- Load new Schema and Tables for project
-- NOTE: When transforming data from countries table, the ID column was not populated with a header
-- so a header was added in xls to make loading easier.
CREATE SCHEMA `etl_project` ;

-- Imported new tables at this point

USE etl_project;

-- setting for easy reference while updating and transforming data
SELECT * FROM countries;
SELECT * FROM happiness;


-- Creating id columns in tables

ALTER TABLE countries
ADD COLUMN id INT NOT NULL AUTO_INCREMENT KEY FIRST;

ALTER TABLE happiness
ADD COLUMN id INT FIRST;

-- crossing table id's so that they are congruent between countries and happiness tables
UPDATE
    happiness, countries
SET
    happiness.id = countries.id
WHERE
    countries.Country = happiness.Country;

-- Quick query to make sure tables are connecting correctly

SELECT countries.Country, happiness.`Happiness.Rank` from happiness
JOIN countries ON countries.id = happiness.id
WHERE happiness.Freedom > 0.6;
