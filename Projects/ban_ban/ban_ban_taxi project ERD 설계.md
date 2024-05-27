같은 출발지, 목적지를 가진 유저들이 택시를 탈수 있는 서비스의 ERD 입니다. 
아래의 그림 부터 DDL 그리고 각 칼럼에 대해서 설명 달았으니 확인해 주시고 꼭 해당 ERD 가 아니여도 괜찮습니다. 또한 해당 ERD가 선정되면  커셉은 그대로 가져가고 테이블을 더 추가해서 진행해도 좋을 것 같아서  공유합니다. 
예비군 이슈로 인해서 많은 참여 못해 죄송합니다.

![[../../link_images/스크린샷 2024-05-27 오후 6.02.08 1.png]]


### DDL

```sql

create table member  
(  
    created_at timestamp(6),  
    id         bigserial  
        primary key,    updated_at timestamp(6),  
    email      varchar(255),  
    name       varchar(255)  
);  
  
alter table member  
    owner to jin_eun;  
  
create table member_location  
(  
    geo_id          bigserial  
        primary key,    member_id       bigint  
        unique        constraint fko6mxytmnk546jt18pp1cnnd3y  
            references member,  
    depart_location geometry(Point, 4326) not null,  
    des_location    geometry(Point, 4326) not null  
);  
  
alter table member_location  
    owner to jin_eun;  
  
create table taxi_group  
(  
    people_num     integer,  
    departure_time timestamp(6),  
    id             bigserial  
        primary key,    depart_add     varchar(255) not null,  
    des_add        varchar(255) not null  
);  
  
alter table taxi_group  
    owner to jin_eun;  
  
create table chat_room  
(  
    created_at       timestamp(6),  
    id               bigserial  
        primary key,    taxi_group_id_id bigint  
        unique        constraint fk1fbh7wntvfxgs5v9o7t80o87u  
            references taxi_group  
);  
  
alter table chat_room  
    owner to jin_eun;  
  
create table chat_message  
(  
    char_room_id bigint  
        constraint fkkhfuv410to0gvikno3x2bl6pt  
            references chat_room,  
    created_at   timestamp(6),  
    id           bigserial  
        primary key,    sender_id    bigint  
        unique        constraint fk8jhls1uruq1px1lt5n35cgirp  
            references taxi_group,  
    content      varchar(255)  
);  
  
alter table chat_message  
    owner to jin_eun;  
  
create table taxi_member  
(  
    id               bigserial  
        primary key,    member_id_id     bigint  
        unique        constraint fknd25iff43v3phffqmxnuuts7p  
            references member,  
    taxi_group_id_id bigint  
        constraint fkowwl9syb8y1n139qmqva7g79m  
            references taxi_group  
);  

```
---
표준 sql 
```sql
CREATE TABLE taxi_group (
    id BIGINT PRIMARY KEY,
    people_num INTEGER,
    departure_time TIMESTAMP(6),
    depart_add VARCHAR(255),
    des_add VARCHAR(255)
);

CREATE TABLE member (
    id BIGINT PRIMARY KEY,
    created_at TIMESTAMP(6),
    updated_at TIMESTAMP(6),
    email VARCHAR(255),
    name VARCHAR(255)
);

CREATE TABLE member_location (
    geo_id BIGINT PRIMARY KEY,
    member_id BIGINT,
    depart_location GEOMETRY(POINT, 4326),
    des_location GEOMETRY(POINT, 4326),
    FOREIGN KEY (member_id) REFERENCES member(id)
);

CREATE TABLE taxi_member (
    id BIGINT PRIMARY KEY,
    member_id BIGINT,
    taxi_group_id BIGINT,
    FOREIGN KEY (member_id) REFERENCES member(id),
    FOREIGN KEY (taxi_group_id) REFERENCES taxi_group(id)
);

CREATE TABLE chat_room (
    id BIGINT PRIMARY KEY,
    taxi_group_id BIGINT,
    created_at TIMESTAMP(6),
    FOREIGN KEY (taxi_group_id) REFERENCES taxi_group(id)
);

CREATE TABLE chat_message (
    id BIGINT PRIMARY KEY,
    char_room_id BIGINT,
    sender_id BIGINT,
    created_at TIMESTAMP(6),
    content VARCHAR(255),
    FOREIGN KEY (char_room_id) REFERENCES chat_room(id),
    FOREIGN KEY (sender_id) REFERENCES member(id)
);

-- PostGIS-specific tables
CREATE TABLE geometry_columns (
    f_table_catalog VARCHAR(256),
    f_table_schema VARCHAR(256),
    f_table_name VARCHAR(256),
    f_geometry_column VARCHAR(256),
    coord_dimension INTEGER,
    srid INTEGER,
    type VARCHAR(30)
);

CREATE TABLE geography_columns (
    f_table_catalog NAME,
    f_table_schema NAME,
    f_table_name NAME,
    f_geography_column NAME,
    coord_dimension INTEGER,
    srid INTEGER,
    type TEXT
);

CREATE TABLE spatial_ref_sys (
    auth_name VARCHAR(256),
    auth_srid INTEGER,
    srtext VARCHAR(2048),
    proj4text VARCHAR(2048),
    srid INTEGER PRIMARY KEY
);



```
### 테이블 칼럼에 대한 설명
### 1. `taxi_group`

- **설명**: 동일한 출발지와 목적지를 가진 사람들을 그룹화하여 관리하는 테이블.
- **컬럼**:
    - `id`: 그룹 ID (Primary Key)
    - `people_num`: 그룹에 속한 사람의 수
    - `departure_time`: 출발 시간
    - `depart_add`: 출발지 주소
    - `des_add`: 목적지 주소

### 2. `member`

