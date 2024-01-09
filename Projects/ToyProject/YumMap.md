### tasks

> [! Todo] Title  
> YumMap 개발기를 전체적으로 정리하면서 사용한 기술 스텍및 모든 것을 정리해보자!!

### background Information

---

앱 제작 동기: 사실 회사에 진짜 맛잘알 친구가 있다 이친구는 맛집 데이터 베이스가 네이버 지도에 진짜 널려있는데 네이버 블로그에 맛집을 올리고 있다. 흠... 그래서 이런 맛집 데이터 베이스를 손쉽게 공유하고 팔수도 있고 작성도 가능한 무언가가 있다면 정말 좋을것 같다!! 라는 생각을 하게 되었다.  
그 전의 프로젝트들에서는 기획단계에 너무 많은 시간을 쏫은거 같다는 생각을 해서 이번엔 어차피 혼자 개발하는 경우기 때문에 최대한 간단하게 작성하고 개발할 예정 ㅎㅎ 에자일이라는 핑계를 대볼까한다...

일단 대강의 컨셉은 다음과 같다.  
1. 사용자들을 입맛에 따라서 분류한다.  
2. 어 떤 맛잘알이 자기 입맙에 해당하는 공유방을 생성!!!(맛집 지도를 팀원들과 함께 만들어가게 되는것)  
1. 이 때 만들어진 공유방을 식구라고 칭할 예정이다..

### Study

위의 플렛폼을 개발하기 위해서 사용할 기술 스텍을 정리하던 도중에 뭘로 시작해야 좋을지가 사실 너무 고민이다.

- FrontEnd: vue.js (확정) 왜냐면 사실 내가 아는게 이거 하나다! nuxtJS 도 회사에서 많이 써보긴했는데 음... 그래서 그것도 vue 기반이다. 따라서 일단 vue 로 확정하고 바로 ㄱ!

### Trouble

- Backend : spring boot vs nodejs 하 사실이게 너무 고민이다... spring boot 는 지금까지 정말 많이 사용해 본거 같지만 인턴을 제외하고는 아직 운영경험은 없고... node 는 전혀 모르지만 꼭 사용해보고 싶은 그런 느낌이랄까???
- DB : RDMS vs noSQL 뭘로 하는게 가장 좋을까....

### shooting

#fixed

