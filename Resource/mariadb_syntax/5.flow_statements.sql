-- 흐름제어 : case문
SELECT 컬럼1, 컬럼2, 컬럼3
CASE 컬럼4
    WHEN[비교값1] THEN 결과값1
    WHEN[비교값2] THEN 결과값2
    ELSE 결과값3
END
FROM 테이블명;

-- post테이블에서 1번 user는 first author, 2번 user는 second author
SELECT id, title, contents,
    CASE author_id
        WHEN 1 THEN 'first author'
        WHEN 2 THEN 'second author'
        ELSE 'others'
    END as author_id
FROM post;

-- author_id가 있으면 그대로 출력 else author_id, 없으면 '익명 사용자'로 출력
SELECT id, title, contents,
    CASE
        WHEN author_id is null THEN '익명의 사용자'
        ELSE author_id
    END as author_id
FROM post;

-- 위 케이스문을 ifnull 구문으로 변환
SELECT id, title, contents,
    ifnull(author_id, '익명의 사용자') as author_id
FROM post;

-- if문 구문으로 변환
SELECT id, title, contents,
    if(author_id,author_id,'익명의 사용자') as author_id
FROM post;

-- 조건에 부합하는 중고거래 상태 조회하기