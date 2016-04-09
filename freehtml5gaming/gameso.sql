
CREATE EXTENSION pgcrypto;
\c gamesdb

CREATE TABLE games (    title text,
                        publisher varchar,
                        genre varchar,
                        released int,
                        playtime int
                    );
                        
CREATE TABLE users (        username text NOT NULL PRIMARY KEY,
                            password text NOT NULL,
                            UNIQUE(username)
                            );
                            
                            
                            
INSERT INTO users VALUES('first', crypt('1', gen_salt('bf')));                            
INSERT INTO users (username, password) VALUES('second', crypt('1', gen_salt('bf')));
INSERT INTO users (username, password) VALUES('third', crypt('1', gen_salt('bf')));
INSERT INTO rooms (username, roomname, subs) VALUES('first', 'Public', 'first');