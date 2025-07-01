/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     2025/6/24 15:35:42                           */
/*==============================================================*/



-- Type package declaration
create or replace package PDTypes  
as
    TYPE ref_cursor IS REF CURSOR;
end;

-- Integrity package declaration
create or replace package IntegrityPackage AS
 procedure InitNestLevel;
 function GetNestLevel return number;
 procedure NextNestLevel;
 procedure PreviousNestLevel;
 end IntegrityPackage;
/

-- Integrity package definition
create or replace package body IntegrityPackage AS
 NestLevel number;

-- Procedure to initialize the trigger nest level
 procedure InitNestLevel is
 begin
 NestLevel := 0;
 end;


-- Function to return the trigger nest level
 function GetNestLevel return number is
 begin
 if NestLevel is null then
     NestLevel := 0;
 end if;
 return(NestLevel);
 end;

-- Procedure to increase the trigger nest level
 procedure NextNestLevel is
 begin
 if NestLevel is null then
     NestLevel := 0;
 end if;
 NestLevel := NestLevel + 1;
 end;

-- Procedure to decrease the trigger nest level
 procedure PreviousNestLevel is
 begin
 NestLevel := NestLevel - 1;
 end;

 end IntegrityPackage;
/


drop trigger "CompoundDeleteTrigger_dm_devic"
/

drop trigger "CompoundInsertTrigger_dm_devic"
/

drop trigger "CompoundUpdateTrigger_dm_devic"
/

drop index IDX_DM_DEVICE_D_PTDATE
/

drop index IDX_DEVICE_D_DEVCIE_MODEL
/

drop index IDX_DEVICE_D_DEVICEVENDOR
/

drop index IDX_DEVICE_D_CLASSIFYID
/

drop table DM_DEVICE_D cascade constraints
/

drop index IDX_DM_DEVICE_M_PTDATE
/

drop index IDX_DEVICE_M_DEVCIE_MODEL
/

drop index IDX_DEVICE_M_DEVICEVENDOR
/

drop index IDX_DEVICE_M_CLASSIFYID
/

drop table DM_DEVICE_M cascade constraints
/

/*==============================================================*/
/* Table: DM_DEVICE_D                                           */
/*==============================================================*/
create table DM_DEVICE_D 
(
   ID                   VARCHAR2(50)         not null,
   PLANT_TRANSFER_DATE  TIMESTAMP,
   ASSET_STATE          NUMBER(2,0),
   RUNMANAGE_OWNER      NUMBER(1,0),
   BASE_VOLTAGE_ID      NUMBER(8,0),
   CLASSIFY_ID          VARCHAR2(32),
   constraint PK_DM_DEVICE_D primary key (ID)
)
/

comment on table DM_DEVICE_D is
'配网设备信息表'
/

comment on column DM_DEVICE_D.ID is
'业务ID'
/

comment on column DM_DEVICE_D.PLANT_TRANSFER_DATE is
'投运日期'
/

comment on column DM_DEVICE_D.ASSET_STATE is
'资产状态：1、运行，2、在建，3、报废，4、待投运，5、闲置，6、删除，7、退运，8、备用，9、停运，10待备用，11闲置再利用'
/

comment on column DM_DEVICE_D.RUNMANAGE_OWNER is
'运维属性（1:局属资产,2:用户资产）'
/

/*==============================================================*/
/* Index: IDX_DEVICE_D_CLASSIFYID                               */
/*==============================================================*/
create index IDX_DEVICE_D_CLASSIFYID on DM_DEVICE_D (
   
)
/

/*==============================================================*/
/* Index: IDX_DEVICE_D_DEVICEVENDOR                             */
/*==============================================================*/
create index IDX_DEVICE_D_DEVICEVENDOR on DM_DEVICE_D (
   
)
/

/*==============================================================*/
/* Index: IDX_DEVICE_D_DEVCIE_MODEL                             */
/*==============================================================*/
create index IDX_DEVICE_D_DEVCIE_MODEL on DM_DEVICE_D (
   
)
/

/*==============================================================*/
/* Index: IDX_DM_DEVICE_D_PTDATE                                */
/*==============================================================*/
create index IDX_DM_DEVICE_D_PTDATE on DM_DEVICE_D (
   PLANT_TRANSFER_DATE ASC
)
/

