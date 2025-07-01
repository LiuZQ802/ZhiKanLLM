/*==============================================================*/
/* DBMS name:      Sybase SQL Anywhere 12                       */
/* Created on:     2025/6/24 15:34:47                           */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_DM_FUNCT_基准电压-配网功能_DM_BASE_') then
    alter table DM_FUNCTION_LOCATION_D
       delete foreign key "FK_DM_FUNCT_基准电压-配网功能_DM_BASE_"
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_DM_TPV_L_线路技术参数-配网_DM_FUNCT') then
    alter table DM_TPV_LINE
       delete foreign key "FK_DM_TPV_L_线路技术参数-配网_DM_FUNCT"
end if;

drop table if exists DM_BASE_VOLTAGE;

drop table if exists DM_CLASSIFY;

drop index if exists DM_FUNCTION_LOCATION_D.IDX_DM_FL_D_PARENT_ID;

drop index if exists DM_FUNCTION_LOCATION_D.IDX_DM_FL_D_CLASSFY_ID;

drop index if exists DM_FUNCTION_LOCATION_D.IDX_DM_FL_D_BAY_ID;

drop index if exists DM_FUNCTION_LOCATION_D.IDX_DM_FL_D_PLACE_ID;

drop table if exists DM_FUNCTION_LOCATION_D;

drop table if exists DM_TPV_LINE;

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
/* Table: DM_FUNCTION_LOCATION_D                                */
/*==============================================================*/
create table DM_FUNCTION_LOCATION_D 
(
   ID                   VARCHAR2(50)                   not null,
   CLASSIFY_ID          VARCHAR2(32)                   not null,
   BASE_VOLTAGE_ID      NUMBER(8,0)                    null,
   RUNNING_STATE        NUMBER(2,0)                    null,
   constraint PK_DM_FUNCTION_LOCATION_D primary key (ID)
);

comment on table DM_FUNCTION_LOCATION_D is 
'功能位置信息表_配网';

comment on column DM_FUNCTION_LOCATION_D.ID is 
'业务ID';

comment on column DM_FUNCTION_LOCATION_D.CLASSIFY_ID is 
'类别ID';

comment on column DM_FUNCTION_LOCATION_D.BASE_VOLTAGE_ID is 
'电压等级ID';

comment on column DM_FUNCTION_LOCATION_D.RUNNING_STATE is 
'功能位置当前状态1、运行，2、在建，3、报废，4、待投运，5、闲置，6、删除，7、退运，8、备用，9、停运， 10待备用 11闲置再利用';

/*==============================================================*/
/* Index: IDX_DM_FL_D_PLACE_ID                                  */
/*==============================================================*/
create index IDX_DM_FL_D_PLACE_ID on DM_FUNCTION_LOCATION_D (

);

/*==============================================================*/
/* Index: IDX_DM_FL_D_BAY_ID                                    */
/*==============================================================*/
create index IDX_DM_FL_D_BAY_ID on DM_FUNCTION_LOCATION_D (

);

/*==============================================================*/
/* Index: IDX_DM_FL_D_CLASSFY_ID                                */
/*==============================================================*/
create index IDX_DM_FL_D_CLASSFY_ID on DM_FUNCTION_LOCATION_D (
CLASSIFY_ID ASC
);

/*==============================================================*/
/* Index: IDX_DM_FL_D_PARENT_ID                                 */
/*==============================================================*/
create index IDX_DM_FL_D_PARENT_ID on DM_FUNCTION_LOCATION_D (

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

alter table DM_FUNCTION_LOCATION_D
   add constraint "FK_DM_FUNCT_基准电压-配网功能_DM_BASE_" foreign key (BASE_VOLTAGE_ID)
      references DM_BASE_VOLTAGE (BASE_VOLTAGE_ID)
      on update restrict
      on delete restrict;

alter table DM_TPV_LINE
   add constraint "FK_DM_TPV_L_线路技术参数-配网_DM_FUNCT" foreign key (ID)
      references DM_FUNCTION_LOCATION_D (ID)
      on update restrict
      on delete restrict;

