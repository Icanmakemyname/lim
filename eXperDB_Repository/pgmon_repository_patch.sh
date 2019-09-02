#-- 315 to 322

#!/bin/sh

TODAY=`date +'%Y%m%d'`

cat << EOF > ${0%.*}.sql
ALTER TABLE TB_MON_USER ALTER COLUMN  user_password TYPE varchar(64);
ALTER TABLE TB_MON_USER ALTER COLUMN  user_phone set default '';
ALTER TABLE TB_MON_USER ALTER COLUMN	user_email set default '';
ALTER TABLE TB_MON_USER ALTER COLUMN	is_deleted set DEFAULT false;
ALTER TABLE TB_MON_USER ALTER COLUMN	last_mod_dt set default now();
ALTER TABLE TB_MON_USER ADD COLUMN	user_phone2 varchar(30) default '';
ALTER TABLE TB_MON_USER ADD COLUMN	user_noti_phone int2 default 0;
ALTER TABLE TB_MON_USER ADD COLUMN	user_dept_name varchar(30) default '';
ALTER TABLE TB_MON_USER ADD COLUMN	set_pw_dt timestamp without time zone default now();
ALTER TABLE TB_MON_USER ADD COLUMN	is_admin_tf bool DEFAULT false;
ALTER TABLE TB_MON_USER ADD COLUMN	is_locked_tf bool DEFAULT false;
ALTER TABLE TB_MON_USER ADD COLUMN	current_login_cnt int2 default 0;
ALTER TABLE TB_MON_USER ADD COLUMN	login_fail_cnt int2 NULL DEFAULT 0;
ALTER TABLE TB_MON_USER ADD COLUMN	login_fail_dt timestamp without time zone;
ALTER TABLE TB_MON_USER ADD COLUMN	last_login_dt timestamp without time zone default now();
ALTER TABLE TB_MON_USER ADD COLUMN	last_logout_dt timestamp without time zone default now();
ALTER TABLE TB_MON_USER ADD COLUMN	last_mod_user_id character varying(16) not null;

ALTER TABLE TB_QUERY_INFO ADD COLUMN dbid int8;
ALTER TABLE TB_QUERY_INFO ADD COLUMN userid int8;
--ALTER TABLE TB_QUERY_INFO ADD COLUMN dbid int8 not null;
--ALTER TABLE TB_QUERY_INFO ADD COLUMN userid int8 not null;

create table tb_mon_group (
    group_id serial primary key,
    group_name character varying(100) not NULL,
    last_mod_user_id character varying(16),
    last_mod_ip character varying(15),
    last_mod_dt timestamp without time zone
);


alter table tb_mon_user_by_group add column last_mod_user_id character varying(16);
--alter table only tb_mon_user_by_group add constraint pk_tb_mon_user_by_group primary key (group_id, user_id);

CREATE TABLE tb_mon_user_policy
(
	login_fail_cnt int2 DEFAULT 5,
	lock_timeout int2 DEFAULT 1,
	lock_inact_period int2 DEFAULT 60,
	nonalphanumeric_tf bool DEFAULT true,
	allow_dup_login_tf bool default true,
	pw_min_length int2  DEFAULT 8,
	pw_expr_days int4 DEFAULT 60,
	pw_expr_noti_days int4  DEFAULT 7, 
	last_mod_user_id character varying(16),
	last_mod_ip character varying(15),
	last_mod_dt timestamp without time zone
);

CREATE TABLE tb_mon_user_allow_ip
(
	user_id character varying(16) not null,
	allow_ip character varying(20) not null
);

alter table only tb_mon_user_allow_ip add constraint pk_tb_mon_user_allow_ip primary key (user_id,allow_ip);

create unlogged table tb_mon_login_attempts (
    attempt_ip character varying(20) not null primary key,
    attempt_cnt integer default 0,
    attempt_dt timestamp without time zone default now()
);


CREATE TYPE access_type AS ENUM (
  'login', 
  'logout', 
  'upgrade', 
  'change_user_info', 
  'change_user_conf', 
  'change_user_pwd', 
  'cluster_detail', 
  'sql_plan',
  'cancel_query'
  'cancel_session'
);

