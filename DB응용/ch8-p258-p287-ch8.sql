/* 08장 */

-- p258
USE cookDB;
SELECT * 
   FROM buyTBL
     INNER JOIN userTBL
        ON buyTBL.userID = userTBL.userID
   WHERE buyTBL.userID = 'KYM';
   /*
SELECT * 
   FROM buyTBL
     INNER JOIN userTBL
        ON buyTBL.userID = userTBL.userID ;
   */
SELECT userID, userName, prodName, addr, CONCAT(mobile1, mobile2) AS '연락처'
   FROM buyTBL
     INNER JOIN userTBL
        ON buyTBL.userID = userTBL.userID ; -- error: userID-ambiguous

SELECT buyTBL.userID, userName, prodName, addr, CONCAT(mobile1, mobile2) AS '연락처'
   FROM buyTBL
     INNER JOIN userTBL
        ON buyTBL.userID = userTBL.userID;
-- p260
SELECT buyTBL.userID, username, prodName, addr, CONCAT(mobile1, mobile2) 
  FROM buyTBL, userTBL
  WHERE buyTBL.userID = userTBL.userID ;

SELECT buyTBL.userID, userTBL.userName, buyTBL.prodName, userTBL.addr, 
         CONCAT(userTBL.mobile1,userTBL.mobile2)  AS '연락처'
   FROM buyTBL
     INNER JOIN userTBL
        ON buyTBL.userID = userTBL.userID;

SELECT B.userID, U.userName, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2)  AS '연락처'
   FROM buyTBL B
     INNER JOIN userTBL U
        ON B.userID = U.userID;

SELECT B.userID, U.userName, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2)  AS '연락처'
   FROM buyTBL B
     INNER JOIN userTBL U
        ON B.userID = U.userID
   WHERE B.userID = 'KYM';

SELECT U.userID, U.userName, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2)  AS '연락처'
   FROM userTBL U
     INNER JOIN buyTBL B
        ON U.userID = B.userID 
   WHERE B.userID = 'KYM';

SELECT U.userID, U.userName, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2)  AS '연락처'
   FROM userTBL U
     INNER JOIN buyTBL B
        ON U.userID = B.userID 
   ORDER BY U.userID;

-- p262
SELECT DISTINCT U.userID, U.userName,  U.addr
   FROM userTBL U
     INNER JOIN buyTBL B
        ON U.userID = B.userID 
   ORDER BY U.userID ;

SELECT U.userID, U.userName,  U.addr
   FROM userTBL U
   WHERE EXISTS (
      SELECT * 
      FROM buyTBL B
      WHERE U.userID = B.userID );


-- <실습> 
-- p264
USE cookDB;
CREATE TABLE stdTBL 
( stdName    VARCHAR(10) NOT NULL PRIMARY KEY,
  addr	  CHAR(4) NOT NULL
);
CREATE TABLE clubTBL 
( clubName    VARCHAR(10) NOT NULL PRIMARY KEY,
  roomNo    CHAR(4) NOT NULL
);
CREATE TABLE stdclubTBL
(  num int AUTO_INCREMENT NOT NULL PRIMARY KEY, 
   stdName    VARCHAR(10) NOT NULL,
   clubName    VARCHAR(10) NOT NULL,
FOREIGN KEY(stdName) REFERENCES stdTBL(stdName),
FOREIGN KEY(clubName) REFERENCES clubTBL(clubName)
);
INSERT INTO stdTBL VALUES ('강호동','경북'), ('김제동','경남'), ('김용만','서울'), ('이휘재','경기'),('박수홍','서울');
INSERT INTO clubTBL VALUES ('수영','101호'), ('바둑','102호'), ('축구','103호'), ('봉사','104호');
INSERT INTO stdclubTBL VALUES (NULL, '강호동','바둑'), (NULL,'강호동','축구'), (NULL,'김용만','축구'), (NULL,'이휘재','축구'), (NULL,'이휘재','봉사'), (NULL,'박수홍','봉사');

SELECT S.stdName, S.addr, C.clubName, C.roomNo
   FROM stdTBL S 
      INNER JOIN stdclubTBL SC
           ON S.stdName = SC.stdName
      INNER JOIN clubTBL C
	  ON SC.clubName = C.clubName 
   ORDER BY S.stdName;
   
-- SELECT *
--    FROM stdTBL S 
--       INNER JOIN stdclubTBL SC
--            ON S.stdName = SC.stdName
--       INNER JOIN clubTBL C
-- 	  ON SC.clubName = C.clubName ;
   
SELECT C.clubName, C.roomNo, S.stdName, S.addr
   FROM  stdTBL S
      INNER JOIN stdclubTBL SC
           ON SC.stdName = S.stdName
      INNER JOIN clubTBL C
	 ON SC.clubName = C.clubName
    ORDER BY C.clubName;

