-- 📌 Query 1: cleaning imblicit ratings
UPDATE ratings SET Book-Rating = NULL WHERE Book-Rating = 0;

-- 📌 Query 2: cleaning language column
UPDATE books SET language = NULL WHERE language = '9';

-- 📌 Query 3: cleaning category column
UPDATE books SET category = NULL WHERE language = '9';

-- 📌 Query 4: check for duplicates
SELECT ISBN, COUNT(*) FROM books GROUP BY ISBN HAVING COUNT(*) > 1;

-- 📌 Query 5: standard format for all texts
UPDATE ratings SET ISBN = TRIM(REPLACE(ISBN, '/', '')) WHERE ISBN LIKE '%/%';

-- 📌 Query 6: standard format for all texts
UPDATE books SET ISBN = TRIM(REPLACE(ISBN, '/', '')) WHERE ISBN LIKE '%/%';

-- 📌 Query 7: standard format for all texts
UPDATE books SET Book-Title = LOWER(Book-Title), Book-Author = LOWER(Book-Author);

-- 📌 Query 8: cleaning up the Location column by separating it into City, State, and Country 
ALTER TABLE users 
ADD COLUMN City VARCHAR(255),
 ADD COLUMN State VARCHAR(255), 
ADD COLUMN Country VARCHAR(255);

-- 📌 Query 9: cleaning up the Location column by separating it into City, State, and Country 
UPDATE users 
  SET City = SPLIT_PART(Location, ',', 1), 
  State = SPLIT_PART(Location, ',', 2), 
  Country = SPLIT_PART(Location, ',', 3);

-- 📌 Query 10: Cleaning location data (City, State, Country)
-- Set City to NULL for invalid entries
UPDATE users 
SET City = NULL 
WHERE City IN ('n/a', 'N/A', 'na', '');

-- Set State to NULL for invalid entries
UPDATE users 
SET State = NULL 
WHERE TRIM(State) = '' OR State IN ('n/a', 'N/A', 'na');

-- Set Country to NULL for invalid entries
UPDATE users 
SET Country = NULL 
WHERE TRIM(Country) = '' OR Country IN ('n/a', 'N/A', 'na');

-- 📌 Query 11: Cleaning the country column of the users table
-- Add a new column to store cleaned country values
ALTER TABLE users 
ADD COLUMN cleaned_country VARCHAR(255);

-- Populate the cleaned_country column with valid country values
UPDATE users
SET cleaned_country = TRIM(LOWER(country))
WHERE 
    TRIM(LOWER(country)) IS NOT NULL  
    AND TRIM(LOWER(country)) NOT IN ('-', 'unknown', 'n/a', '', 'null')  
    AND TRIM(LOWER(country)) NOT LIKE '%[0-9]%'  
    AND LENGTH(TRIM(LOWER(country))) > 2;

-- 📌 Query 12: Grouping countries using a mapping table
-- Create a mapping table to standardize country names
CREATE TABLE country_mapping (
    raw_country VARCHAR(255) PRIMARY KEY,
    standard_country VARCHAR(255)
);

