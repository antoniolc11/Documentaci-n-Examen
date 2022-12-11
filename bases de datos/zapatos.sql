DROP TABLE IF EXISTS zapatos cascade;
DROP TABLE IF EXISTS usuarios cascade;
DROP TABLE IF EXISTS carritos cascade;
DROP TABLE IF EXISTS facturas cascade;
DROP TABLE IF EXISTS lineas cascade;


CREATE TABLE zapatos(
    id bigserial    PRIMARY KEY,
    codigo          varchar(13) UNIQUE,
    precio          numeric(5,2)
);

CREATE TABLE usuarios(
    id bigserial    PRIMARY KEY,
    password        varchar(255) NOT NULL
);

CREATE TABLE carritos(
    id bigserial    PRIMARY KEY,
    user_id         BIGINT NOT NULL REFERENCES usuario (id),
    zapato_id       BIGINT NOT NULL REFERENCES zapatos (id),
    cantidad        INTEGER NOT NULL
);

CREATE TABLE facturas(
    id  bigserial   PRIMARY KEY,
    user_id         BIGINT NOT NULL REFERENCES usuario (id)
);

CREATE TABLE lineas (
    id  bigserial   PRIMARY KEY,
    factura_id      BIGINT NOT NULL REFERENCES facturas (id),
    zapato_id       BIGINT NOT NULL REFERENCES zapatos (id),
    cantidad        INTEGER NOT NULL
);