-- </실습> 

-- p266
USE cookDB;
SELECT U.userID, U.userName, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2)  AS '연락처'
   FROM userTBL U
      LEFT OUTER JOIN buyTBL B
         ON U.userID = B.userID 
   ORDER BY U.userID;
   
-- SELECT U.userID, U.userName, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2)  AS '연락처'
--    FROM userTBL U
--       JOIN buyTBL B
--          ON U.userID = B.userID 
--    ORDER BY U.userID;
   
-- p267   
SELECT U.userID, U.userName, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2)  AS '연락처'
   FROM buyTBL B 
      RIGHT OUTER JOIN userTBL U
         ON U.userID = B.userID 
   ORDER BY U.userID;

SELECT U.userID, U.userName, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2)  AS '연락처'
   FROM userTBL U
      LEFT OUTER JOIN buyTBL B
         ON U.userID = B.userID 
   WHERE B.prodName IS NULL
   ORDER BY U.userID;


-- <실습> LEFT/RIGHT OUTER JOIN을 실습하자.
-- p268
USE cookDB;
SELECT S.stdName, S.addr, C.clubName, C.roomNo
   FROM stdTBL S 
      LEFT OUTER JOIN stdclubTBL SC
          ON S.stdName = SC.stdName
      LEFT OUTER JOIN clubTBL C
          ON SC.clubName = C.clubName
   ORDER BY S.stdName;

SELECT C.clubName, C.roomNo, S.stdName, S.addr
   FROM  stdTBL S
      LEFT OUTER JOIN stdclubTBL SC
          ON SC.stdName = S.stdName
      RIGHT OUTER JOIN clubTBL C
          ON SC.clubName = C.clubName
   ORDER BY C.clubName ;

-- p269
SELECT S.stdName, S.addr, C.clubName, C.roomNo
   FROM stdTBL S 
      LEFT OUTER JOIN stdclubTBL SC
          ON S.stdName = SC.stdName
      LEFT OUTER JOIN clubTBL C
          ON SC.clubName = C.clubName
UNION 
SELECT S.stdName, S.addr, C.clubName, C.roomNo
   FROM  stdTBL S
      LEFT OUTER JOIN stdclubTBL SC
          ON SC.stdName = S.stdName
      RIGHT OUTER JOIN clubTBL C
          ON SC.clubName = C.clubName;

-- </실습> 

USE cookDB;
SELECT * 
   FROM buyTBL 
     CROSS JOIN userTBL ;

SELECT * 
   FROM buyTBL , userTBL ;

USE employees;
SELECT  COUNT(*) AS '데이터개수'
   FROM employees 
     CROSS JOIN titles;

-- <실습> 하나의 테이블에서 SELF JOIN을 활용해 보자.
-- 272
USE cookDB;
CREATE TABLE empTBL (emp CHAR(3), manager CHAR(3), empTel VARCHAR(8));

INSERT INTO empTBL VALUES('나사장',NULL,'0000');
INSERT INTO empTBL VALUES('김재무','나사장','2222');
INSERT INTO empTBL VALUES('김부장','김재무','2222-1');
INSERT INTO empTBL VALUES('이부장','김재무','2222-2');
INSERT INTO empTBL VALUES('우대리','이부장','2222-2-1');
INSERT INTO empTBL VALUES('지사원','이부장','2222-2-2');
INSERT INTO empTBL VALUES('이영업','나사장','1111');
INSERT INTO empTBL VALUES('한과장','이영업','1111-1');
INSERT INTO empTBL VALUES('최정보','나사장','3333');
INSERT INTO empTBL VALUES('윤차장','최정보','3333-1');
INSERT INTO empTBL VALUES('이주임','윤차장','3333-1-1');

SELECT A.emp AS '부하직원' , B.emp AS '직속상관', B.empTel AS '직속상관연락처'
   FROM empTBL A
      INNER JOIN empTBL B
         ON A.manager = B.emp
   WHERE A.emp = '우대리';

-- </실습> 


USE cookDB;
SELECT stdName, addr FROM stdTBL
   UNION ALL
SELECT clubName, roomNo FROM clubTBL;

-- SELECT stdName, addr FROM stdTBL
--    UNION 
-- SELECT clubName, roomNo FROM clubTBL;

-- SELECT userName FROM userTBL WHERE mobile1 IS NULL ;
SELECT userName, CONCAT(mobile1, '-', mobile2) AS '전화번호' FROM userTBL
   WHERE userName NOT IN ( SELECT userName FROM userTBL WHERE mobile1 IS NULL) ;

