--- INSERT, UPDATE, DELETE ---
------------------------------

/*
Additional data for SPONSORS:

	Id 	Name
	-----------
	1 	Allegro
	2 	Baltona
	3 	Cepelia
	
(Id-s genrated in sequence.)

*/

-- SPONSORS INSERT 1
INSERT INTO SPONSORS
(
    ID,
    NAME
)
VALUES
(
    SEQ_SPONSORS.NEXTVAL,
    'Allegro'
);

-- SPONSORS INSERT 2
INSERT INTO SPONSORS
(
    ID,
    NAME
)
VALUES
(
    SEQ_SPONSORS.NEXTVAL,
    'Baltona'
);

-- SPONSORS INSERT 3
INSERT INTO SPONSORS
(
    ID,
    NAME
)
VALUES
(
    SEQ_SPONSORS.NEXTVAL,
    'Cepelia'
);

SELECT * 
FROM SPONSORS;

-- DELETE FROM SPONSORS;

-- DROP SEQUENCE SEQ_SPONSORS;

---

UPDATE ANIMALS SET 
    SPONSOR_ID = (SELECT ID FROM SPONSORS 
				 WHERE UPPER(NAME)LIKE UPPER('ALL%'))
WHERE UPPER(SPECIES) LIKE UPPER('LION');

SELECT * 
FROM SPONSORS;

SELECT SPECIES, SPONSOR_ID
FROM ANIMALS;

UPDATE ANIMALS SET 
    SPONSOR_ID = (SELECT ID FROM SPONSORS 
				 WHERE UPPER(NAME)LIKE UPPER('BAL%'))
WHERE UPPER(SPECIES) NOT LIKE UPPER('LION');

------------------------------------------------------------------------------------
/* ZADANIE 2 */

/*
Zoo się rozrasta, jest za mało pracowników i za dużo zwierząt. Teraz zwierzęciem może
się opiekować więcej niż jedna osoba. W dalszym ciągu zwierzę ma przypisaną jedną 
osobę, która jest za niego ostatecznie odpowiedzialna.

Zmień strukturę bazy danych tak, aby możliwe byłoby wyrażenie relacji opieki 
nad zwierzęciem.

Wprowadź w bazę danych informację, że osoba, która jest odpowiedzialna za zwierzę
także się nim opiekuje.
*/

CREATE TABLE CARETAKER (
    ANIMAL_ID            NUMBER,
    STAFF_ID             NUMBER   
);


ALTER TABLE CARETAKER
ADD CONSTRAINT CARETAKER_PK PRIMARY KEY (ANIMAL_ID, STAFF_ID);

ALTER TABLE CARETAKER
ADD CONSTRAINT CARETAKER_ANIMAL_ID_FK
   FOREIGN KEY (ANIMAL_ID)
   REFERENCES ANIMALS(ID);
   
ALTER TABLE CARETAKER
ADD CONSTRAINT CARETAKER_STAFF_ID_FK
   FOREIGN KEY (STAFF_ID)
   REFERENCES STAFF(ID);   
   
   
INSERT INTO CARETAKER
SELECT ID, RESPONSIBLE_PERSON_ID
FROM ANIMALS;

SELECT *
FROM CARETAKER;

------------------------------------------------------------------------------------
/* ZADANIE 3 */

/* 
 MODIFICATIONS
*/

CREATE TABLE SPECIES (
    ID                      NUMBER,
    NAME                    VARCHAR2(64)   
);

ALTER TABLE SPECIES
ADD CONSTRAINT SPECIES_PK PRIMARY KEY (ID);

/*
ALTER TABLE SPECIES
ADD CONSTRAINT SPECIES_ID_FK
   FOREIGN KEY (SPONSOR_ID)
   REFERENCES SPONSORS(ID);
*/
   
INSERT INTO SPECIES (ID, NAME) (
    SELECT SEQ_SPECIES.NEXTVAL, SPECIES
    FROM (SELECT DISTINCT SPECIES FROM ANIMALS)
);   

DROP SEQUENCE SEQ_SPECIES;

SELECT * FROM SPECIES;

SELECT * FROM SPONSORS;

DELETE FROM SPECIES;


---- PART B
       
ALTER TABLE
   ANIMALS
ADD
   (
      SPECIES_CHANGE     NUMBER

   );

/*   
UPDATE ANIMALS SET  
    SPECIES_CHANGE = (SELECT S.ID 
                      FROM SPECIES S
                      JOIN ANIMALS A
                      ON S.NAME = A.SPECIES)
    WHERE  SPECIES = (SELECT S.NAME 
                      FROM SPECIES S
                      JOIN ANIMALS A
                      ON S.NAME = A.SPECIES);
*/                      
                      
UPDATE ANIMALS SET SPECIES_CHANGE = 
	(SELECT S.ID FROM ANIMALS A 
	JOIN SPECIES S 
	ON A.SPECIES = S.NAME 
	WHERE ANIMALS.ID = A.ID) ; 
    
SELECT * FROM ANIMALS;    

SELECT * FROM SPECIES;

-- ALERT!
ALTER TABLE ANIMALS DROP COLUMN SPECIES;

-- ALERT!
ALTER TABLE ANIMALS
RENAME COLUMN SPECIES_CHANGE TO SPECIES;

-- ALERT!
ALTER TABLE 
   SPECIES 
ADD 
   (
      SPECIALIZATION NUMBER
   );

-- ALERT!
ALTER TABLE SPECIES
ADD CONSTRAINT SPECIALIZATION_ID_FK
   FOREIGN KEY (SPECIALIZATION)
   REFERENCES SPECIES(ID);

-- INSERT
INSERT INTO SPECIES (ID, NAME) (
    SELECT SEQ_SPECIES.NEXTVAL, SPECIALIZATION
    FROM (SELECT DISTINCT SPECIALIZATION FROM STAFF)
    );

-- INSERT
INSERT INTO SPECIES
(
    SPECIALIZATION
)
VALUES
(
    ()
);

-- UPDATE
UPDATE SPECIES SET 
    SPECIALIZATION = (SELECT ID FROM SPECIES WHERE )),
WHERE ID = (SELECT SPECIES FROM ANIMALS WHERE   );

SELECT * FROM ANIMALS;
SELECT * FROM STAFF;

-- ALERT!
ALTER TABLE 
   STAFF
ADD 
   (
      SPECIALIZATION_CHANGE NUMBER
   );
   
UPDATE STAFF SET SPECIALIZATION_CHANGE = 
	(SELECT S.ID FROM STAFF ST 
	JOIN SPECIES S 
	ON A.SPECIES = S.NAME 
	WHERE ANIMALS.ID = A.ID);  



/* PART 4 */

/*
 SOLUTIONS
*/

------------------------------------------------------------------------------------


/* PART 5 */

/*
 SOLUTIONS
*/

------------------------------------------------------------------------------------
 