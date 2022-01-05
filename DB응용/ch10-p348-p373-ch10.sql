/* 10장 */

-- p348
CREATE TABLE userTBL 
( userID  CHAR(8) NOT NULL PRIMARY KEY, 
  userName    VARCHAR(10) NOT NULL, 
  birthYear   INT NOT NULL,  
  addr	  CHAR(2) NOT NULL,
  mobile1	CHAR(3) NULL, 
  mobile2   CHAR(8) NULL, 
  height    SMALLINT NULL, 
  mDate    DATE NULL 
);

-- <실습> 제약조건으로 자동 생성되는 인덱스를 확인해 보자.
-- p349
USE cookDB;
CREATE TABLE  TBL1
	(	a INT PRIMARY KEY,
		b INT,
		c INT
	);

SHOW INDEX FROM TBL1;
-- Table: tbl1; 
-- Non_unique:0->unique하다(고유 인덱스:unique index), 1->unique하지 않다(비고유 인덱스; 단순 인덱스)
-- Key_name: PRIMARY-> primary key=clustered index
-- Seq_in_index: 해당 열에 여러 개의 index가 설정되었을 때 순서
-- Column_name: primary key로 설정된 열의 이름
-- Collation: 문자의 정렬 방법
-- Cardinality: 데이터의 갯수
-- NULL: NULL의 허용 여부-비어있으면 no
-- Index_type: index의 구조

CREATE TABLE  TBL2
	(	a INT PRIMARY KEY,
		b INT UNIQUE,
		c INT UNIQUE,
		d INT
	);
SHOW INDEX FROM TBL2;

CREATE TABLE  TBL3
	(	a INT UNIQUE,
		b INT UNIQUE,
		c INT UNIQUE,
		d INT
	);
SHOW INDEX FROM TBL3;

CREATE TABLE  TBL4
	(	a INT UNIQUE NOT NULL, -- clutered index
		b INT UNIQUE ,
		c INT UNIQUE,
		d INT
	);
SHOW INDEX FROM TBL4;

CREATE TABLE  TBL5
	(	a INT UNIQUE NOT NULL, -- secondary index
		b INT UNIQUE ,
		c INT UNIQUE,
		d INT PRIMARY KEY -- clustered index
	);
SHOW INDEX FROM TBL5;

-- p352
-- CREATE DATABASE IF NOT EXISTS testDB;
-- USE testDB;
-- DROP TABLE IF EXISTS userTBL;
-- CREATE TABLE userTBL 
-- ( userID  char(8) NOT NULL , -- primary key 미지정
--   userName    varchar(10) NOT NULL,
--   birthYear   int NOT NULL,
--   addr	  char(2) NOT NULL 
--  );

-- INSERT INTO userTBL VALUES('YJS', '유재석', 1972, '서울');
-- INSERT INTO userTBL VALUES('KHD', '강호동', 1970, '경북');
-- INSERT INTO userTBL VALUES('KKJ', '김국진', 1965, '서울');
-- INSERT INTO userTBL VALUES('KYM', '김용만', 1967, '서울');
-- INSERT INTO userTBL VALUES('KJD', '김제동', 1974, '경남');
-- SELECT * FROM userTBL; -- 데이터가 입력된 순서로 출력

-- p352
CREATE DATABASE IF NOT EXISTS testDB;
USE testDB;
DROP TABLE IF EXISTS userTBL;
CREATE TABLE userTBL 
( userID  char(8) NOT NULL PRIMARY KEY, 
  userName    varchar(10) NOT NULL,
  birthYear   int NOT NULL,
  addr	  char(2) NOT NULL 
 );

INSERT INTO userTBL VALUES('YJS', '유재석', 1972, '서울');
INSERT INTO userTBL VALUES('KHD', '강호동', 1970, '경북');
INSERT INTO userTBL VALUES('KKJ', '김국진', 1965, '서울');
INSERT INTO userTBL VALUES('KYM', '김용만', 1967, '서울');
INSERT INTO userTBL VALUES('KJD', '김제동', 1974, '경남');
SELECT * FROM userTBL;-- primary key로 설정된 userID의 순서로 정렬된 결과로 출력

ALTER TABLE userTBL DROP PRIMARY KEY ;
ALTER TABLE userTBL 
	ADD CONSTRAINT pk_userName PRIMARY KEY(userName);
SELECT * FROM userTBL; 

-- p359 clustered index
CREATE DATABASE IF NOT EXISTS testDB;
USE testDB;
DROP TABLE IF EXISTS clusterTBL;
CREATE TABLE clusterTBL
( userID  char(8) ,
  userName    varchar(10) 
);
INSERT INTO clusterTBL VALUES('YJS', '유재석');
INSERT INTO clusterTBL VALUES('KHD', '강호동');
INSERT INTO clusterTBL VALUES('KKJ', '김국진');
INSERT INTO clusterTBL VALUES('KYM', '김용만');
INSERT INTO clusterTBL VALUES('KJD', '김제동');
INSERT INTO clusterTBL VALUES('NHS', '남희석');
INSERT INTO clusterTBL VALUES('SDY', '신동엽');
INSERT INTO clusterTBL VALUES('LHJ', '이휘재');
INSERT INTO clusterTBL VALUES('LKK', '이경규');
INSERT INTO clusterTBL VALUES('PSH', '박수홍');
SELECT * from clusterTBL;

