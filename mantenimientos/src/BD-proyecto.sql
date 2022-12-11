------------------- BASE DATOS: prueba_proyecto1

------------------- BORRADO DE TABLAS Y SECUENCIAS: ---------------

DROP TABLE oper_depart;
DROP TABLE oper_incidencia;
DROP TABLE incidencia; 
DROP TABLE departamento; 
DROP TABLE operario; 
DROP TABLE estado; 
DROP TABLE categoria; 
DROP TABLE ubicacion; 
DROP SEQUENCE sec_cod_departamento; 
DROP SEQUENCE sec_id_operario;
DROP SEQUENCE sec_cod_estado;
DROP SEQUENCE sec_cod_categoria;
DROP SEQUENCE sec_cod_ubicacion;
DROP SEQUENCE sec_cod_incidencia;


------------------- TABLA DEPARTAMENTO: ---------------

CREATE SEQUENCE sec_cod_departamento
  minvalue 1000
  maxvalue 1999
  increment by 1;

CREATE TABLE departamento (
 cod_depart  	BIGINT default nextval('sec_cod_departamento'),
 nom_depart  VARCHAR(25) UNIQUE NOT NULL, 
 CONSTRAINT PK_departamento PRIMARY KEY (cod_depart));

INSERT INTO DEPARTAMENTO(nom_depart) VALUES ('Dirección');
INSERT INTO DEPARTAMENTO(nom_depart) VALUES ('Supervisión');
INSERT INTO DEPARTAMENTO(nom_depart) VALUES ('Limpieza');
INSERT INTO DEPARTAMENTO(nom_depart) VALUES ('Fontaneria');
INSERT INTO DEPARTAMENTO(nom_depart) VALUES ('Informática');
INSERT INTO DEPARTAMENTO(nom_depart) VALUES ('Eléctrico');


------------------- TABLA OPERARIO: ---------------

CREATE SEQUENCE sec_id_operario
  minvalue 2000
  maxvalue 2999
  increment by 1;

CREATE TABLE operario (
 id_oper    	  BIGINT default nextval('sec_id_operario'),
 nombre  	      VARCHAR(20) NOT NULL,
 apellido1    	VARCHAR(20) NOT NULL,
 apellido2      VARCHAR(20) NOT NULL,
 dni 		        VARCHAR(9) NOT NULL,
 telefono   	  NUMERIC(9) NOT NULL,
 usuario        VARCHAR(255) NOT NULL UNIQUE,
 password       VARCHAR(255) NOT NULL,
 CONSTRAINT PK_operario PRIMARY KEY (id_oper));
 

INSERT INTO OPERARIO VALUES (nextval('sec_id_operario'),'Antonio Fernando','Román','Fernandez','47344703P', 675523834, 'admin', crypt('admin', gen_salt('bf', 10)));
INSERT INTO OPERARIO VALUES (nextval('sec_id_operario'),'Cristina','Márquez','Rizo','32064802L', 685373829, 'cmarriz07', crypt('pepe', gen_salt('bf', 10)));
INSERT INTO OPERARIO VALUES (nextval('sec_id_operario'),'Manolo','Martín','arroyo','34796147L', 674165739, 'manolito', crypt('pepe', gen_salt('bf', 10)));
INSERT INTO OPERARIO VALUES (nextval('sec_id_operario'),'Luis','Camilo','Pacheco','14875236R', 666248762, 'luisito', crypt('pepe', gen_salt('bf', 10)));


------------------- TABLA OPER_DEPART: ---------------

CREATE TABLE oper_depart (
 id_oper	  BIGINT,
 cod_depart	  BIGINT,
CONSTRAINT PK_oper_depart PRIMARY KEY (id_oper, cod_depart));
 
