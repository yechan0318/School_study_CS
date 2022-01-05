/* 11장 */
-- p 383
USE cookDB;
DROP PROCEDURE IF EXISTS userProc;
DELIMITER $$
CREATE PROCEDURE userProc()
BEGIN
    SELECT * FROM userTBL; -- 스토어드 프로시저 내용
END $$
DELIMITER ;

CALL userProc();


-- <실습> 스토어드 프로시저를 실습하자. 
-- p385 cookDB 초기화, parameter가 있는 stored procedure
USE cookDB;
DROP PROCEDURE IF EXISTS userProc1;
DELIMITER $$
CREATE PROCEDURE userProc1(IN uName VARCHAR(10))
BEGIN
  SELECT * FROM userTBL WHERE userName= uName; 
END $$
DELIMITER ;

CALL userProc1('이경규');


DROP PROCEDURE IF EXISTS userProc2;
DELIMITER $$
CREATE PROCEDURE userProc2(
    IN userBirth INT, 
    IN userHeight INT
)
BEGIN
  SELECT * FROM userTBL 
    WHERE birthYear > userBirth AND height > userHeight;
END $$
DELIMITER ;

CALL userProc2(1970, 178);

-- p 386 output parameter
DROP PROCEDURE IF EXISTS userProc3;
DELIMITER $$
CREATE PROCEDURE userProc3(
    IN txtValue CHAR(10),
    OUT outValue INT
)
BEGIN
  INSERT INTO testTBL VALUES(NULL,txtValue);
  SELECT MAX(id) INTO outValue FROM testTBL; 
END $$
DELIMITER ;

CREATE TABLE IF NOT EXISTS testTBL(
    id INT AUTO_INCREMENT PRIMARY KEY, 
    txt CHAR(10)
);


CALL userProc3 ('테스트값', @myValue);
SELECT CONCAT('현재 입력된 ID 값 ==>', @myValue);

-- p387
DROP PROCEDURE IF EXISTS ifelseProc;
DELIMITER $$
CREATE PROCEDURE ifelseProc(
    IN uName VARCHAR(10)
)
BEGIN
    DECLARE bYear INT; -- 변수 선언
    SELECT birthYear into bYear FROM userTBL
        WHERE userName= uName;
    IF (bYear >= 1970) THEN
            SELECT '아직 젊군요..';
    ELSE
            SELECT '나이가 지긋하네요..';
    END IF;
END $$
DELIMITER ;

CALL ifelseProc ('김국진');


DROP PROCEDURE IF EXISTS caseProc;
DELIMITER $$
CREATE PROCEDURE caseProc(
    IN uName VARCHAR(10)
)
BEGIN
    DECLARE bYear INT; 
    DECLARE tti  CHAR(3);-- 띠
    SELECT birthYear INTO bYear FROM userTBL
        WHERE userName= uName;
    CASE 
        WHEN ( bYear%12 = 0) THEN    SET tti = '원숭이';
        WHEN ( bYear%12 = 1) THEN    SET tti = '닭';
        WHEN ( bYear%12 = 2) THEN    SET tti = '개';
        WHEN ( bYear%12 = 3) THEN    SET tti = '돼지';
        WHEN ( bYear%12 = 4) THEN    SET tti = '쥐';
        WHEN ( bYear%12 = 5) THEN    SET tti = '소';
        WHEN ( bYear%12 = 6) THEN    SET tti = '호랑이';
        WHEN ( bYear%12 = 7) THEN    SET tti = '토끼';
        WHEN ( bYear%12 = 8) THEN    SET tti = '용';
        WHEN ( bYear%12 = 9) THEN    SET tti = '뱀';
        WHEN ( bYear%12 = 10) THEN    SET tti = '말';
        ELSE SET tti = '양';
    END CASE;
    SELECT CONCAT(uName, '의 띠 ==>', tti);
END $$
DELIMITER ;

CALL caseProc ('박수홍');


DROP TABLE IF EXISTS guguTBL;
CREATE TABLE guguTBL (txt VARCHAR(100)); -- 구구단 저장용 테이블