- **설명**: 시스템에 등록된 사용자 정보 테이블.
- **컬럼**:
    - `id`: 사용자 ID (Primary Key)
    - `created_at`: 계정 생성 시간
    - `updated_at`: 계정 정보 업데이트 시간
    - `email`: 사용자 이메일
    - `name`: 사용자 이름

### 3. `member_location`

- **설명**: 사용자의 출발지와 목적지 좌표 정보를 저장하는 테이블.
- **컬럼**:
    - `geo_id`: 위치 정보 ID (Primary Key)
    - `member_id`: 사용자 ID (Foreign Key)
    - `depart_location`: 출발지 좌표 (geometry 타입)
    - `des_location`: 목적지 좌표 (geometry 타입)

### 4. `taxi_member`

- **설명**: 특정 그룹에 속한 사용자 정보를 저장하는 테이블.
- **컬럼**:
    - `id`: 고유 ID (Primary Key)
    - `member_id`: 사용자 ID (Foreign Key)
    - `taxi_group_id`: 그룹 ID (Foreign Key)

### 5. `chat_room`

- **설명**: 그룹에 대한 채팅방 정보를 저장하는 테이블.
- **컬럼**:
    - `id`: 채팅방 ID (Primary Key)
    - `taxi_group_id`: 그룹 ID (Foreign Key)
    - `created_at`: 채팅방 생성 시간

### 6. `chat_message`

- **설명**: 채팅방에서 주고받은 메시지를 저장하는 테이블.
- **컬럼**:
    - `id`: 메시지 ID (Primary Key)
    - `char_room_id`: 채팅방 ID (Foreign Key)
    - `sender_id`: 메시지 발신자 ID (Foreign Key)
    - `created_at`: 메시지 생성 시간
    - `content`: 메시지 내용
---
### post-gis 설명 요약

PostGIS는 PostgreSQL에 지리적 객체를 저장하고 관리할 수 있는 기능을 추가하는 extension.  
postgis 구성 테이블 :   `geometry_columns`, `geography_columns`, `spatial_ref_sys` 

### `geometry_columns` 테이블

이 테이블은 데이터베이스에 저장된 모든 geometry(지오메트리) 타입의 컬럼에 대한 메타데이터를 저장합니다.

- **f_table_catalog**: VARCHAR(256)
    - 이 컬럼은 지오메트리 컬럼이 속한 데이터베이스의 이름.
- **f_table_schema**: VARCHAR(256)
    - 이 컬럼은 지오메트리 컬럼이 속한 스키마의 이름.
- **f_table_name**: VARCHAR(256)
    - 이 컬럼은 지오메트리 컬럼이 속한 테이블의 이름.
- **f_geometry_column**: VARCHAR(256)
    - 이 컬럼은 지오메트리 데이터를 저장하는 컬럼의 이름.
- **coord_dimension**: INTEGER
    - 이 컬럼은 지오메트리 컬럼의 좌표 차원. 예를 들어, 2차원(2D) 또는 3차원(3D) 지오메트리를 저장.
- **srid**: INTEGER
    - 이 컬럼은 지오메트리 컬럼의 좌표 참조 시스템 식별자(SRID)를 저장합니다. SRID는 지리적 좌표 시스템을 정의하는데 사용.
- **type**: VARCHAR(30)
    - 이 컬럼은 지오메트리 컬럼의 타입을 저장. ex) `POINT`, `LINESTRING`, `POLYGON` 등이 있습니다.

### `geography_columns` 테이블

이 테이블은 데이터베이스에 저장된 모든 geography(지리) 타입의 컬럼에 대한 메타데이터를 저장. geography 타입은 지구 표면을 구형으로 간주하는 지리적 좌표 데이터.

- **f_table_catalog**: NAME
    - 지리 컬럼이 속한 데이터베이스의 이름을 저장.
- **f_table_schema**: NAME
    - 지리 컬럼이 속한 스키마의 이름을 저장.
- **f_table_name**: NAME
    - 지리 컬럼이 속한 테이블의 이름을 저장.
- **f_geography_column**: NAME
    - 지리 데이터를 저장하는 컬럼의 이름을 저장.
- **coord_dimension**: INTEGER
    - 지리 컬럼의 좌표 차원을 나타냄. 예를 들어, 2차원(2D) 또는 3차원(3D) 지리를 저장.
- **srid**: INTEGER
    - 지리 컬럼의 좌표 참조 시스템 식별자(SRID)를 저장.
- **type**: TEXT
    - 지리 컬럼의 타입을 저장 . ex) `POINT`, `LINESTRING`, `POLYGON` .

### `spatial_ref_sys` 테이블

이 테이블은 좌표 참조 시스템(CRS)에 대한 정보를 저장합니다. SRID는 지리적 데이터의 좌표 참조 시스템을 정의하는 데 사용됩니다.

- **auth_name**: VARCHAR(256)
    - (authority) 이름을 저장. 예를 들어, `EPSG`와 같은 권위 기관의 이름을 저장합니다.
- **auth_srid**: INTEGER
    -  auth 에 의해 정의된 SRID 값을 저장. 예를 들어, `4326`은 WGS 84 좌표 참조 시스템의 SRID입니다.
- **srtext**: VARCHAR(2048)
    - 좌표 참조 시스템을 설명하는 텍스트를 저장. 이는 보통 WKT(Well-Known Text) 형식으로 저장됩니다.
- **proj4text**: VARCHAR(2048)
    - 이 컬럼은 Proj.4 라이브러리에 의해 사용되는 좌표 변환 정의 문자열을 저장합니다. Proj.4는 좌표 변환을 수행하는 오픈 소스 라이브러리입니다.
- **srid**: INTEGER
    - 좌표 참조 시스템 식별자(SRID)를 저장 이 값은 테이블의 Primary Key입니다.