-- SELECT userName FROM userTBL WHERE mobile1 IS NULL ;
SELECT userName, CONCAT(mobile1, mobile2) AS '전화번호' FROM userTBL
   WHERE userName IN ( SELECT userName FROM userTBL WHERE mobile1 IS NULL) ;


-- p277
DROP PROCEDURE IF EXISTS ifProc; -- 기존에 만든적이 있다면 삭제
DELIMITER $$ 
-- MySQL과 SQL 프로그램시 문장 종료시 사용하는 기호가 ;로 같음
-- SQL 프로그램을 위해 MySQL의 문장 종료기호를 임시로 $$로 변경하는 문장
CREATE PROCEDURE ifProc()
BEGIN
  DECLARE var1 INT;  -- var1 변수선언
  SET var1 = 100;  -- 변수에 값 대입

  IF var1 = 100 THEN  -- 만약 @var1이 100이라면,
	SELECT '100입니다.';
  ELSE
    SELECT '100이 아닙니다.';
  END IF;
END $$
DELIMITER ;
-- 원래의 MySQL의 문장 종료기호로 복귀
CALL ifProc();


-- p278
DROP PROCEDURE IF EXISTS ifProc2; 
USE employees;

DELIMITER $$
CREATE PROCEDURE ifProc2()
BEGIN
	DECLARE hireDATE DATE; -- 입사일
	DECLARE curDATE DATE; -- 오늘
	DECLARE days INT; -- 근무한 일수

	SELECT hire_date INTO hireDate -- hire_date 열의 결과를 hireDATE에 대입
	   FROM employees.employees
	   WHERE emp_no = 10001;

	SET curDATE = CURRENT_DATE(); -- 현재 날짜
	SET days =  DATEDIFF(curDATE, hireDATE); -- 날짜의 차이, 일 단위

	IF (days/365) >= 5 THEN -- 5년이 지났다면
		  SELECT CONCAT('입사한지 ', days, '일이나 지났습니다. 축하합니다!') AS '메시지';
	ELSE
		  SELECT '입사한지 ' + days + '일밖에 안되었네요. 열심히 일하세요.' AS '메시지';
	END IF;
END $$
DELIMITER ;
CALL ifProc2();


-- p279
DROP PROCEDURE IF EXISTS ifProc3; 
DELIMITER $$
CREATE PROCEDURE ifProc3()
BEGIN
    DECLARE point INT ;
    DECLARE credit CHAR(1);
    SET point = 77 ;
    
    IF point >= 90 THEN
		SET credit = 'A';
    ELSEIF point >= 80 THEN
		SET credit = 'B';
    ELSEIF point >= 70 THEN
		SET credit = 'C';
    ELSEIF point >= 60 THEN
		SET credit = 'D';
    ELSE
		SET credit = 'F';
    END IF;
    SELECT CONCAT('취득점수==>', point), CONCAT('학점==>', credit);
END $$
DELIMITER ;
CALL ifProc3();



DROP PROCEDURE IF EXISTS caseProc; 
DELIMITER $$
CREATE PROCEDURE caseProc()
BEGIN
    DECLARE point INT ;
    DECLARE credit CHAR(1);
    SET point = 77 ;
    
    CASE 
		WHEN point >= 90 THEN
			SET credit = 'A';
		WHEN point >= 80 THEN
			SET credit = 'B';
		WHEN point >= 70 THEN
			SET credit = 'C';
		WHEN point >= 60 THEN
			SET credit = 'D';
		ELSE
			SET credit = 'F';
    END CASE;
    SELECT CONCAT('취득점수==>', point), CONCAT('학점==>', credit);
END $$
DELIMITER ;
CALL caseProc();


-- <실습> CASE 문을 활용하는 SQL 프로그래밍을 작성하자. 
-- p280
-- initialize cookDB

USE cookDB;
SELECT userID, SUM(price*amount) AS '총구매액'
   FROM buyTBL
   GROUP BY userID
   ORDER BY SUM(price*amount) DESC;

SELECT B.userID, U.userName, SUM(price*amount) AS '총구매액'
   FROM buyTBL B
      INNER JOIN userTBL U
         ON B.userID = U.userID
   GROUP BY B.userID, U.userName
   ORDER BY SUM(price*amount) DESC;

SELECT B.userID, U.userName, SUM(price*amount) AS '총구매액'
   FROM buyTBL B
      RIGHT OUTER JOIN userTBL U
        ON B.userID = U.userID
   GROUP BY B.userID, U.userName
   ORDER BY SUM(price*amount) DESC ;