DROP PROCEDURE IF EXISTS whileProc;
DELIMITER $$
CREATE PROCEDURE whileProc()
BEGIN
    DECLARE str VARCHAR(100); -- 각 단을 문자열로 저장
    DECLARE i INT; -- 구구단 앞자리
    DECLARE k INT; -- 구구단 뒷자리
    SET i = 2; -- 2단부터 계산
    
    WHILE (i < 10) DO  -- 바깥 반복문. 2단~9단까지.
        SET str = ''; -- 각 단의 결과를 저장할 문자열 초기화
        SET k = 1; -- 구구단 뒷자리는 항상 1부터 9까지.
        WHILE (k < 10) DO
            SET str = CONCAT(str, '  ', i, 'x', k, '=', i*k); -- 문자열 만들기
            SET k = k + 1; -- 뒷자리 증가
        END WHILE;
        SET i = i + 1; -- 앞자리 증가
        INSERT INTO guguTBL VALUES(str); -- 각 단의 결과를 테이블에 입력.
    END WHILE;
END $$
DELIMITER ;

CALL whileProc();
SELECT * FROM guguTBL;

-- p389
DROP PROCEDURE IF EXISTS errorProc;
DELIMITER $$
CREATE PROCEDURE errorProc()
BEGIN
    DECLARE i INT; -- 1씩 증가하는 값
    DECLARE hap INT; -- 합계 (정수형) 오버플로 발생시킬 예정
    DECLARE saveHap INT; -- 합계 (정수형) 오버플로 직전의 값을 저장

    DECLARE EXIT HANDLER FOR 1264 -- INT형 오버플로가 발생하면 이 부분 수행
    BEGIN
        SELECT CONCAT('INT 오버플로 직전의 합계 --> ', saveHap); -- 11
        SELECT CONCAT('1+2+3+4+...+',i ,'=오버플로'); -- 12
    END;
    
    SET i = 1; -- 1부터 증가
    SET hap = 0; -- 합계를 누적
    
    WHILE (TRUE) DO  -- 무한 루프.
        SET saveHap = hap; -- 오버플로 직전의 합계를 저장
        SET hap = hap + i;  -- 오버플로가 나면 11, 12행을 수행함
        SET i = i + 1; 
    END WHILE;
END $$
DELIMITER ;

CALL errorProc();

-- p390
SELECT routine_name, routine_definition FROM INFORMATION_SCHEMA.ROUTINES
    WHERE routine_schema = 'cookDB' AND routine_type = 'PROCEDURE';

SELECT ORDINAL_POSITION, PARAMETER_MODE, PARAMETER_NAME, DTD_IDENTIFIER
  FROM information_schema.parameters
  WHERE SPECIFIC_SCHEMA = 'cookdb' AND SPECIFIC_NAME='userProc3';

-- p391
SHOW CREATE PROCEDURE cookDB.whileProc;

DROP PROCEDURE IF EXISTS nameProc;
DELIMITER $$
CREATE PROCEDURE nameProc(
    IN tableName VARCHAR(20)
)
BEGIN
 SELECT * FROM tableName; -- error
END $$
DELIMITER ;

CALL nameProc('userTBL'); -- error

-- p392
DROP PROCEDURE IF EXISTS nameProc;
DELIMITER $$
CREATE PROCEDURE nameProc(
    IN tableName VARCHAR(20)
)
BEGIN
  SET @sqlQuery = CONCAT('SELECT * FROM ', tableName);
  PREPARE myQuery FROM @sqlQuery;
  EXECUTE myQuery;
  DEALLOCATE PREPARE myQuery;
END $$
DELIMITER ;

CALL nameProc ('userTBL');

-- </실습>

-- p393
DELIMITER $$
CREATE PROCEDURE delivProc(
    IN id VARCHAR(10)
)
BEGIN
 SELECT userID, userName, addr , mobile1, mobile2 
	FROM userTBL
	WHERE userID = id;
END $$
DELIMITER ;

CALL delivProc ('LHJ');



-- p395 stored function
SET GLOBAL log_bin_trust_function_creators = 1;

USE cookDB;
DROP FUNCTION IF EXISTS userFunc;
DELIMITER $$
CREATE FUNCTION userFunc(value1 INT, value2 INT)
    RETURNS INT
BEGIN
    RETURN value1 + value2;
END $$
DELIMITER ;

SELECT userFunc(100, 200);