CREATE TABLE tb_mon_user_audit
(
	user_id character varying(16) not null,
	access_dt timestamp without time zone,
	access_type access_type,
	instance_id int4,
	access_status int2,  -- normal, error
	access_log varchar(200),
	access_ip character varying(15)
);

alter table only tb_mon_user_audit add constraint pk_tb_mon_user_audit primary key (user_id,access_dt);

CREATE TABLE tb_mon_perm
(
	perm_id int4 PRIMARY KEY NOT null,
	perm_name character varying(30)
);

CREATE TABLE tb_mon_perm_by_user
(
	user_id character varying(16) not null,
	perm_id int4 not null,
	group_id int4 NOT NULL,
	last_mod_user_id character varying(16),
	last_mod_ip character varying(15),
	last_mod_dt timestamp without time zone
);

CREATE TABLE tb_mon_user_config
(
	user_id character varying(16) primary key,
	language int2 default 0,
	refresh_period int2 default 3000,
	sound_path character varying(500) default 'Siren.wav',
	show_alias_tf bool default false,
	reg_account_sqlplan_tf bool default false,
	style_cpu int2 default 2,
	style_cpu_direction_tf bool default false,
	style_mem int2 default 2,
	style_mem_direction_tf bool default false
);

create EXTENSION IF NOT EXISTS tablefunc;




    
    
create table tb_alert_export_info (
    export_type integer,
    instance_id integer,
    sender character varying(30),
    user_id character varying(16),
    reciever character varying(50),
		export_level integer,
    messages character varying(100),
    issuccess bool,
    error character varying(200),
    collect_dt timestamp without time ZONE
);

alter table only tb_mon_perm_by_user add constraint pk_tb_mon_perm_by_user primary key (user_id,group_id,perm_id);

create index if not exists idx01_tb_alert_export_info on tb_alert_export_info using btree (collect_dt desc);


create table tb_replication_lag_info (
    reg_date character varying(8) not null,
    repl_reg_seq integer not null,
    instance_id integer not null,
    replay_lag integer,
    replay_lag_size numeric(20,0),
    collect_dt timestamp without time zone
)partition by list (reg_date);

create table tb_replication_lag_info_${TODAY} partition of tb_replication_lag_info for values in ('${TODAY}');

alter table only tb_replication_lag_info_${TODAY} add constraint pk_tb_replication_lag_info_${TODAY} primary key (reg_date, repl_reg_seq, instance_id);

create table tb_replication_slots (
    reg_date character varying(8) not null,
    repl_reg_seq integer not null,
    instance_id integer not null,
    slot_name character varying(100),
    plugin character varying(100),
    slot_type character varying(10),
    datoid oid,
    temporary bool,
    active bool,
    oldxmin xid,
    restart_lsn pg_lsn,
    confirmed_flush_lsn  pg_lsn,
    collect_dt timestamp without time zone
);

alter table only tb_replication_slots add constraint pk_tb_replication_slots primary key (reg_date, repl_reg_seq, instance_id, slot_name);

-----------------------<User Managements>--------------------------------------------------
insert into tb_mon_user (user_id, user_name, user_password, last_mod_user_id, is_admin_tf, set_pw_dt) values('admin', 'admin', 'XohImNooBHFR0OVvjcYpJ3NgPQ1qq73WKhHvch0VQtg=', 'admin', true, now());
insert into tb_mon_user_policy (last_mod_user_id,	last_mod_dt) values('admin', now());
insert into tb_mon_user_config (user_id) values ('admin'); 
insert into tb_mon_perm select 1, 'detailed_monitoring';
insert into tb_mon_perm select 2, 'sql_plan';
insert into tb_mon_perm select 3, 'cancel_query';
insert into tb_mon_perm select 4, 'kill_session';

