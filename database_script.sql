create table PRODUCTION (
name TEXT PRIMARY KEY,
address TEXT
);

create table GENRE (
genre_id TEXT PRIMARY KEY
);

create table PERSON (
name TEXT,
b_date DATE,
PRIMARY KEY (name, b_date)
);

create table MOVIE (
title TEXT,
year DATE,
outline TEXT,
genre TEXT,
name_pro TEXT,
PRIMARY KEY (title, year),
FOREIGN KEY (name_pro) REFERENCES PRODUCTION (name)
);

create table MOVIE_GENRE (
genre_id TEXT,
title TEXT,
year DATE,
PRIMARY KEY (genre_id, title, year),
FOREIGN KEY (genre_id) REFERENCES GENRE (genre_id),
FOREIGN KEY (title, year) REFERENCES MOVIE (title, year)
);





create table PERSON_MOVIE (
role TEXT,
name TEXT,
b_date DATE,
title TEXT,
year DATE,
PRIMARY KEY (name, b_date, title, year),
FOREIGN KEY (name, b_date) REFERENCES PERSON (name, b_date),
FOREIGN KEY (title, year) REFERENCES MOVIE (title, year)
);


create table QUOTE (
quote_id INTEGER PRIMARY KEY,
text TEXT,
name TEXT,
b_date DATE,
title TEXT,
year DATE,
FOREIGN KEY (name, b_date) REFERENCES PERSON (name, b_date),
FOREIGN KEY (title, year) REFERENCES MOVIE (title, year)
);