-- <실습> 스토어드 함수를 사용해 보자.
-- p397 cookDB 초기화
USE cookDB;
DROP FUNCTION IF EXISTS getAgeFunc;
DELIMITER $$
CREATE FUNCTION getAgeFunc(bYear INT)
    RETURNS INT
BEGIN
    DECLARE age INT;
    SET age = YEAR(CURDATE()) - bYear;
    RETURN age;
END $$
DELIMITER ;

SELECT getAgeFunc(1979);

SELECT getAgeFunc(1979) INTO @age1979;
SELECT getAgeFunc(1997) INTO @age1997;
SELECT CONCAT('1997년과 1979년의 나이차 ==> ', (@age1979-@age1997));

SELECT userID, userName, getAgeFunc(birthYear) AS '만 나이' FROM userTBL;

SHOW CREATE FUNCTION getAgeFunc;

DROP FUNCTION getAgeFunc;


-- <실습> 커서를 활용해 보자. 
-- p400
DROP PROCEDURE IF EXISTS cursorProc;
DELIMITER $$
CREATE PROCEDURE cursorProc()
BEGIN
    DECLARE userHeight INT; -- 고객의 키
    DECLARE cnt INT DEFAULT 0; -- 고객의 인원 수(=읽은 행의 수)
    DECLARE totalHeight INT DEFAULT 0; -- 키의 합계
    
    DECLARE endOfRow BOOLEAN DEFAULT FALSE; -- 행의 끝 여부(기본을 FALSE)
    DECLARE userCuror CURSOR FOR-- 커서 선언
        SELECT height FROM userTBL;

    DECLARE CONTINUE HANDLER -- 행의 끝이면 endOfRow 변수에 TRUE를 대입 
        FOR NOT FOUND SET endOfRow = TRUE;

    OPEN userCuror;  -- 커서 열기

    cursor_loop: LOOP
        FETCH  userCuror INTO userHeight; -- 고객 키 1개를 대입

        IF endOfRow THEN -- 더이상 읽을 행이 없으면 Loop를 종료
            LEAVE cursor_loop;
        END IF;

        SET cnt = cnt + 1;
        SET totalHeight = totalHeight + userHeight;        
    END LOOP cursor_loop;
    
    SELECT CONCAT('고객 키의 평균 ==> ', (totalHeight/cnt)); -- 고객 키의 평균을 출력한다.
    
    CLOSE userCuror;  -- 커서 닫기
END $$
DELIMITER ;

CALL cursorProc();

-- p402
USE cookDB;
ALTER TABLE userTBL ADD grade VARCHAR(5);  -- 고객 등급 열 추가

DROP PROCEDURE IF EXISTS gradeProc;
DELIMITER $$
CREATE PROCEDURE gradeProc()
BEGIN
    DECLARE id VARCHAR(10); -- 사용자 아이디를 저장할 변수
    DECLARE hap BIGINT; -- 총 구매액을 저장할 변수
    DECLARE userGrade CHAR(5); -- 고객 등급 변수

    DECLARE endOfRow BOOLEAN DEFAULT FALSE; 

    DECLARE userCuror CURSOR FOR-- 커서 선언
        SELECT U.userid, sum(price*amount)
            FROM buyTBL B
                RIGHT OUTER JOIN userTBL U
                ON B.userid = U.userid
            GROUP BY U.userid, U.userName ;

    DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET endOfRow = TRUE;

    OPEN userCuror;  -- 커서 열기
    grade_loop: LOOP
        FETCH  userCuror INTO id, hap; -- 첫 행 값을 대입
        IF endOfRow THEN
            LEAVE grade_loop;
        END IF;

        CASE  
            WHEN (hap >= 1500) THEN SET userGrade = '최우수고객';
            WHEN (hap  >= 1000) THEN SET userGrade ='우수고객';
            WHEN (hap >= 1) THEN SET userGrade ='일반고객';
            ELSE SET userGrade ='유령고객';
         END CASE;
        
        UPDATE userTBL SET grade = userGrade WHERE userID = id;
    END LOOP grade_loop;
    
    CLOSE userCuror;  -- 커서 닫기
END $$
DELIMITER ;


CALL gradeProc();
SELECT * FROM userTBL;

