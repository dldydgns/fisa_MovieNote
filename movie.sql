use movie;

CREATE TABLE movie (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    createDate DATE,
    watchDate DATE,
    score INT CHECK (score BETWEEN 0 AND 5),
    content TEXT,
    isfix BOOLEAN
);
