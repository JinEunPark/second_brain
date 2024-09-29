-- inner join
-- 두 테이블 사이에 지정된 조건에 맞는 레코드만 반환. on 조건을 통해 교집합 찾기
select * from post inner join author on author.id=post.author_id;
select * from author a inner join post p on a.id=p.author_id;
-- 글쓴이가 있는 글 목록과 글쓴이의 이메일을 출력하시오.
select p.id, p.title, p.contents, a.email from post p inner join author a on p.author_id=a.id;

-- 모든 글 목록을 출력하고, 만약에 글쓴이가 있다면 이메일을 출력 (p 다 나오게 하고 시프면 p.* 하면 됨)
select p.id, p.title, p.contents, a.email from post p left outer join author a on p.author_id = a.id;

-- join된 상황에서 where 조건 : on뒤에 where 조건이 나옴
-- 1) 글쓴이가 있는 글 중에 글의 title과 저자의 email을 출력, 저자의 나이는 25세 이상만
select p.title, a.email from post p inner join author a on p.author_id=a.id and a.age >=25;
-- 2) 모든 글 목록 중에 글의 title과 저자가 있다면 email을 출력,2020-05-01 이후에 만들어진 글만 출력
select a.email from author a left join post p on p.title is not null and p.author_id is not null and p.created_time >='2020-05-01';