-- <실습> 간단한 트리거를 생성하고 결과를 확인해 보자.
-- p404
USE cookDB;
DROP TABLE IF EXISTS testTBL;
CREATE TABLE IF NOT EXISTS testTBL (id INT, txt VARCHAR(10));
INSERT INTO testTBL VALUES(1, '이엑스아이디');
INSERT INTO testTBL VALUES(2, '블랙핑크');
INSERT INTO testTBL VALUES(3, '에이핑크'); 
SELECT * FROM testTBL;

DROP TRIGGER IF EXISTS testTrg;
DELIMITER // 
CREATE TRIGGER testTrg  -- 트리거 이름
    AFTER  DELETE -- 삭제후에 작동하도록 지정
    ON testTBL -- 트리거를 부착할 테이블
    FOR EACH ROW -- 각 행마다 적용시킴
BEGIN
	SET @msg = '가수 그룹이 삭제됨' ; -- 트리거 실행시 작동되는 코드들
END // 
DELIMITER ;


SET @msg = '';
INSERT INTO testTBL VALUES(4, '여자친구');
SELECT @msg;
UPDATE testTBL SET txt = '레드벨벳' WHERE id = 3;
SELECT @msg;
DELETE FROM testTBL WHERE id = 4;
SELECT @msg;


-- <실습> 회원 테이블에 update나 insert를 시도하면, 
-- 수정 또는 삭제된 데이터를 별도의 테이블에 보관하고 
-- 변경된 일자와 변경한 사람을 기록해 놓자.
-- p407
USE cookDB;
DROP TABLE buyTBL; -- 구매테이블은 실습에 필요없으므로 삭제.
CREATE TABLE backup_userTBL
( userID  char(8) NOT NULL, 
  userName   varchar(10) NOT NULL, 
  birthYear   int NOT NULL,  
  addr	  char(2) NOT NULL, 
  mobile1	char(3), 
  mobile2   char(8), 
  height    smallint,  
  mDate    date,
  modType  char(2), -- 변경된 타입. '수정' 또는 '삭제'
  modDate  date, -- 변경된 날짜
  modUser  varchar(256) -- 변경한 사용자
);

DROP TRIGGER IF EXISTS backUserTBL_UpdateTrg;
DELIMITER // 
CREATE TRIGGER backUserTBL_UpdateTrg  -- 트리거 이름
    AFTER UPDATE -- 변경 후에 작동하도록 지정
    ON userTBL -- 트리거를 부착할 테이블
    FOR EACH ROW 
BEGIN
    INSERT INTO backup_userTBL VALUES( OLD.userID, OLD.userName, OLD.birthYear, 
        OLD.addr, OLD.mobile1, OLD.mobile2, OLD.height, OLD.mDate, 
        '수정', CURDATE(), CURRENT_USER() );
END // 
DELIMITER ;

DROP TRIGGER IF EXISTS backUserTBL_DeleteTrg;
DELIMITER // 
CREATE TRIGGER backUserTBL_DeleteTrg  -- 트리거 이름
    AFTER DELETE -- 삭제 후에 작동하도록 지정
    ON userTBL -- 트리거를 부착할 테이블
    FOR EACH ROW 
BEGIN
    INSERT INTO backup_userTBL VALUES( OLD.userID, OLD.userName, OLD.birthYear, 
        OLD.addr, OLD.mobile1, OLD.mobile2, OLD.height, OLD.mDate, 
        '삭제', CURDATE(), CURRENT_USER() );
END // 
DELIMITER ;

UPDATE userTBL SET addr = '제주' WHERE userID = 'KJD';
DELETE FROM userTBL WHERE height >= 180;

SELECT * FROM backup_userTBL;

-- TRUNCATE TABLE userTBL;

SELECT * FROM backup_userTBL;

-- p409
DROP TRIGGER IF EXISTS userTBL_InsertTrg;
DELIMITER // 
CREATE TRIGGER userTBL_InsertTrg  -- 트리거 이름
    AFTER INSERT -- 입력 후에 작동하도록 지정
    ON userTBL -- 트리거를 부착할 테이블
    FOR EACH ROW 
BEGIN
    SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = '데이터의 입력을 시도했습니다. 귀하의 정보가 서버에 기록되었습니다.';
END // 
DELIMITER ;