-- Insert standardized country mappings
INSERT INTO country_mapping (raw_country, standard_country) VALUES
('usa', 'united states'),
('u.s.a.', 'united states'),
('united states of america', 'united states'),
('united states', 'united states'),
('u.s.', 'united states'),
('america', 'united states'),
('u.s.a!', 'united states'),
('u.s.a>', 'united states'),
('u.s>', 'united states'),
('u.s. of a.', 'united states'),
('u.s. virgin islands', 'united states'),
('us virgin islands', 'united states'),
('canada', 'canada'),
('canada eh', 'canada'),
('cananda', 'canada'),
('canda', 'canada'),
('il canada', 'canada'),
('le canada', 'canada'),
('uk', 'united kingdom'),
('u.k.', 'united kingdom'),
('united kingdom', 'united kingdom'),
('united kindgdom', 'united kingdom'),
('united kindgonm', 'united kingdom'),
('england', 'united kingdom'),
('england uk', 'united kingdom'),
('scotland', 'united kingdom'),
('wales', 'united kingdom'),
('n. ireland', 'united kingdom'),
('northern ireland', 'united kingdom'),
('germany', 'germany'),
('deutschland', 'germany'),
('geermany', 'germany'),
('germay', 'germany'),
('france', 'france'),
('la france', 'france'),
('italy', 'italy'),
('italia', 'italy'),
('italien', 'italy'),
('itlay', 'italy'),
('spain', 'spain'),
('españa', 'spain'),
('espaã?â±a', 'spain'),
('espaã±a', 'spain'),
('australia', 'australia'),
('austria', 'austria'),
('china', 'china'),
('china öw¹ú', 'china'),
('china people`s republic', 'china'),
('chinaöð¹ú', 'china'),
('p.r. china', 'china'),
('p.r.c', 'china'),
('p.r.china', 'china'),
('people`s republic of china', 'china'),
('india', 'india'),
('indiai', 'india'),
('japan', 'japan'),
('japan military', 'japan'),
('brazil', 'brazil'),
('brasil', 'brazil'),
('russia', 'russia'),
('russian federation', 'russia'),
('south korea', 'south korea'),
('republic of korea', 'south korea'),
('korea', 'south korea'),
('s.corea', 'south korea'),
('north korea', 'north korea'),
('mexico', 'mexico'),
('méxico', 'mexico'),
('mexico city', 'mexico'),
('ciudad de mexico', 'mexico'),
('disrito federal', 'mexico'),
('distrito federal', 'mexico'),
('edo. de mexico', 'mexico'),
('estado de mexico', 'mexico'),
('new york', 'united states'), 
('texas', 'united states'),
('florida', 'united states'),
('oregon', 'united states'), 
('virginia', 'united states'),
('missouri', 'united states'), 
('washington', 'united states'),
('colorado', 'united states'),
('ohio', 'united states'), 
('michigan', 'united states'),
('pennsylvania', 'united states'),
('illinois', 'united states'), 
('arizona', 'united states'),
('minnesota', 'united states'),
('queensland', 'australia'), 
('massachusetts', 'united states'),
('catalonia', 'spain'), 
('catalunya', 'spain'), 
('hawaii', 'united states'),
('l`italia', 'italy');

-- Apply the country mapping to standardize country names
UPDATE users
SET cleaned_country = COALESCE(
    m.standard_country, -- Use the standardized country if a match is found
    TRIM(LOWER(users.country)), -- Fallback to the original country column (trimmed and lowercased)
    'Unknown' -- Default value if both mapping and country are NULL
)
FROM country_mapping m
WHERE LOWER(TRIM(users.cleaned_country)) = LOWER(TRIM(m.raw_country)) -- Match cleaned_country
   OR LOWER(TRIM(users.country)) = LOWER(TRIM(m.raw_country)); -- Match country

-- Set NULL for invalid or funny entries in cleaned_country
UPDATE users
SET cleaned_country = NULL
WHERE cleaned_country IN (
    'a new year is ahead', 'address is:adem ademoski 13', 'adsgfdr', 'bbbzzzzz', 'doodedoo', 'evil empire', 'fairyland', 'frome', 'here and there', 'in your heart', 'input error', 'neverland', 'nowhere', 'obviously', 'quit', 'space', 'somewherein space', 'the great white north', 'thing', 'travelling', 'travelling....', 'universe', 'we`re global!', 'xxxxxx', 'you listed stroud!)'
);

-- 📌 Query 13: Cleaning the publisher column in the books table
-- Standardize publisher names
UPDATE books 
SET publisher = 'Bantam' 
WHERE publisher IN ('Bantam Books', 'Bantam Dell Pub Group', 'Bantam Doubleday Dell');

UPDATE books 
SET publisher = 'Random House' 
WHERE publisher IN ('Random House Inc', 'Random House Childrens Books', 'Random House Value Publishing');

UPDATE books 
SET publisher = 'Penguin' 
WHERE publisher IN ('Penguin Books', 'Penguin Group', 'Penguin Putnam');

UPDATE books 
SET publisher = 'HarperCollins' 
WHERE publisher IN ('HarperCollins Publishers', 'Harper Collins', 'Harper & Row');

UPDATE books 
SET publisher = 'Simon & Schuster' 
WHERE publisher IN ('Simon & Schuster Inc', 'Simon and Schuster', 'Simon & Schuster Books');