-- p360 여기서 잠깐만
SHOW VARIABLES LIKE 'innodb_page_size' ; -- 16k
-- innodb: 1) MySQL DB engine(DBMS에서 CRUD를 해주는 SW component)
--         2) version 5.5이전에 사용한 MyISAM에 비해 transaction 지원
--            foreign key 지원(=선언적 참조 무결성)
-- 단일 트랜잭션은 데이터베이스 내에 읽거나 쓰는 여러 개 쿼리를 요구한다 
-- 이때 중요한 것은 데이터베이스가 수행된 일부 쿼리가 남지 않는 것이다. 
-- 예를 들면, 송금을 할 때 한 계좌에서 인출되면 다른 계좌에서 입금이 확인되는 것이 중요하다. 
-- 또한 트랜잭션은 서로 간섭하지 않아야 한다. 트랜잭션의 특성에 대해 더 많은 정보를 보려면, ACID를 참조.
-- 각각의 트랜잭션에 대해 원자성(Atomicity), 일관성(Consistency), 독립성(Isolation), 영구성(Durability)을 보장

SELECT * FROM clusterTBL; -- 입력된 순서로 출력

ALTER TABLE clusterTBL
	ADD CONSTRAINT PK_clusterTBL_userID
		PRIMARY KEY (userID);

SELECT * FROM clusterTBL; -- primary key userID를 기준으로 정렬되어 출력

-- 362 secondary index
CREATE DATABASE IF NOT EXISTS testDB;
USE testDB;
DROP TABLE IF EXISTS secondaryTBL;
CREATE TABLE secondaryTBL
( userID  char(8),
  userName    varchar(10)
);
INSERT INTO secondaryTBL VALUES('YJS', '유재석');
INSERT INTO secondaryTBL VALUES('KHD', '강호동');
INSERT INTO secondaryTBL VALUES('KKJ', '김국진');
INSERT INTO secondaryTBL VALUES('KYM', '김용만');
INSERT INTO secondaryTBL VALUES('KJD', '김제동');
INSERT INTO secondaryTBL VALUES('NHS', '남희석');
INSERT INTO secondaryTBL VALUES('SDY', '신동엽');
INSERT INTO secondaryTBL VALUES('LHJ', '이휘재');
INSERT INTO secondaryTBL VALUES('LKK', '이경규');
INSERT INTO secondaryTBL VALUES('PSH', '박수홍');
SELECT * FROM secondaryTBL;

ALTER TABLE secondaryTBL
	ADD CONSTRAINT UK_secondaryTBL_userID
		UNIQUE (userID); -- secondary index 선언

SELECT * FROM secondaryTBL; -- 입력한 순서가 변하지 않음

-- p364
INSERT INTO clusterTBL VALUES('KKK', '크크크');
INSERT INTO clusterTBL VALUES('MMM', '마마무');
-- 정렬되어서 출력
SELECT * FROM clusterTBL;

-- p365
INSERT INTO secondaryTBL VALUES('KKK', '크크크');
INSERT INTO secondaryTBL VALUES('MMM', '마마무');
-- 입력한 순서로 출력
SELECT * FROM secondaryTBL;

-- <실습> 인덱스를 생성하고 사용하는 실습을 하자.
-- p369 cookDB 초기화
USE cookDB;
SELECT * FROM userTBL;

SHOW INDEX FROM userTBL; -- clustered index 생성됨
-- p370
CREATE INDEX idx_userTBL_addr ON userTBL (addr); -- 단순 보조 인덱스 생성(non-unique secondary index)
                                                 -- unique 옵션이 설정된 인덱스가 아님  
SHOW INDEX FROM userTBL; 

CREATE UNIQUE INDEX idx_userTBL_birtyYear
	ON userTBL (birthYear); -- error: duplicatin entry-unique index를 생성하려해서 오류

CREATE UNIQUE INDEX idx_userTBL_userName
	ON userTBL (userName); -- 고유보조 인덱스 생성(unique secondary index)

SHOW INDEX FROM userTBL;
-- p371
INSERT INTO userTBL VALUES('GHD', '강호동', 1988, '미국', NULL  , NULL  , 172, NULL);
-- errpr: duplication entry: 강호동

CREATE INDEX idx_userTBL_userName_birthYear
	ON userTBL (userName,birthYear);
DROP INDEX idx_userTBL_userName ON userTBL;
SHOW INDEX FROM userTBL;

SELECT * FROM userTBL WHERE userName = '신동엽' and birthYear = '1971';
-- INDEX idx_userTBL_userName_birthYear는 유용하지만 자주사용하지 않으면 MySQL의 성능에 나쁜 영향을 줌

SELECT * FROM userTBL WHERE userName = '신동엽';

CREATE INDEX idx_userTBL_mobile1
	ON userTBL (mobile1);
-- bad selectivity index    
SELECT * FROM userTBL WHERE mobile1 = '011';

-- index 삭제하기: secondary index 먼저 삭제
SHOW INDEX FROM userTBL ;

DROP INDEX idx_userTBL_addr ON userTBL;
DROP INDEX idx_userTBL_userName_birthYear ON userTBL;
DROP INDEX idx_userTBL_mobile1 ON userTBL;
-- p373 여기서 잠깐만
ALTER TABLE userTBL DROP INDEX idx_userTBL_addr;
ALTER TABLE userTBL DROP INDEX idx_userTBL_userName_birthYear;
ALTER TABLE userTBL DROP INDEX idx_userTBL_mobile1;

-- DROP INDEX pk_primary_key_userTBL ON userTBL; -- DROP으로는 primary key 삭제가 안됨: ALTER사용
ALTER TABLE userTBL DROP PRIMARY KEY; -- error
-- p373 1553 error시 여기서 잠깐만
SELECT table_userName, constraint_userName
    FROM information_schema.referential_constraints
    WHERE constraint_schema = 'cookDB';
ALTER TABLE buyTbl DROP FOREIGN KEY 제약조건이름;