INSERT INTO tb_mon_perm_by_user (user_id, perm_id, group_id, last_mod_user_id, last_mod_ip, last_mod_dt) values('admin', 1, 1, 'admin', '', now());
INSERT INTO tb_mon_perm_by_user (user_id, perm_id, group_id, last_mod_user_id, last_mod_ip, last_mod_dt) values('admin', 1, 2, 'admin', '', now());
INSERT INTO tb_mon_perm_by_user (user_id, perm_id, group_id, last_mod_user_id, last_mod_ip, last_mod_dt) values('admin', 1, 3, 'admin', '', now());
INSERT INTO tb_mon_perm_by_user (user_id, perm_id, group_id, last_mod_user_id, last_mod_ip, last_mod_dt) values('admin', 1, 4, 'admin', '', now());
INSERT INTO tb_mon_perm_by_user (user_id, perm_id, group_id, last_mod_user_id, last_mod_ip, last_mod_dt) values('admin', 2, 1, 'admin', '', now());
INSERT INTO tb_mon_perm_by_user (user_id, perm_id, group_id, last_mod_user_id, last_mod_ip, last_mod_dt) values('admin', 2, 2, 'admin', '', now());
INSERT INTO tb_mon_perm_by_user (user_id, perm_id, group_id, last_mod_user_id, last_mod_ip, last_mod_dt) values('admin', 2, 3, 'admin', '', now());
INSERT INTO tb_mon_perm_by_user (user_id, perm_id, group_id, last_mod_user_id, last_mod_ip, last_mod_dt) values('admin', 2, 4, 'admin', '', now());
INSERT INTO tb_mon_perm_by_user (user_id, perm_id, group_id, last_mod_user_id, last_mod_ip, last_mod_dt) values('admin', 3, 1, 'admin', '', now());
INSERT INTO tb_mon_perm_by_user (user_id, perm_id, group_id, last_mod_user_id, last_mod_ip, last_mod_dt) values('admin', 3, 2, 'admin', '', now());
INSERT INTO tb_mon_perm_by_user (user_id, perm_id, group_id, last_mod_user_id, last_mod_ip, last_mod_dt) values('admin', 3, 3, 'admin', '', now());
INSERT INTO tb_mon_perm_by_user (user_id, perm_id, group_id, last_mod_user_id, last_mod_ip, last_mod_dt) values('admin', 3, 4, 'admin', '', now());
INSERT INTO tb_mon_perm_by_user (user_id, perm_id, group_id, last_mod_user_id, last_mod_ip, last_mod_dt) values('admin', 4, 1, 'admin', '', now());
INSERT INTO tb_mon_perm_by_user (user_id, perm_id, group_id, last_mod_user_id, last_mod_ip, last_mod_dt) values('admin', 4, 2, 'admin', '', now());
INSERT INTO tb_mon_perm_by_user (user_id, perm_id, group_id, last_mod_user_id, last_mod_ip, last_mod_dt) values('admin', 4, 3, 'admin', '', now());
INSERT INTO tb_mon_perm_by_user (user_id, perm_id, group_id, last_mod_user_id, last_mod_ip, last_mod_dt) values('admin', 4, 4, 'admin', '', now());

-----------------------<User Managements>--------------------------------------------------



alter table tb_config add column binary_path character varying(200);
alter table tb_config add column last_mod_user_id character varying(16) default null;
alter table tb_hchk_thrd_list add column last_mod_user_id character varying(16) default null;
alter table tb_instance_info add column last_mod_user_id character varying(16) default null;


