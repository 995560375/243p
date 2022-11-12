-- 1
CREATE INDEX vendors_zip_code_ix ON vendors (vendor_zip_code);

-- 2
USE ex;

DROP TABLE IF EXISTS members_committees;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS committees;

CREATE TABLE members 
(
  member_id     INT           PRIMARY KEY   AUTO_INCREMENT, 
  first_name    VARCHAR(50)   NOT NULL, 
  last_name     VARCHAR(50)   NOT NULL, 
  address       VARCHAR(50)   NOT NULL, 
  city          VARCHAR(25)   NOT NULL, 
  state         CHAR(2)       NOT NULL, 
  phone         VARCHAR(20)   NOT NULL
);

CREATE TABLE committees 
(
  committee_id      INT            PRIMARY KEY   AUTO_INCREMENT, 
  committee_name    VARCHAR(50)    NOT NULL
);

CREATE TABLE members_committees
(
  member_id       INT    NOT NULL, 
  committee_id    INT    NOT NULL,
  CONSTRAINT members_committees_fk_members FOREIGN KEY (member_id)
    REFERENCES members (member_id), 
  CONSTRAINT members_committees_fk_committees FOREIGN KEY (committee_id)
	  REFERENCES committees (committee_id)
);

-- 3
USE ex;

INSERT INTO members
VALUES (DEFAULT, 'Sunny', 'Zheng', '166666 street', 'Irvine', 'CA', '1234556');
INSERT INTO members
VALUES (DEFAULT, 'Wwww', 'kkkkk', '25555 street', 'Seatle', 'CA', '2232323');

INSERT INTO committees
VALUES (DEFAULT, 'Basketball');
INSERT INTO committees
VALUES (DEFAULT, 'Swimming');

INSERT INTO members_committees
VALUES (1, 2);
INSERT INTO members_committees
VALUES (2, 1);
INSERT INTO members_committees
VALUES (2, 2);

SELECT c.committee_name, m.last_name, m.first_name
FROM committees c
  JOIN members_committees mc
    ON c.committee_id = mc.committee_id
  JOIN members m
    ON mc.member_id = m.member_id
ORDER BY c.committee_name, m.last_name, m.first_name;

-- 4
ALTER TABLE members
  ADD annual_dues   DECIMAL(5,2)    DEFAULT 52.50;
ALTER TABLE members
  ADD payment_date  DATE;
  
-- 5
ALTER TABLE committees
MODIFY committee_name VARCHAR(50) NOT NULL UNIQUE;

INSERT INTO committees (committee_name)
VALUES ('Swimming');
