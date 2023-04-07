select * from system.clusters;

create database if not exists loda;

CREATE TABLE IF NOT EXISTS loda.mt (
mid String,
mname String,
createtime DateTime
) ENGINE = MergeTree()
PARTITION BY toYYYYMM(createtime)
ORDER BY (mid,mname)
PRIMARY KEY mid;

insert into loda.mt values
('1','zs','2021-05-02'),('2','ls','2021-06-02'),('3','ww','2021-06-04');



CREATE TABLE IF NOT EXISTS loda.mtint (
    mid String,
    mname String,
    num Int8
) ENGINE = MergeTree()
PARTITION BY num
ORDER BY (mid,mname)
PRIMARY KEY mid;

insert into loda.mtint values
('1','zs',1), ('2','ls',2),('3','ww',1);
insert into loda.mtint values
('1','zs',1), ('2','ls',2),('3','ww',1);

insert into loda.mtint values (1,'loda',2);


optimize table loda.mtint final ;

CREATE TABLE IF NOT EXISTS loda.teacher (
    id Int32,
    name String,
    type Int8
) ENGINE = MergeTree()
PARTITION BY type
ORDER BY id
PRIMARY KEY id;

insert into loda.teacher select number, concat('name', toString(number)), 1 from numbers(100000, 500000);

drop table if exists loda.student;
CREATE TABLE IF NOT EXISTS loda.student (
    id Int32,
    name String,
    type Int8,
    sf String,
    index mm name type minmax granularity 8192,
    index s sf type set(5) granularity 8192,
    index f name type ngrambf_v1(256,1024,5,8899) granularity 8192
) ENGINE = MergeTree()
PARTITION BY type
ORDER BY id
PRIMARY KEY id;

insert into loda.student select number, concat('stuName', toString(number)), 2, 'stu' from
    numbers(100, 200);

optimize table loda.student final ;

set allow_experimental_data_skipping_indices