alter table only tb_actv_collect_info_${TODAY} drop constraint pk_actv_collect_info_${TODAY};
alter table only tb_replication_info_${TODAY} drop constraint pk_ha_info_${TODAY};
alter table only tb_checkpoint_info_${TODAY} drop constraint pk_checkpoint_info_${TODAY};
alter table only tb_objt_collect_info_${TODAY} drop constraint pk_objt_collect_info_${TODAY};
alter table only tb_table_ext_info_${TODAY} drop constraint pk_table_ext_info_${TODAY};
alter table only tb_pg_stat_statements_${TODAY} drop constraint pk_pg_stat_statements_${TODAY};
alter table only tb_query_info drop constraint pk_query_info;
alter table only tb_query_info add constraint pk_query_info primary key (instance_id, dbid, userid, queryid);
alter table only tb_actv_collect_info_${TODAY} add constraint pk_tb_actv_collect_info_${TODAY} primary key (reg_date,actv_reg_seq);
alter table only tb_replication_info_${TODAY} add constraint pk_tb_replication_info_${TODAY} primary key (reg_date, repl_reg_seq, instance_id);
alter table only tb_checkpoint_info_${TODAY} add constraint pk_tb_checkpoint_info_${TODAY} primary key (reg_date,repl_reg_seq,instance_id);
alter table only tb_objt_collect_info_${TODAY} add constraint pk_tb_objt_collect_info_${TODAY} primary key (reg_date,objt_reg_seq);
alter table only tb_table_ext_info_${TODAY} add constraint pk_tb_table_ext_info_${TODAY} primary key (reg_date,objt_reg_seq,instance_id,relid);
alter table only tb_pg_stat_statements_${TODAY} add constraint pk_tb_pg_stat_statements_${TODAY} primary key (reg_date, collect_dt, instance_id);



update tb_config set version = '11.5.0.330';
update tb_config set binary_path = '/experdb/app/eXperDB-Monitoring/eXperDB_Server/files';

insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (-1, 'REPLICATION_SLOT',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (0 , 'REPLICATION_SLOT',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (1 , 'REPLICATION_SLOT',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (2 , 'REPLICATION_SLOT',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (3 , 'REPLICATION_SLOT',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (4 , 'REPLICATION_SLOT',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (5 , 'REPLICATION_SLOT',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (6 , 'REPLICATION_SLOT',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (7 , 'REPLICATION_SLOT',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (8 , 'REPLICATION_SLOT',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (9 , 'REPLICATION_SLOT',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (10, 'REPLICATION_SLOT',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (11, 'REPLICATION_SLOT',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (12, 'REPLICATION_SLOT',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (13, 'REPLICATION_SLOT',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (14, 'REPLICATION_SLOT',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (15, 'REPLICATION_SLOT',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (16, 'REPLICATION_SLOT',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (17, 'REPLICATION_SLOT',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (18, 'REPLICATION_SLOT',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (19, 'REPLICATION_SLOT',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (20, 'REPLICATION_SLOT',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (21, 'REPLICATION_SLOT',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (22, 'REPLICATION_SLOT',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (23, 'REPLICATION_SLOT',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (24, 'REPLICATION_SLOT',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (25, 'REPLICATION_SLOT',   ' ', '0', 0,   1,    '0', NULL, NULL);

--version 329 to 330
alter table tb_replication_info add column slot_name varchar(32);

insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (-1, 'VIRTUAL_IP',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (1 , 'VIRTUAL_IP',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (2 , 'VIRTUAL_IP',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (3 , 'VIRTUAL_IP',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (4 , 'VIRTUAL_IP',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (5 , 'VIRTUAL_IP',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (6 , 'VIRTUAL_IP',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (7 , 'VIRTUAL_IP',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (8 , 'VIRTUAL_IP',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (9 , 'VIRTUAL_IP',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (10, 'VIRTUAL_IP',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (11, 'VIRTUAL_IP',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (12, 'VIRTUAL_IP',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (13, 'VIRTUAL_IP',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (14, 'VIRTUAL_IP',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (15, 'VIRTUAL_IP',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (16, 'VIRTUAL_IP',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (17, 'VIRTUAL_IP',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (18, 'VIRTUAL_IP',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (19, 'VIRTUAL_IP',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (20, 'VIRTUAL_IP',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (21, 'VIRTUAL_IP',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (22, 'VIRTUAL_IP',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (23, 'VIRTUAL_IP',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (24, 'VIRTUAL_IP',   ' ', '0', 0,   1,    '0', NULL, NULL);
insert into tb_hchk_thrd_list (instance_id, hchk_name, unit, is_higher, warning_threshold, critical_threshold, fixed_threshold, last_mod_ip, last_mod_dt) values (25, 'VIRTUAL_IP',   ' ', '0', 0,   1,    '0', NULL, NULL);




EOF