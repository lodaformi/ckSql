create table loda.tb_user_event_drools(
    id String,
    uid String,
    spu String,
    cid String,
    type String,
    dt String,
    start_time DateTime64,
    end_time DateTime64,
    ts DateTime DEFAULT now()
) ENGINE = ReplacingMergeTree(ts)
PARTITION BY dt
ORDER BY id;

insert into loda.tb_user_event_drools (id, uid, spu, cid, type, dt, start_time, end_time) values (1,'u1002', 'IPHONE13', '手机', 'view', '2022-04-24', '2022-04-25 00:00:00', '2022-05-23 00:00:00');
insert into loda.tb_user_event_drools (id, uid, spu, cid, type, dt, start_time, end_time) values (2,'u1002', 'IPHONE13', '手机', 'view', '2022-04-24', '2022-04-25 00:00:00', '2022-05-23 00:00:00');
insert into loda.tb_user_event_drools (id, uid, spu, cid, type, dt, start_time, end_time) values (3,'u1001', 'IPHONE13', '手机', 'view', '2022-04-24', '2022-04-25 00:00:00', '2022-05-23 00:00:00');
insert into loda.tb_user_event_drools (id, uid, spu, cid, type, dt, start_time, end_time)
values (4,'u1001', 'IPHONE13', '手机', 'view', '2022-04-24', '2022-04-25 00:00:00', '2022-05-23 00:00:00');


select *
from loda.tb_user_event_drools;

SELECT count(*) counts FROM loda.tb_user_event_drools WHERE uid = 'u1002'
                                                        and cid = '手机'
                                                        and type = 'view'
            and start_time >= '2022-04-25 00:00:00' AND end_time <= '2022-06-23 00:00:00'
 GROUP BY uid, cid;