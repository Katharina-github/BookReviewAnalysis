-- 📌 Query 1: create user table
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    location TEXT,
    age INT
);

-- 📌 Query 2: create book table
CREATE TABLE books (
    isbn VARCHAR(20) PRIMARY KEY,
    book_title TEXT,
    book_author TEXT,
    year_of_publication INT,
    publisher TEXT,
    img_s TEXT,
    img_m TEXT,
    img_l TEXT,
    language VARCHAR(10),
    category TEXT
);

-- 📌 Query 2: create rating table
CREATE TABLE ratings ( 
  user_id INT, 
  isbn VARCHAR(30), 
  book_rating INT CHECK (book_rating BETWEEN 0 AND 10), 
  PRIMARY KEY (user_id, isbn), 
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE, 
  FOREIGN KEY (isbn) REFERENCES books(isbn) ON DELETE CASCADE 
);

-- I used the Import/Export data function on the respective table in pgAdmin4 – 
-- settings: Encoding: Latin1, format csv,  header on, delimiter; ,NULL String NULL
-- to fill the tables with data