/*==============================================================*/
/* Table: DM_DEVICE_M                                           */
/*==============================================================*/
create table DM_DEVICE_M 
(
   ID                   VARCHAR2(50)         not null,
   DEVICE_CODE          VARCHAR2(64),
   DEVICE_NAME          VARCHAR2(260)        not null,
   PLANT_TRANSFER_DATE  TIMESTAMP,
   ASSET_STATE          NUMBER(2,0),
   VENDOR               VARCHAR2(100),
   MANUFACTURER         VARCHAR2(100),
   DEVICE_MODEL         VARCHAR2(64),
   PROPRIETOR_COMPANY_ONAME VARCHAR2(200),
   BASE_VOLTAGE_ID      VARCHAR2(50),
   CLASSIFY_ID          VARCHAR2(32),
   BUREAU_CODE          VARCHAR2(4),
   constraint PK_DM_DEVICE_M primary key (ID)
)
/

comment on table DM_DEVICE_M is
'设备信息表'
/

comment on column DM_DEVICE_M.ID is
'业务ID'
/

comment on column DM_DEVICE_M.DEVICE_CODE is
'编码'
/

comment on column DM_DEVICE_M.DEVICE_NAME is
'设备名称'
/

comment on column DM_DEVICE_M.PLANT_TRANSFER_DATE is
'投运日期'
/

comment on column DM_DEVICE_M.ASSET_STATE is
'资产状态：1、运行，2、在建，3、报废，4、待投运，5、闲置，6、删除，7、退运，8、备用，9、停运，10待备用，11闲置再利用'
/

comment on column DM_DEVICE_M.VENDOR is
'供应商'
/

comment on column DM_DEVICE_M.MANUFACTURER is
'厂家名称'
/

comment on column DM_DEVICE_M.DEVICE_MODEL is
'型号'
/

comment on column DM_DEVICE_M.PROPRIETOR_COMPANY_ONAME is
'产权单位名称'
/

/*==============================================================*/
/* Index: IDX_DEVICE_M_CLASSIFYID                               */
/*==============================================================*/
create index IDX_DEVICE_M_CLASSIFYID on DM_DEVICE_M (
   
)
/

/*==============================================================*/
/* Index: IDX_DEVICE_M_DEVICEVENDOR                             */
/*==============================================================*/
create index IDX_DEVICE_M_DEVICEVENDOR on DM_DEVICE_M (
   DEVICE_MODEL ASC
)
/

/*==============================================================*/
/* Index: IDX_DEVICE_M_DEVCIE_MODEL                             */
/*==============================================================*/
create index IDX_DEVICE_M_DEVCIE_MODEL on DM_DEVICE_M (
   
)
/

/*==============================================================*/
/* Index: IDX_DM_DEVICE_M_PTDATE                                */
/*==============================================================*/
create index IDX_DM_DEVICE_M_PTDATE on DM_DEVICE_M (
   PLANT_TRANSFER_DATE ASC
)
/


create or replace trigger "CompoundDeleteTrigger_dm_devic"
for delete on DM_DEVICE_D compound trigger
// Declaration
// Body
  before statement is
  begin
     NULL;
  end before statement;

  before each row is
  begin
     NULL;
  end before each row;

  after each row is
  begin
     NULL;
  end after each row;

  after statement is
  begin
     NULL;
  end after statement;

END
/


create or replace trigger "CompoundInsertTrigger_dm_devic"
for insert on DM_DEVICE_D compound trigger
// Declaration
// Body
  before statement is
  begin
     NULL;
  end before statement;

  before each row is
  begin
     NULL;
  end before each row;

  after each row is
  begin
     NULL;
  end after each row;

  after statement is
  begin
     NULL;
  end after statement;

END
/


create or replace trigger "CompoundUpdateTrigger_dm_devic"
for update on DM_DEVICE_D compound trigger
// Declaration
// Body
  before statement is
  begin
     NULL;
  end before statement;

  before each row is
  begin
     NULL;
  end before each row;

  after each row is
  begin
     NULL;
  end after each row;

  after statement is
  begin
     NULL;
  end after statement;

END
/

