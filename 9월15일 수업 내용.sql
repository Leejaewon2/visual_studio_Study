-- 문자 함수 --
SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
FROM EMP;

SELECT *
FROM EMP
WHERE UPPER(ENAME) = UPPER("james")

-- LENGTH : 문자열 길이를 반환
-- LENGTHB : 문자열의 바이트 수 반환
SELECT LENGTH("한글"), LENGTH("한글")
FROM DUAL;

-- SUBSTR / SUBTRB
-- 데이터베이스 시작위치가 0이 아님
-- 2번째 매개변수는 길이
-- 3번째 매개변수를 생각하면 끝까지
SELECT JOB, SUBSTR(JOB, 1, 2), SUBSTR(JOB, 3, 2), SUBSTR(JOB, 5)
FROM EMP;

SELECT JOB,
    SUBSTR(JOB, -LENGTH(JOB)), -- 음수는 뒤에서 계산, 길이에 대한 음수값으로 역순 접근
    SUBSTR(JOB, -LENGTH(JOB),2), -- SALESMAN, -8이면 S위치에서 길이가 2만큼 출력
    SUBSTR(JOB, -3)
FROM EMP;


-- INSET : 문자열 데이터 안에 특정 문자나 문자열이 어디에 포함되어 있는지 알고자 할 때 사용SELECT INSTR('HELLO, ORACLE!', 'L') AS INSTR_1,
    INSTR('HELLO, ORACLE!', 'L', 5) AS INSTR_2, -- 3번째 인자로 찾을 시작위치 지정
    INSTR('HELLO, ORACLE!', 'L', 2, 2) AS INSTR_2 -- 3번째 인자는 시작위치, 4번째 인자는 몇번째 인지
FROM DUAL;

-- 특정 문자가 포함된 행 찾기
SELECT *
FROM EMP
WHERE INSTR(ENAME, 'S') > 0;

SELECT *
FROM EMP
WHERE ENAME LIKE '%S%';

-- REPLACE : 특정 문자열 데이터에 포함된 문자를 다른 문자로 대체 할 경우 사용
-- 대체할 문자를 넣지 않으면 해당 문자 삭제
SELECT '010-1234-5678' AS REPLACE_BEFORE,
    REPLACE('010-1234-5678', '-', ' ') AS REPLACE_1, -- 공백으로 대체
    REPLACE('010-1234-5678', '-') AS REPLACE_2       -- 해당 문자 삭제
FROM DUAL

-- LPAD / RPAD : 기준 공간의 칸 수를 특정 문자로 채우는 함수
SELECT LPAD('ORACLE', 10, '+')
FROM DUAL;
SELECT RPAD('ORACLE', 10, '+')
FROM DUAL;

SELECT 'ORCLE',
   LPAD('ORACLE', 10, '#') AS LPAD_1,
   RPAD('ORACLE', 10, '*') AS RPAD_1,
   LPAD('ORACLE', 10) AS LPAD_1,
   RPAD('ORACLE', 10) AS RPAD_1FROM DUAL

-- 개인정보 뒷자리 *표시로 출력하기
SELECT
    RPAD('971225-', 14, '*') AS RPAD_JMNO,
    RPAD('010-1234-', 13, '*') AS RPAD_PHONE
FROM DUAL;

-- 두 문자열을 합치는 CONCAT 함수
SELECT CONCAT(EMPNO, ENAME),
    CONCAT(EMPNO, CONCAT(' : ', ENAME))
FROM EMP
WHERE ENAME = 'JAMES';

-- TRIM / LTRIM / RTRIM : 문자열 내에서 특정 문자열을 지우기 위해 사용
SELECT '[' || TRIM(' _Oracle_ ') || ']' AS TRIM,
 '[' || LTRIM(' _Oracle_ ') || ']' AS LTRIM,
 '[' || LTRIM('<_Oracle_>', '<_') || ']' AS LTRIM_2,
 '[' || RTRIM(' _Oracle_ ') || ']' AS RTRIM,
 '[' || RTRIM('<_Oracle_>', '_>') || ']' AS RTRIM_2
 FROM DUAL;

 SELECT RTRIM('                      FDSJNBASDNFLKSDA             ')
 FROM DUAL;

 -- 날짜 데이터를 다루는 날짜 함수
 -- SYSDATE : 운영체제의 현재 날짜와 시간을 정보로 가져 옴
 SELECT SYSDATE FROM DUAL;

-- 날짜 데이터는 정수값으로 +, -가능
 SELECT SYSDATE AS 오늘,
    SYSDATE-1 AS 어제,
    SYSDATE+1 AS 내일
FROM DUAL;