- Backend: spring boot 이미 학습한 경험이 있다는 핑계와 SQL 을 더 연습하고 싶다... JPQL  
    - DB: postgreSQL 와 [postGIS](https://postgis.net/) 사실이 GIS DB 의 기가 막힌 사용법을 익혀보고 싶고 저장 용량을 최대한 단순하게 만들수 있다는점 그리고 자동화된 index 기술 그리고 기가막힌 용량 저장 B-tree 위자료 구조를 사용하면서 저장하는 정보의 양은 적지만 가져올 때는 많은 양을 memory 에 로딩할 수 있다는 장점이 있다.
- infra : 흠 그간에는 aws 를 적극적으로 활용했었는데 이번에는 local pc 가 하나 남는것이 있어서 그쪽을 포트포워딩으로 열고 배포를 해보고자한다 aws 넘나 비싼것 따라서 docker 사용은 무조건해야할것 같다...

[link vue](https://v3-docs.vuejs-korea.org/guide/essentials/application.html#app-configurations) 공식문서  
[우아한기술 블로그 mysql vs postgreSql](https://techblog.woowahan.com/6550/) 이부분을 참고하면 왜 내가 postgreSql 을 사용했는지 알 수있다
[postgreSQL](https://www.postgresql.org/docs/)


#### 2. 복잡한 쿼리

1000만 건 데이터의 조인쿼리를 HASH JOIN으로 비교 실행해 보았습니다.  
**Aurora MySQL에서는 22초** 정도 소요된 반면 **Aurora PostgreSQL에서는 3초**로 7배 이상 빠른 속도를 보여 주었습니다. Aurora MySQL의 일반적인 방식인 Nested loop Join을 선택하는 경우라면 이보다 훨씬 늦어지겠죠. (r5.2xlarge에서 실행 시 2시간 이상 소요)

**데이터 세팅**  
(MySQL)

```shell
-- 테이블 생성
mysql> create table users (
     id int auto_increment primary key,
     id2 int, 
     Name varchar(100),
     Address varchar(512)
);

-- 데이터 INSERT
mysql> insert into users(id2,Name,Address)
select floor(1 + rand() * 50000000),
A.table_name,A.table_name
from information_schema.tables A
   cross join information_schema.tables B
   cross join information_schema.tables C
   cross join information_schema.tables D
limit 10000000;
```

(PostgreSQL)  
데이터 INSERT: 동일한 데이터 세팅을 위해 [DMS](https://aws.amazon.com/ko/dms/)로 데이터를 이관

**데이터 조회**  
(MySQL)

```shell
-- hash join 기능 활성화
mysql> SET optimizer_switch='hash_join=on'; 
Query OK, 0 rows affected (0.02 sec)

-- hash join으로 실행계획이 풀리는 것을 확인
mysql> explain select count(*) from users A inner join users B ON A.id2=B.id2; 
+----+-------------+-------+------------+------+---------------+------+---------+------+---------+----------+----------------------------------------------------------+
| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows    | filtered | Extra                                                    |
+----+-------------+-------+------------+------+---------------+------+---------+------+---------+----------+----------------------------------------------------------+
|  1 | SIMPLE      | A     | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 9757959 |   100.00 | NULL                                                     |
|  1 | SIMPLE      | B     | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 9757959 |    10.00 | Using where; Using join buffer (Hash Join Outer table B) |
+----+-------------+-------+------------+------+---------------+------+---------+------+---------+----------+----------------------------------------------------------+
2 rows in set, 1 warning (0.03 sec)

-- 22초 소요
select count(*) from users A inner join users B ON A.id2=B.id2;
+----------+
| count(*) |
+----------+
| 18334934 |
+----------+
1 row in set (22.16 sec)
```

(PostgreSQL)

```null
\timing on

-- 이관 된 스키마 확인
psql=> \d users
                      Table "bm_ord.users"
 Column  |          Type          | Collation | Nullable | Default
---------+------------------------+-----------+----------+---------
 id      | integer                |           | not null |
 id2     | integer                |           |          |
 Name    | character varying(100) |           |          |
 Address | character varying(512) |           |          |
Indexes:
    "users_pkey" PRIMARY KEY, btree (id)

-- parallel & Hash join 으로 실행계획이 풀리는 것을 확인
psql=> explain select count(*) from users A inner join users B ON A.id2=B.id2;
                                                QUERY PLAN
----------------------------------------------------------------------------------------------------------
 Finalize Aggregate  (cost=478253.80..478253.81 rows=1 width=8)
   ->  Gather  (cost=478253.59..478253.80 rows=2 width=8)
         Workers Planned: 2
         ->  Partial Aggregate  (cost=477253.59..477253.60 rows=1 width=8)
               ->  Parallel Hash Join  (cost=208305.82..458902.79 rows=7340320 width=0)
                     Hash Cond: (a.id2 = b.id2)
                     ->  Parallel Seq Scan on users2 a  (cost=0.00..140018.03 rows=4162303 width=4)
                     ->  Parallel Hash  (cost=140018.03..140018.03 rows=4162303 width=4)
                           ->  Parallel Seq Scan on users2 b  (cost=0.00..140018.03 rows=4162303 width=4)

-- 3초 소요
psql=> select count(*) from users A inner join users B ON A.id2=B.id2;
  count
----------
 18334934
(1 row)

Time: 3146.135 ms (00:03.146)
```

이 부분이 너무 마음에 든다 복잡한 알고리즘으로 입맛에 따라서 사용자의 음식점을 뽑아내는 과정을 거칠것이기 때문이다. 또 다른 점은 같은 음식점에 대해서 사용자에 대해서 다르게 분류하는 경우 등에 대해서 복잡해질것으로 예상한다.

[[PostgreSQL spring boot config 및 db 생성]]
