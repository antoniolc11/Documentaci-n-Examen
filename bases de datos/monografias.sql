DROP TABLE IF EXISTS monografias cascade;
DROP TABLE IF EXISTS autores cascade;
DROP TABLE IF EXISTS articulos cascade;
DROP TABLE IF EXISTS articulos_monografias cascade;
DROP TABLE IF EXISTS articulos_autores cascade;

CREATE TABLE monografias (
    id bigserial PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    anyo   numeric(4) NOT NULL
);

CREATE TABLE autores (
    id bigserial PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
    );

CREATE TABLE articulos (
    id bigserial PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    anyo   numeric(4) NOT NULL,
    num_paginas INTEGER NOT NULL
);

CREATE TABLE articulos_monografias (
    articulo_id     BIGINT REFERENCES articulos (id),
    monografia_id   BIGINT REFERENCES monografias (id),
    PRIMARY KEY(articulo_id, monografia_id)
);

CREATE TABLE articulos_autores (
    articulo_id     BIGINT REFERENCES articulos (id),
    autor_id        BIGINT REFERENCES autores (id),
    PRIMARY KEY(articulo_id, autor_id)
);


