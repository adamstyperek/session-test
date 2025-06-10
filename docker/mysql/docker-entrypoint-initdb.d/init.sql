USE symfony;

CREATE TABLE IF NOT EXISTS movie (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    director VARCHAR(255) NOT NULL,
    release_year INT NOT NULL,
    description TEXT,
    rating FLOAT NOT NULL,
    genre VARCHAR(255)
);

-- Insert 200 example movies
INSERT INTO movie (title, director, release_year, description, rating, genre) VALUES
('The Shawshank Redemption', 'Frank Darabont', 1994, 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.', 9.3, 'Drama'),
('The Godfather', 'Francis Ford Coppola', 1972, 'The aging patriarch of an organized crime dynasty transfers control to his reluctant son.', 9.2, 'Crime'),
('The Dark Knight', 'Christopher Nolan', 2008, 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.', 9.0, 'Action'),
('Pulp Fiction', 'Quentin Tarantino', 1994, 'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.', 8.9, 'Crime'),
('Forrest Gump', 'Robert Zemeckis', 1994, 'The presidencies of Kennedy and Johnson, the Vietnam War, the Watergate scandal and other historical events unfold from the perspective of an Alabama man with an IQ of 75.', 8.8, 'Drama'),
('Inception', 'Christopher Nolan', 2010, 'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.', 8.8, 'Sci-Fi'),
('The Matrix', 'Lana Wachowski', 1999, 'A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.', 8.7, 'Sci-Fi'),
('Goodfellas', 'Martin Scorsese', 1990, 'The story of Henry Hill and his life in the mob, covering his relationship with his wife Karen Hill and his mob partners Jimmy Conway and Tommy DeVito.', 8.7, 'Crime'),
('The Silence of the Lambs', 'Jonathan Demme', 1991, 'A young F.B.I. cadet must receive the help of an incarcerated and manipulative cannibal killer to help catch another serial killer, a madman who skins his victims.', 8.6, 'Thriller'),
('Fight Club', 'David Fincher', 1999, 'An insomniac office worker and a devil-may-care soapmaker form an underground fight club that evolves into something much, much more.', 8.8, 'Drama');

-- Add more movies with random data
INSERT INTO movie (title, director, release_year, description, rating, genre)
SELECT 
    CONCAT('Movie ', n),
    ELT(FLOOR(1 + RAND() * 10), 'Steven Spielberg', 'James Cameron', 'Martin Scorsese', 'Christopher Nolan', 'Quentin Tarantino', 'David Fincher', 'Ridley Scott', 'Peter Jackson', 'George Lucas', 'Stanley Kubrick'),
    FLOOR(1970 + RAND() * 50),
    CONCAT('Description for movie ', n),
    ROUND(5 + RAND() * 5, 1),
    ELT(FLOOR(1 + RAND() * 8), 'Action', 'Comedy', 'Drama', 'Sci-Fi', 'Thriller', 'Horror', 'Romance', 'Documentary')
FROM (
    SELECT a.N + b.N * 10 + 1 n
    FROM (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a
    CROSS JOIN (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b
    ORDER BY n
) numbers
WHERE n <= 190; 