-- 몇 개월 이후 날짜 구하는 ADD_MONTH 함수
-- 특정 날짜에 지정한 개월 수 이후의 날짜 데이터를 반환하는 함수
SELECT SYSDATE,
    ADD_MONTHS(SYSDATE, 3) -- 두번째 인자는 달수를 의미

-- EMP TABLE에서 입사 10주년이 되는 사원들 데이터 출력
SELECT EMPNO, ENAME, HIREDATE,
    ADD_MONTHS(HIREDATE, 120) AS 입사10주년
FROM EMP;
    
-- SYSDATE와 ADD_MONTHS 함수를 사용하여 현재 날짜와 6개월 후 날짜가 출력
SELECT SYSDATE,
    ADD_MONTHS(SYSDATE, 6)
FROM DUAL;
    
-- 두 날짜 간의 개월 수 차이를 구하는 MONTHS_BETWEEN 함수
SELECT EMPNO, ENAME, HIREDATE, SYSDATE,
    MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTHS1,
    MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTHS2,
    TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTHS3,
    ROUND(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTHS4
FROM EMP;

-- 날짜 정보 추출 함수
-- EXTRACT 함수는 날짜 유형의 데이터로 부터 날짜 정보를 분리하여 새로운 컬럼의 형태로 추출
SELECT EXTRACT(YEAR FROM DATE '2023-09-15') AS 년도추출
FROM DUAL;

SELECT *
FROM EMP
WHERE EXTRACT(MONTH FROM HIREDATE) == 12;

-----------------------------연습문제----------------------------
-- 오늘 날짜에 대한 정보 조회**
SELECT SYSDATE AS 오늘
FROM DUAL;

-- EMP테이블에서 사번, 사원명, 급여 조회  (단, 급여는 100단위까지의 값만 출력 처리하고 급여 기준 내림차순 정렬)**
SELECT EMPNO, ENAME, FLOOR(SAL / 100) * 100
FROM EMP
ORDER BY SAL DESC;
-- EMP테이블에서 사원번호가 홀수인 사원들을 조회**
SELECT *
FROM EMP
WHERE MOD(EMPNO, 2) == 1;
-- EMP테이블에서 사원명, 입사일 조회 (단, 입사일은 년도와 월을 분리 추출해서 출력)**
SELECT ENAME, EXTRACT(YEAR FROM HIREDATE), EXTRACT(MONTH FROM HIREDATE)
FROM EMP;
-- EMP테이블에서 9월에 입사한 직원의 정보 조회**
SELECT *
FROM EMP
WHERE EXTRACT(MONTH FROM HIREDATE) = 9;
-- EMP테이블에서 81년도에 입사한 직원 조회**
SELECT *
FROM EMP
WHERE EXTRACT(YEAR FROM HIREDATE) = 81;
-- EMP테이블에서 이름이 'E'로 끝나는 직원 조회**
SELECT *
FROM EMP
WHERE ENAME LIKE "%E";
-- EMP테이블에서 이름의 세 번째 글자가 'R'인 직원의 정보 조회**
SELECT *
FROM EMP
WHERE ENAME LIKE "__R%";
-- LIKE 사용**
-- EMP테이블에서 사번, 사원명, 입사일, 입사일로부터 40년 되는 날짜 조회**
SELECT EMPNO, ENAME, HIREDATE, ADD_MONTHS(HIREDATE, 40*12)
FROM EMP;
-- EMP테이블에서 입사일로부터 38년 이상 근무한 직원의 정보 조회**
SELECT *
FROM EMP
WHERE MONTHS_BETWEEN(SYSDATE, HIREDATE) / 12>=38;
-- 오늘 날짜에서 년도만 추출**
SELECT EXTRACT(YEAR FROM SYSDATE)
FROM DUAL;


-- 자료형을 변환하는 형 변환 함수
-- 자동 형변환
SELECT EMPNO, ENAME, EMPNO + '500'
FROM EMP
WHERE ENAME = 'FORD';

SELECT EMPNO, ENAME, EMPNO + 'ABCD'
FROM EMP
WHERE ENAME = 'FORD';

-- 날짜, 숫자를 문자로 변환하느 TO_CHAR 함수
-- 주로 날짜 데이터를 문자 데이터로 변환하는데 사용()
-- 자바의 SimpleDateFormat() 유사
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') AS '현재 날짜 시간'
FROM DUAL;

-- 다양한 형식으로 출력 하기
SELECT SYSDATE,
    TO_CHAR(SYSDATE, 'CC') AS 세기,
    TO_CHAR(SYSDATE, 'YY') AS 연도,
    TO_CHAR(SYSDATE, 'YYYY/MM/DD PM HH:MI:SS ') AS "년/월/일 시:분:초",
    TO_CHAR(SYSDATE, 'Q') AS 쿼터,
    TO_CHAR(SYSDATE, 'DD') AS 일,
    TO_CHAR(SYSDATE, 'DDD') AS 경과일,
    TO_CHAR(SYSDATE, 'HH') AS "12시간제",
    TO_CHAR(SYSDATE, 'HH12') AS "12시간제",
    TO_CHAR(SYSDATE, 'HH24') AS "24시간제",
    TO_CHAR(SYSDATE, 'W') AS 몇주차
FROM DUAL;

-- 여러 언어로 날짜(월) 출력 하기
SELECT SYSDATE,
     TO_CHAR(SYSDATE, 'MM') AS MM,
     TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = KOREAN' ) AS MON_KOR,
     TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = JAPANESE') AS MON_JPN,
     TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = ENGLISH' ) AS MON_ENG,
     TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = KOREAN' ) AS MONTH_KOR,
     TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = JAPANESE') AS MONTH_JPN,
     TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = ENGLISH' ) AS MONTH_ENG
FROM DUAL;

-- 시간 형식 지정하여 출력하기
SELECT SYSDATE,
     TO_CHAR(SYSDATE, 'HH24:MI:SS') AS HH24MISS,
     TO_CHAR(SYSDATE, 'HH12:MI:SS AM') AS HHMISS_AM,
     TO_CHAR(SYSDATE, 'HH:MI:SS P.M.') AS HHMISS_PM
FROM DUAL;

-- 숫자 데이터 형식을 지정하여 출력하기
SELECT SAL,
     TO_CHAR(SAL, '$999,999') AS SAL_$,
     TO_CHAR(SAL, 'L999,999') AS SAL_L,
     TO_CHAR(SAL, '999,999.00') AS SAL_1,
     TO_CHAR(SAL, '000,999,999.00') AS SAL_2,
     TO_CHAR(SAL, '000999999.99') AS SAL_3,
     TO_CHAR(SAL, '999,999,00') AS SAL_4
FROM EMP;

-- TO NUMBER() : NUMBER 타입으로 형 변환
SELECT TO_NUMBER('1300') - '1500'
FROM DUAL;

-- TO_DATE() : 문자열로 명시된 날짜를 날짜 타입으로 형 변환
SELECT TO_DATE('2022/08/20', 'YY/MM/DD')
FROM DUAL;

-- 1981년 6월1일 이후에 입사한 사원 정보 출력하기
SELECT *
FROM EMP
WHERE HIREDATE > TO_DATE('1981/06/01', 'YYYY/MM/DD');

-- NULL 처리 함수 : NULL은 값이 없음, 즉 할당되지 않음을 의미
-- NULL은 0이나 공백과는 다른 의미, 연산 불가
-- NVL(NULL 인지를 검사할 열, 앞의 열 데이터가 NULL인 경우)
SELECT EMPNO, ENAME, SAL, COMM, SAL+COMM,
    NVL(COMM, 0), SAL+NVL(COMM, 0)
FROM EMP;

-- NVL2() : NULL이 아닌경우와 NULL인 경우 모두에 대해서 값을 지정 할 수 있다.
SELECT EMPNO, ENAME, COMM, SAL,
    NVL2(COMM, 'O', 'X') AS 성과급유무,
    NVL2(COMM, SAL*12+COMM, SAL*12) AS 연봉
FROM EMP;

-- NULLIF() : 두 값이 동일하면 NULL 반환, 아니면 첫 번째 값 반환
SELECT NULLIF(10, 10), NULLIF('A', 'B')
FROM DUAL;

-- DECODE : 주어진 데이터 값이 조건 값과 일치하는 값 출력
-- 일치하는 값이 없으면 기본값 출력하기
SELECT EMPNO, ENAME, JOB, SAL,
    DECODE(JOB,
        'MANAGER', SAL*1.1,
        'SALESMAN', SAL*1.05,
        SAL*1.03) AS 연봉인상
FROM EMP;

-- CASE 
SELECT EMPNO, ENAME, JOB, SAL,
    CASE JOB
        WHEN 'MANAGER' THEN SAL*1.1
        WHEN 'SALESMAN' THEN SAL*1.05
        WHEN 'ANAL' THEN SAL
        ELSE SAL*1.3
    END AS 연봉인상
FROM EMP;

-- 열 값에 따라서 출력 값이 달라지는 CASE문
SELECT EMPNO, ENAME,
    CASE
        WHEN COMM IS NULL THEN '해당사항 없음'
        WHEN COMM = 0 THEN '수당없음'
        WHEN COMM > 0 THEN '수당 : ' || COMM
    END AS "성과급기준"
FROM EMP;

---------------------실습 문제-------------------

-- 1번
-- 다음과 같은 결과가 나오도록 SQL문을 작성해 보세요.
-- EMPNO열에는 EMP 테이블에서 사원이름이 다섯 글자 이상이며 여섯글자 미만인
-- 사원 정보를 출력합니다. MASKING_EMPNO열에는 사원번호 (EMPNO) 앞 두자리
-- 외 뒷자리를 * 기호로 출력합니다. 그리고 MASKING_ENAME 열에는 사원 이름의
-- 첫 글자만 보여주고 나머지 글자수만큼 *기호로 출력하세요

SELECT EMPNO,
       RPAD(SUBSTR(EMPNO, 1, 2), 4, '*') AS MASKING_EMPNO,
       ENAME,
       RPAD(SUBSTR(ENAME, 1, 1), LENGTH(ENAME), '*') AS MASKING_ENAME
 FROM  EMP
 WHERE LENGTH(ENAME) = 5;
-- - SUBSTR 함수 : 문자 단위로 시작위치와 자를 길이를 지정하여 문자열을 자른다.
-- - RPAD : 지정한 길이만큼 오른쪽부터 특정 문자로 채워준다.
   
-- 2번 
-- 다음과 같은 결과가 나오도록 SQL문을 작성해보세요.
-- EMP 테이블에서 사원들의 월 평균 근무일수는 21.5일 입니다. 하루 근무 시간 8시간으로 보았을 때
-- 사원들의 하루 급여 (DAY_PAY)와 시급(TIME_PAY)을 계산하여 결과를 출력합니다. 단 하루 급여는 소수점
-- 세번째 자리에서 버리고, 시급은 두번째 소수점에서 반올림하세요.
SELECT EMPNO, ENAME, SAL,
     TRUNC(SAL / 21.5, 2) AS DAY_PAY,
     ROUND(SAL / 21.5 / 8, 1) AS TIME_PAY
FROM EMP;
-- - TRUNC 함수 : 소수점 절사 (2이면 소수점 2자리까지 표시) - 소수점 이하 버림
-- - ROUND 함수 : 소수점 절사(1이면 소수점 1자리까지 표시) - 소수점 반올림   

-- 3번
-- EMP 테이블에서 사원들은 입사일(HIREDATE)을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 됩니다.
-- 사원들이 정직원이 되는 날짜(R_JOB)를 YYYY-MM-DD 형식으로 오른쪽과 같이 출력해 주세요. 단, 추가수당
-- (COMM)이 없는 사원의 추가수당은 N/A로 출력하세요.
SELECT EMPNO, ENAME, HIREDATE,
   TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3), '월요일'), 'YYYY-MM-DD') AS 정직원진급,
   NVL(TO_CHAR(COMM), 'N/A') AS COMM