INSERT INTO OPER_DEPART VALUES ((SELECT id_oper FROM operario WHERE dni='47344703P'), (SELECT cod_depart FROM departamento WHERE nom_depart='Informática'));
INSERT INTO OPER_DEPART VALUES ((SELECT id_oper FROM operario WHERE dni='47344703P'), (SELECT cod_depart FROM departamento WHERE nom_depart='Dirección'));
INSERT INTO OPER_DEPART VALUES ((SELECT id_oper FROM operario WHERE dni='32064802L'), (SELECT cod_depart FROM departamento WHERE nom_depart='Limpieza'));
INSERT INTO OPER_DEPART VALUES ((SELECT id_oper FROM operario WHERE dni='34796147L'), (SELECT cod_depart FROM departamento WHERE nom_depart='Supervisión'));
INSERT INTO OPER_DEPART VALUES ((SELECT id_oper FROM operario WHERE dni='34796147L'), (SELECT cod_depart FROM departamento WHERE nom_depart='Fontaneria'));
INSERT INTO OPER_DEPART VALUES ((SELECT id_oper FROM operario WHERE dni='34796147L'), (SELECT cod_depart FROM departamento WHERE nom_depart='Eléctrico'));
INSERT INTO OPER_DEPART VALUES ((SELECT id_oper FROM operario WHERE dni='14875236R'), (SELECT cod_depart FROM departamento WHERE nom_depart='Informática'));
 
 
 ------------------- TABLA ESTADO: ---------------
 
CREATE SEQUENCE sec_cod_estado
  minvalue 3000
  maxvalue 3999
  increment by 1;
 
CREATE TABLE estado (
 cod_estado		BIGINT default nextval('sec_cod_estado'),
 nom_estado		VARCHAR(15) NOT NULL,
 CONSTRAINT PK_estado PRIMARY KEY (cod_estado));
 
INSERT INTO ESTADO(nom_estado) VALUES ('Pendiente');
INSERT INTO ESTADO(nom_estado) VALUES ('En curso');
INSERT INTO ESTADO(nom_estado) VALUES ('Finalizado');


 
 ------------------- TABLA CATEGORIA: ---------------
 
CREATE SEQUENCE sec_cod_categoria
  minvalue 4000
  maxvalue 4999
  increment by 1;
 
CREATE TABLE categoria (
 cod_categoria		BIGINT default nextval('sec_cod_categoria'),
 nom_categoria		VARCHAR(15) NOT NULL,
 CONSTRAINT PK_categoria PRIMARY KEY (cod_categoria));
 
INSERT INTO categoria(nom_categoria) VALUES ('Avería');
INSERT INTO categoria(nom_categoria) VALUES ('Mantenimiento');


 ------------------- TABLA UBICACIÓN: ---------------
 
CREATE SEQUENCE sec_cod_ubicacion
  minvalue 5000
  maxvalue 5999
  increment by 1;
 
CREATE TABLE ubicacion (
 cod_ubicacion		 BIGINT default nextval('sec_cod_ubicacion'),
 nom_ubicacion		 VARCHAR(25) NOT NULL,
 CONSTRAINT PK_ubicacion PRIMARY KEY (cod_ubicacion));
 
INSERT INTO ubicacion(nom_ubicacion) VALUES ('Recepción');
INSERT INTO ubicacion(nom_ubicacion) VALUES ('Restaurante americano');
INSERT INTO ubicacion(nom_ubicacion) VALUES ('Restaurante mexicano');
 
 
 
 ------------------- TABLA INCIDENCIA: ---------------
 
 CREATE SEQUENCE sec_cod_incidencia
  minvalue 100
  increment by 1;
 
 CREATE TABLE incidencia (
   cod_incidencia	    BIGINT default nextval('sec_cod_incidencia'),
   fecha_creacion	    TIMESTAMP NOT NULL,
   labor 		    VARCHAR(150) NOT NULL,
   id_oper_creador	    BIGINT NOT NULL,
   id_oper_asignado	    BIGINT NOT NULL,
   cod_estado		    BIGINT NOT NULL,
   cod_ubicacion	    BIGINT NOT NULL,
   cod_depart	 	    BIGINT NOT NULL,
   cod_categoria	    BIGINT NOT NULL,
   CONSTRAINT PK_incidencia PRIMARY KEY (cod_incidencia)); 


   INSERT INTO incidencia (fecha_creacion, labor, id_oper_creador, id_oper_asignado, cod_estado, cod_ubicacion, cod_depart, cod_categoria)
        VALUES(current_timestamp, 
               'Limpieza de impresoras',
               (SELECT id_oper FROM operario WHERE dni='34796147L'),
               (SELECT id_oper FROM operario WHERE dni='47344703P'),
               (SELECT cod_estado FROM estado WHERE nom_estado = 'Pendiente'),
               (SELECT cod_ubicacion FROM ubicacion WHERE nom_ubicacion = 'Recepción'),
               (SELECT cod_depart FROM departamento WHERE nom_depart = 'Informática'),
               (SELECT cod_categoria FROM categoria WHERE nom_categoria = 'Mantenimiento'));   

