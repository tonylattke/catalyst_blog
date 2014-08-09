-- Users and role tables, along with a many-to-many join table
PRAGMA foreign_keys = ON;
CREATE TABLE users (
        id            INTEGER PRIMARY KEY,
        username      TEXT,
        password      TEXT,
        email_address TEXT,
        first_name    TEXT,
        last_name     TEXT,
        active        INTEGER
);
CREATE TABLE role (
        id   INTEGER PRIMARY KEY,
        role TEXT
);
CREATE TABLE user_role (
        user_id INTEGER REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
        role_id INTEGER REFERENCES role(id) ON DELETE CASCADE ON UPDATE CASCADE,
        PRIMARY KEY (user_id, role_id)
);

-- Posts and comments
CREATE TABLE post (
    id INTEGER PRIMARY KEY,
    name TEXT,
    text TEXT,
    date DATETIME
);
 
CREATE TABLE comment (
    id INTEGER PRIMARY KEY,
    name TEXT,
    text TEXT,
    date DATETIME
);

CREATE TABLE post_comment (
        post_id INTEGER REFERENCES post(id) ON DELETE CASCADE ON UPDATE CASCADE,
        comment_id INTEGER REFERENCES comment(id) ON DELETE CASCADE ON UPDATE CASCADE,
        PRIMARY KEY (post_id, comment_id)
);

-- Load up some initial test data
INSERT INTO users VALUES (1, 'tony', 'mypass', 'tonylattke@gmail.com', 'Tony',  'Lattke', 1);
INSERT INTO users VALUES (2, 'enrique', 'mypass', 'enriqueurbaneja@gmail.com', 'Enrique', 'Urbaneja',  1);
INSERT INTO role VALUES (1, 'admin');
INSERT INTO role VALUES (2, 'user');
INSERT INTO user_role VALUES (1, 1);
INSERT INTO user_role VALUES (1, 2);
INSERT INTO user_role VALUES (2, 2);