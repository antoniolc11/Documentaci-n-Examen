DROP TABLE IF EXISTS albunes cascade;
DROP TABLE IF EXISTS artistas cascade;
DROP TABLE IF EXISTS temas cascade;
DROP TABLE IF EXISTS albunes_temas cascade;
DROP TABLE IF EXISTS artistas_temas cascade;


CREATE TABLE albunes (
    id bigserial PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    anyo   NUMERIC(4) NOT NULL
);

CREATE TABLE artistas (
    id bigserial PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);

CREATE TABLE temas (
    id bigserial PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    anyo   numeric(4) NOT NULL,
    duracion interval NOT NULL
);

CREATE TABLE albunes_temas (
    albun_id     BIGINT REFERENCES albunes (id),
    tema_id      BIGINT REFERENCES temas (id),
    PRIMARY KEY(albun_id, tema_id)
);

CREATE TABLE artistas_temas (
    artista_id     BIGINT REFERENCES artistas (id),
    tema_id        BIGINT REFERENCES temas (id),
    PRIMARY KEY(artista_id, tema_id)
);


CREATE TABLE notas (
    id bigserial NOT NULL PRIMARY KEY,
    alumno_id BIGINT NOT NULL REFERENCES alumnos (id),
    ccee_id BIGINT NOT NULL REFERENCES ccee (id),
    nota numeric(4,2) NOT NULL,
    UNIQUE(alumno_id, ccee_id)
);