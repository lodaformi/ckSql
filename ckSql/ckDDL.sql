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