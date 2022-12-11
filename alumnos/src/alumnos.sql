DROP TABLE IF EXISTS alumnos CASCADE;
DROP TABLE IF EXISTS ccee CASCADE;
DROP TABLE IF EXISTS notas CASCADE;

CREATE TABLE alumnos (
    id bigserial PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    fecha_nac TIMESTAMP NOT NULL,
    saldo      numeric(6,2) NOT NULL
);

CREATE TABLE ccee (
    id bigserial PRIMARY KEY,
    ce VARCHAR(4) NOT NULL UNIQUE,
    descripción VARCHAR(255) NOT NULL
);

CREATE TABLE notas (
    id bigserial NOT NULL PRIMARY KEY,
    alumno_id BIGINT NOT NULL REFERENCES alumnos (id),
    ccee_id BIGINT NOT NULL REFERENCES ccee (id),
    nota numeric(4,2) NOT NULL,
    UNIQUE(alumno_id, ccee_id)
);