SELECT U.userID, U.userName, SUM(price*amount) AS '총구매액'
   FROM buyTBL B
      RIGHT OUTER JOIN userTBL U
         ON B.userID = U.userID
   GROUP BY U.userID, U.userName
   ORDER BY SUM(price*amount) DESC ;

SELECT U.userID, U.userName, SUM(price*amount) AS '총구매액',
       CASE  
           WHEN (SUM(price*amount)  >= 1500) THEN '최우수고객'
           WHEN (SUM(price*amount)  >= 1000) THEN '우수고객'
           WHEN (SUM(price*amount) >= 1 ) THEN '일반고객'
           ELSE '유령고객'
        END AS '고객등급'
   FROM buyTBL B
      RIGHT OUTER JOIN userTBL U
         ON B.userID = U.userID
   GROUP BY U.userID, U.userName 
   ORDER BY sum(price*amount) DESC ;

-- </실습> 


-- p284
DROP PROCEDURE IF EXISTS whileProc; 
DELIMITER $$
CREATE PROCEDURE whileProc()
BEGIN
	DECLARE i INT; -- 1에서 100까지 증가할 변수
	DECLARE hap INT; -- 더한 값을 누적할 변수
    SET i = 1;
    SET hap = 0;

	WHILE (i <= 100) DO
		SET hap = hap + i;  -- hap의 원래의 값에 i를 더해서 다시 hap에 넣으라는 의미
		SET i = i + 1;      -- i의 원래의 값에 1을 더해서 다시 i에 넣으라는 의미
	END WHILE;

	SELECT hap;   
END $$
DELIMITER ;
CALL whileProc();



DROP PROCEDURE IF EXISTS whileProc2; 
DELIMITER $$
CREATE PROCEDURE whileProc2()
BEGIN
    DECLARE i INT; -- 1에서 100까지 증가할 변수
    DECLARE hap INT; -- 더한 값을 누적할 변수
    SET i = 1;
    SET hap = 0;

    myWhile: WHILE (i <= 100) DO  -- While문에 label을 지정
	IF (i%7 = 0) THEN
		SET i = i + 1;     
		ITERATE myWhile; -- 지정한 label문으로 가서 계속 진행
	END IF;
        
        SET hap = hap + i; 
        IF (hap > 1000) THEN 
		LEAVE myWhile; -- 지정한 label문을 떠남. 즉, While 종료.
	END IF;
        SET i = i + 1;
    END WHILE;

    SELECT hap; 
--     SELECT i; 
END $$
DELIMITER ;
CALL whileProc2();


-- p286
DROP PROCEDURE IF EXISTS errorProc; 
DELIMITER $$
CREATE PROCEDURE errorProc()
BEGIN
    DECLARE CONTINUE HANDLER FOR 1146 SELECT '테이블이 없어요ㅠㅠ' AS '메시지';
    SELECT * FROM noTable;  -- error: noTable은 없음.  
END $$
DELIMITER ;
CALL errorProc();

-- DROP PROCEDURE IF EXISTS errorProc; 
-- DELIMITER $$
-- CREATE PROCEDURE errorProc()
-- BEGIN
--     DECLARE EXIT HANDLER FOR 1146 SELECT '테이블이 없어요ㅠㅠ' AS '메시지';
--     SELECT * FROM noTable;  -- error: noTable은 없음.  
-- END $$
-- DELIMITER ;
-- CALL errorProc();

DROP PROCEDURE IF EXISTS errorProc2; 
DELIMITER $$
CREATE PROCEDURE errorProc2()
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
    BEGIN
	SHOW ERRORS; -- 오류 메시지를 보여 준다.
	SELECT '오류가 발생했네요. 작업은 취소시켰습니다.' AS '메시지'; 
	ROLLBACK; -- 오류 발생시 작업을 롤백시킨다.
    END;
    INSERT INTO userTBL VALUES('YJS', '윤정수', 1988, '서울', NULL, 
		NULL, 170, CURRENT_DATE()); -- 중복되는 아이디이므로 오류 발생
END $$
DELIMITER ;
CALL errorProc2();


-- p287
use cookDB;
PREPARE myQuery FROM 'SELECT * FROM userTBL WHERE userID = "NHS"';
EXECUTE myQuery;
DEALLOCATE PREPARE myQuery;



USE cookDB;
DROP TABLE IF EXISTS myTable;
CREATE TABLE myTable (id INT AUTO_INCREMENT PRIMARY KEY, mDate DATETIME);

SET @curDATE = CURRENT_TIMESTAMP(); -- 현재 날짜와 시간

PREPARE myQuery FROM 'INSERT INTO myTable VALUES(NULL, ?)';
EXECUTE myQuery USING @curDATE;
DEALLOCATE PREPARE myQuery;

SELECT * FROM myTable;

