/*==============================================================*/
/* DBMS name:      Sybase SQL Anywhere 12                       */
/* Created on:     2025/6/24 15:36:10                           */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_DM_TPV_L_线路技术参数-主网_DM_FUNCT') then
    alter table DM_TPV_LINE
       delete foreign key "FK_DM_TPV_L_线路技术参数-主网_DM_FUNCT"
end if;

drop table if exists DM_CLASSIFY;

drop index if exists DM_FUNCTION_LOCATION_M.IDX_DM_FL_M_PARENT_ID;

drop index if exists DM_FUNCTION_LOCATION_M.IDX_DM_FL_M_CLASSFY_ID;

drop index if exists DM_FUNCTION_LOCATION_M.IDX_DM_FL_M_BAY_ID;

drop index if exists DM_FUNCTION_LOCATION_M.IDX_DM_FL_M_PLACE_ID;

drop table if exists DM_FUNCTION_LOCATION_M;

drop table if exists DM_TPV_LINE;

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
/* Table: DM_FUNCTION_LOCATION_M                                */
/*==============================================================*/
create table DM_FUNCTION_LOCATION_M 
(
   ID                   VARCHAR2(50)                   not null,
   FL_NAME              VARCHAR2(260)                  not null,
   CLASSIFY_ID          VARCHAR2(32)                   not null,
   constraint PK_DM_FUNCTION_LOCATION_M primary key (ID)
);

comment on table DM_FUNCTION_LOCATION_M is 
'功能位置信息表_主网';

comment on column DM_FUNCTION_LOCATION_M.ID is 
'业务ID';

comment on column DM_FUNCTION_LOCATION_M.FL_NAME is 
'功能位置名称';

comment on column DM_FUNCTION_LOCATION_M.CLASSIFY_ID is 
'类别ID';

/*==============================================================*/
/* Index: IDX_DM_FL_M_PLACE_ID                                  */
/*==============================================================*/
create index IDX_DM_FL_M_PLACE_ID on DM_FUNCTION_LOCATION_M (

);

/*==============================================================*/
/* Index: IDX_DM_FL_M_BAY_ID                                    */
/*==============================================================*/
create index IDX_DM_FL_M_BAY_ID on DM_FUNCTION_LOCATION_M (

);

/*==============================================================*/
/* Index: IDX_DM_FL_M_CLASSFY_ID                                */
/*==============================================================*/
create index IDX_DM_FL_M_CLASSFY_ID on DM_FUNCTION_LOCATION_M (
CLASSIFY_ID ASC
);

/*==============================================================*/
/* Index: IDX_DM_FL_M_PARENT_ID                                 */
/*==============================================================*/
create index IDX_DM_FL_M_PARENT_ID on DM_FUNCTION_LOCATION_M (

);

/*==============================================================*/
/* Table: DM_TPV_LINE                                           */
/*==============================================================*/
create table DM_TPV_LINE 
(
   ID                   VARCHAR2(50)                   not null,
   OVERHEAD_LINE_LENGTH NUMBER(10,2)                   null,
   CABLE_LINE_LENGTH    NUMBER(10,2)                   null,
   ENTER_SUBSTATION_ID  VARCHAR2(50)                   null,
   OUT_SUBSTATION_ID    VARCHAR2(50)                   null,
   AREA_FEATURE         NUMBER(1,0)                    null,
   constraint PK_DM_TPV_LINE primary key (ID)
);

comment on table DM_TPV_LINE is 
'线路技术参数表';

comment on column DM_TPV_LINE.ID is 
'业务ID';

comment on column DM_TPV_LINE.OVERHEAD_LINE_LENGTH is 
'架空长度（单位：米）';

comment on column DM_TPV_LINE.CABLE_LINE_LENGTH is 
'电缆长度（单位：米）';

comment on column DM_TPV_LINE.ENTER_SUBSTATION_ID is 
'进线站ID';

comment on column DM_TPV_LINE.OUT_SUBSTATION_ID is 
'出线站ID';

comment on column DM_TPV_LINE.AREA_FEATURE is 
'地区特征值域：市中心区（1）、市区（2）、城镇（3）、农村（4）';

alter table DM_TPV_LINE
   add constraint "FK_DM_TPV_L_线路技术参数-主网_DM_FUNCT" foreign key (ID)
      references DM_FUNCTION_LOCATION_M (ID)
      on update restrict
      on delete restrict;

