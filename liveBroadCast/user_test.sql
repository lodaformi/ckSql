drop table if exists loda.tb_user_event;
CREATE TABLE loda.tb_user_event
(
    `id` String comment '数据唯一id，使用Kafka的topic+分区+偏移量',
    `deviceId` String comment '设备ID',
    `eventId` String comment '事件ID',
    `isNew` UInt8 comment '是否是新用户1为新,0为老',
    `os` String comment '系统名称',
    `province` String comment '省份',
    `channel` String comment '下载渠道',
    `deviceType` String comment '设备类型',
    `eventTime` DateTime64 comment '数据中所携带的时间',
    `date` String comment 'eventTime转成YYYYMMDD格式',
    `hour` String comment 'eventTime转成HH格式列席',
    `processTime` DateTime comment '插入到数据库时的系统时间'
)
ENGINE = ReplacingMergeTree(processTime)
PARTITION BY (date, hour)
ORDER BY id;

select * from loda.tb_user_event;


drop table if exists loda.tb_user;
create table loda.tb_user (
id UInt32,
name String ,
age UInt8 ,
birthday Date ,
timestamp DateTime
)ENGINE ReplacingMergeTree (timestamp)partition by toYYYYMM (birthday)
order by id;

select * from loda.tb_user final;

select * from loda.tb_user;

optimize table loda.tb_user;

insert into loda.tb_user values(1, 'zhangshan', 20, '2000-12-01', now());
insert into loda.tb_user values(2, 'lisi', 22, '2000-02-01', now());
insert into loda.tb_user values(3, 'wangwu', 20, '2000-12-31', now());
insert into loda.tb_user values(3, 'zhaoliu', 20, '2000-12-01' ,now());
insert into loda.tb_user values(2,  'ls', 20, '2000-12-01', now());

drop table if exists loda.tb_test;
create table if not exists loda.tb_test (
    id UInt8,
    name String,
    add String
) ENGINE MergeTree
order by id;

select * from loda.tb_test;