------------------- TABLA OPER_INCIDENCIA: ---------------

CREATE TABLE oper_incidencia (
 id_oper			BIGINT,
 cod_incidencia			BIGINT,
 fecha_reparacion		TIMESTAMP,
 des_reparacion			VARCHAR(200),
CONSTRAINT PK_oper_incidencia PRIMARY KEY (id_oper, cod_incidencia));

INSERT INTO oper_incidencia (id_oper, cod_incidencia, fecha_reparacion, des_reparacion)
     VALUES ((SELECT id_oper FROM operario WHERE dni='47344703P'),
             (SELECT cod_incidencia FROM incidencia WHERE id_oper_asignado = (SELECT id_oper FROM operario WHERE dni='47344703P')),
             current_timestamp,
             'Se realiza limpieza de todas las impresoras de recepción');
             
--Una vez se introduzca una incidencia en esta tabla, hay que actualizar su estado.--
             
UPDATE incidencia
   SET cod_estado = (SELECT cod_estado FROM estado WHERE nom_estado = 'Finalizado')
 WHERE cod_incidencia = 100; 
 

----------------- DEFINICIÓN DE CLAVES FORANEAS --------------------------

ALTER TABLE oper_depart
ADD CONSTRAINT FK_ID_OPER_OPER_DEPART FOREIGN KEY(ID_OPER)
REFERENCES OPERARIO (ID_OPER)
on delete restrict on update restrict;

ALTER TABLE oper_depart
ADD CONSTRAINT FK_COD_DEPART_OPER_DEPART FOREIGN KEY(COD_DEPART)
REFERENCES DEPARTAMENTO (COD_DEPART)
on delete restrict on update restrict;

ALTER TABLE INCIDENCIA
ADD CONSTRAINT FK_ID_OPER_CREADOR_INCIDENCIA FOREIGN KEY(ID_OPER_CREADOR)
REFERENCES OPERARIO (ID_OPER)
on delete restrict on update restrict;

ALTER TABLE INCIDENCIA
ADD CONSTRAINT FK_ID_OPER_ASIGNADO_INCIDENCIA FOREIGN KEY(ID_OPER_ASIGNADO)
REFERENCES OPERARIO (ID_OPER)
on delete restrict on update restrict;

ALTER TABLE INCIDENCIA
ADD CONSTRAINT FK_COD_ESTADO_INCIDENCIA FOREIGN KEY(COD_ESTADO)
REFERENCES ESTADO (COD_ESTADO)
on delete restrict on update restrict;

ALTER TABLE INCIDENCIA
ADD CONSTRAINT FK_COD_UBICACION_INCIDENCIA FOREIGN KEY(COD_UBICACION)
REFERENCES UBICACION (COD_UBICACION)
on delete restrict on update restrict;

ALTER TABLE INCIDENCIA
ADD CONSTRAINT FK_COD_DEPART_INCIDENCIA FOREIGN KEY(COD_DEPART)
REFERENCES DEPARTAMENTO (COD_DEPART)
on delete restrict on update restrict;

ALTER TABLE INCIDENCIA
ADD CONSTRAINT FK_COD_CATEGORIA_INCIDENCIA FOREIGN KEY(COD_CATEGORIA)
REFERENCES CATEGORIA (COD_CATEGORIA)
on delete restrict on update restrict;

ALTER TABLE OPER_INCIDENCIA
ADD CONSTRAINT FK_ID_OPER_OPER_INCIDENCIA FOREIGN KEY(ID_OPER)
REFERENCES OPERARIO (ID_OPER)
on delete restrict on update restrict;

ALTER TABLE OPER_INCIDENCIA
ADD CONSTRAINT FK_COD_INCIDENCIA_OPER_INCIDENCIA FOREIGN KEY(COD_INCIDENCIA)
REFERENCES INCIDENCIA (COD_INCIDENCIA)
on delete restrict on update restrict;