INSERT INTO userTBL VALUES('ABC', '에비씨', 1977, '서울', '011', '1111111', 181, '2019-12-25');


-- <실습> BEFORE 트리거를 실습하자. 
-- p411
USE cookDB;
DROP TRIGGER IF EXISTS userTBL_InsertTrg; -- 앞 실습의 트리거 제거
DROP TRIGGER IF EXISTS userTBL_BeforeInsertTrg;
DELIMITER // 
CREATE TRIGGER userTBL_BeforeInsertTrg  -- 트리거 이름
    BEFORE INSERT -- 입력 전에 작동하도록 지정
    ON userTBL -- 트리거를 부착할 테이블
    FOR EACH ROW 
BEGIN
    IF NEW.birthYear < 1900 THEN
        SET NEW.birthYear = 0;
    ELSEIF NEW.birthYear > YEAR(CURDATE()) THEN
        SET NEW.birthYear = YEAR(CURDATE());
    END IF;
END // 
DELIMITER ;

INSERT INTO userTBL VALUES
  ('AAA', '에이', 1877, '서울', '011', '11112222', 181, '2019-12-25');
SELECT * FROM userTBL;
INSERT INTO userTBL VALUES
  ('BBB', '비이', 2977, '경기', '011', '11113333', 171, '2011-3-25');

SHOW TRIGGERS FROM cookDB;
-- DROP TRIGGER 트리거이름


-- <실습> 중첩 트리거의 작동을 실습해 보자. 
-- p413
USE mysql;
DROP DATABASE IF EXISTS triggerDB;
CREATE DATABASE IF NOT EXISTS triggerDB;


USE triggerDB;
CREATE TABLE orderTBL -- 구매 테이블
	(orderNo INT AUTO_INCREMENT PRIMARY KEY, -- 구매 일련번호
        userID VARCHAR(5), -- 구매한 회원아이0디
        prodName VARCHAR(5), -- 구매한 물건
        orderamount INT );  -- 구매한 개수
CREATE TABLE prodTBL -- 물품 테이블
       ( prodName VARCHAR(5), -- 물건 이름
        account INT ); -- 남은 물건수량
CREATE TABLE deliverTBL -- 배송 테이블
       ( deliverNo  INT AUTO_INCREMENT PRIMARY KEY, -- 배송 일련번호
        prodName VARCHAR(5), -- 배송할 물건		  
        account INT UNIQUE); -- 배송할 물건개수


INSERT INTO prodTBL VALUES('사과', 100);
INSERT INTO prodTBL VALUES('배', 100);
INSERT INTO prodTBL VALUES('귤', 100);


-- 물품 테이블에서 개수를 감소시키는 트리거
DROP TRIGGER IF EXISTS orderTrg;
DELIMITER // 
CREATE TRIGGER orderTrg  -- 트리거 이름
    AFTER  INSERT 
    ON orderTBL -- 트리거를 부착할 테이블
    FOR EACH ROW 
BEGIN
    UPDATE prodTBL SET account = account - NEW.orderamount 
        WHERE prodName = NEW.prodName ;
END // 
DELIMITER ;

-- 배송테이블에 새 배송 건을 입력하는 트리거
DROP TRIGGER IF EXISTS prodTrg;
DELIMITER // 
CREATE TRIGGER prodTrg  -- 트리거 이름
    AFTER  UPDATE 
    ON prodTBL -- 트리거를 부착할 테이블
    FOR EACH ROW 
BEGIN
    DECLARE orderAmount INT;
    -- 주문 개수 = (변경 전의 개수 - 변경 후의 개수)
    SET orderAmount = OLD.account - NEW.account;
    INSERT INTO deliverTBL(prodName, account)
        VALUES(NEW.prodName, orderAmount);
END // 
DELIMITER ;

INSERT INTO orderTBL VALUES (NULL,'JOHN', '배', 5);

SELECT * FROM orderTBL;
SELECT * FROM prodTBL;
SELECT * FROM deliverTBL;

ALTER TABLE deliverTBL CHANGE prodName productName VARCHAR(5);

INSERT INTO orderTBL VALUES (NULL, 'DANG', '사과', 9); -- error

SELECT * FROM orderTBL;
SELECT * FROM prodTBL;
SELECT * FROM deliverTBL;

-- </실습>
