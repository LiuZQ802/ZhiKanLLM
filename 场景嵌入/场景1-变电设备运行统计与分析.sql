/*==============================================================*/
/* DBMS name:      Sybase SQL Anywhere 12                       */
/* Created on:     2025/6/24 15:33:05                           */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_DM_DEVIC_主网设备-设备类别_DM_CLASS') then
    alter table DM_DEVICE_M
       delete foreign key "FK_DM_DEVIC_主网设备-设备类别_DM_CLASS"
end if;

drop table if exists DM_BASE_VOLTAGE;

drop table if exists DM_CLASSIFY;

drop index if exists DM_DEVICE_M.IDX_DM_DEVICE_M_PTDATE;

drop index if exists DM_DEVICE_M.IDX_DEVICE_M_DEVCIE_MODEL;

drop index if exists DM_DEVICE_M.IDX_DEVICE_M_DEVICEVENDOR;

drop index if exists DM_DEVICE_M.IDX_DEVICE_M_CLASSIFYID;

drop table if exists DM_DEVICE_M;

drop table if exists SP_PARTITION_CODE;

/*==============================================================*/
/* Table: DM_BASE_VOLTAGE                                       */
/*==============================================================*/
create table DM_BASE_VOLTAGE 
(
   BASE_VOLTAGE_ID      VARCHAR2(50)                   not null,
   IS_DC_AC             NUMBER(1,0)                    null,
   VOLTAGE_PAGE_SHOW    VARCHAR2(32)                   null,
   constraint PK_DM_BASE_VOLTAGE primary key (BASE_VOLTAGE_ID)
);

comment on table DM_BASE_VOLTAGE is 
'基准电压，按照网公司发文的信息分类和编码进行设置';

comment on column DM_BASE_VOLTAGE.BASE_VOLTAGE_ID is 
'基准电压ID';

comment on column DM_BASE_VOLTAGE.IS_DC_AC is 
'是否直流  1:直流  2:交流3:不区分电压等级';

comment on column DM_BASE_VOLTAGE.VOLTAGE_PAGE_SHOW is 
'电压等级页面显示值';

/*==============================================================*/
/* Table: DM_CLASSIFY                                           */
/*==============================================================*/
create table DM_CLASSIFY 
(
   ID                   VARCHAR2(32)                   not null,
   CLASSIFY_NAME        VARCHAR2(84)                   null,
   FULL_NAME            VARCHAR2(360)                  null,
   constraint PK_DM_CLASSIFY primary key (ID)
);

comment on table DM_CLASSIFY is 
'设备类别表，包含功能位置类别、设备类别。';

comment on column DM_CLASSIFY.ID is 
'类别id（统一设备资产目录结构、功能位置类别）';

comment on column DM_CLASSIFY.CLASSIFY_NAME is 
'类别名';

comment on column DM_CLASSIFY.FULL_NAME is 
'全路径';

/*==============================================================*/
/* Table: DM_DEVICE_M                                           */
/*==============================================================*/
create table DM_DEVICE_M 
(
   ID                   VARCHAR2(50)                   not null,
   DEVICE_CODE          VARCHAR2(64)                   null,
   DEVICE_NAME          VARCHAR2(260)                  not null,
   PLANT_TRANSFER_DATE  TIMESTAMP                      null,
   ASSET_STATE          NUMBER(2,0)                    null,
   VENDOR               VARCHAR2(100)                  null,
   MANUFACTURER         VARCHAR2(100)                  null,
   DEVICE_MODEL         VARCHAR2(64)                   null,
   PROPRIETOR_COMPANY_ONAME VARCHAR2(200)                  null,
   BASE_VOLTAGE_ID      VARCHAR2(50)                   null,
   CLASSIFY_ID          VARCHAR2(32)                   null,
   BUREAU_CODE          VARCHAR2(4)                    null,
   constraint PK_DM_DEVICE_M primary key (ID)
);

comment on table DM_DEVICE_M is 
'设备信息表';

comment on column DM_DEVICE_M.ID is 
'业务ID';

comment on column DM_DEVICE_M.DEVICE_CODE is 
'编码';

comment on column DM_DEVICE_M.DEVICE_NAME is 
'设备名称';

comment on column DM_DEVICE_M.PLANT_TRANSFER_DATE is 
'投运日期';

comment on column DM_DEVICE_M.ASSET_STATE is 
'资产状态：1、运行，2、在建，3、报废，4、待投运，5、闲置，6、删除，7、退运，8、备用，9、停运，10待备用，11闲置再利用';

comment on column DM_DEVICE_M.VENDOR is 
'供应商';

comment on column DM_DEVICE_M.MANUFACTURER is 
'厂家名称';

comment on column DM_DEVICE_M.DEVICE_MODEL is 
'型号';

comment on column DM_DEVICE_M.PROPRIETOR_COMPANY_ONAME is 
'产权单位名称';

/*==============================================================*/
/* Index: IDX_DEVICE_M_CLASSIFYID                               */
/*==============================================================*/
create index IDX_DEVICE_M_CLASSIFYID on DM_DEVICE_M (

);

/*==============================================================*/
/* Index: IDX_DEVICE_M_DEVICEVENDOR                             */
/*==============================================================*/
create index IDX_DEVICE_M_DEVICEVENDOR on DM_DEVICE_M (
DEVICE_MODEL ASC
);

/*==============================================================*/
/* Index: IDX_DEVICE_M_DEVCIE_MODEL                             */
/*==============================================================*/
create index IDX_DEVICE_M_DEVCIE_MODEL on DM_DEVICE_M (

);

/*==============================================================*/
/* Index: IDX_DM_DEVICE_M_PTDATE                                */
/*==============================================================*/
create index IDX_DM_DEVICE_M_PTDATE on DM_DEVICE_M (
PLANT_TRANSFER_DATE ASC
);

/*==============================================================*/
/* Table: SP_PARTITION_CODE                                     */
/*==============================================================*/
create table SP_PARTITION_CODE 
(
   PARTITION_CODE       char(10)                       null,
   PARTITION_VALUE      char(10)                       not null,
   constraint PK_SP_PARTITION_CODE primary key (PARTITION_VALUE)
);

comment on table SP_PARTITION_CODE is 
'区局信息表';

alter table DM_DEVICE_M
   add constraint "FK_DM_DEVIC_主网设备-设备类别_DM_CLASS" foreign key (CLASSIFY_ID)
      references DM_CLASSIFY (ID)
      on update restrict
      on delete restrict;