FROM EMP;
-- - TO_CHAR 함수 :  날짜, 숫자 등의 값을 문자열로 변환하는 함수
-- - NEXT_DAY(’ 기준일자', ‘찾을요일’) :  기준일자의 다음에 오는 날짜를 구하는 함수
-- - NVL (’값', ‘지정값') : 값이 NULL인 경우 지정한 값으로 대체

-- 4번
-- EMP 테이블의 모든 사원을 대상으로 직속 상관의 사원 번호(MGR)를 다음과 같은 조건을 기준으로 변환해서
-- CHG_MGR 열에 출력하세요
-- *직속 상관의 사원 번호가 존재하지 않을 경우 : 0000
-- *직속 상관의 사원 번호 앞 두자리가 75일경우 : 5555
-- *직속 상관의 사원 번호 앞 두자리가 76일경우 : 6666
-- *직속 상관의 사원 번호 앞 두자리가 77일경우 : 7777
-- *직속 상관의 사원 번호 앞 두자리가 78일경우 : 8888
-- *그 외 직속 상관 사원 번호의 경우 : 본래 직속 상관의 사원 번호 그대로 출력

SELECT EMPNO, ENAME, MGR,
     CASE
        WHEN MGR IS NULL THEN '0000'
        WHEN SUBSTR(MGR, 1, 2) = '78' THEN '8888'
        WHEN SUBSTR(MGR, 1, 2) = '77' THEN '7777'
        WHEN SUBSTR(MGR, 1, 2) = '76' THEN '6666'
        WHEN SUBSTR(MGR, 1, 2) = '75' THEN '5555'
        ELSE TO_CHAR(MGR)
     END AS CHG_MGR
FROM EMP;

------------------------------------------------------------------------------------------

-- 다중행 함수 : 여러 행에 대해 함수가 적용되어 하나의 결과를 나타내는 함수(집계 함수)
-- 여러 행이 입력되어 결과가 하나의 행으로 출력
SELECT SUM(SAL)
    FROM EMP;
    
SELECT ENAME, SUM(SAL) 
    FROM EMP

SELECT DEPTNO, SUM(SAL), COUNT(*), ROUND(AVG(SAL)), MAX(SAL), MIN(SAL)
FROM EMP
GROUP BY DEPTNO;
