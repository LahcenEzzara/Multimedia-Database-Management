-- Création de la table multimédia :
CREATE TABLE Player(
    code NUMBER(10) PRIMARY KEY,
    lname VARCHAR2(50) NOT NULL,
    fname VARCHAR2(50) NOT NULL,
    field VARCHAR2(100),
    photo BFILE
);

CREATE DIRECTORY player_photo AS 'C:/server/player_photo';

-- Insertion de données multimédias :
INSERT INTO
    Player (code, lname, fname, field, photo)
VALUES
    (
        1,
        'Hakimi',
        'Achraf',
        'CAN',
        BFILENAME('player_photo', 'Hakimi.png')
    );

-- Récupération de données multimédias :
SELECT
    *
FROM
    Player
WHERE
    code = 1;

-- Mise à jour de données multimédias :
UPDATE
    Player
SET
    field = 'AFCON'
WHERE
    code = 1;

UPDATE
    Player
SET
    photo = BFILENAME('player_photo', 'Darwizzy.png')
WHERE
    code = 1;

-- Suppression de données multimédias :
DELETE FROM
    Player
WHERE
    code = 1;