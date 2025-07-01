/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     2025/6/24 15:33:56                           */
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

alter table DM_DEVICE_D
   drop constraint "FK_DM_DEVIC_设备类别-配网设备_DM_CLASS"
/

drop table DM_CLASSIFY cascade constraints
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

/*==============================================================*/
/* Table: DM_CLASSIFY                                           */
/*==============================================================*/
create table DM_CLASSIFY 
(
   ID                   VARCHAR2(32)         not null,
   CLASSIFY_NAME        VARCHAR2(84),
   FULL_NAME            VARCHAR2(360),
   constraint PK_DM_CLASSIFY primary key (ID)
)
/

comment on table DM_CLASSIFY is
'设备类别表，包含功能位置类别、设备类别。'
/

comment on column DM_CLASSIFY.ID is
'类别id（统一设备资产目录结构、功能位置类别）'
/

comment on column DM_CLASSIFY.CLASSIFY_NAME is
'类别名'
/

comment on column DM_CLASSIFY.FULL_NAME is
'全路径'
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

alter table DM_DEVICE_D
   add constraint "FK_DM_DEVIC_设备类别-配网设备_DM_CLASS" foreign key (CLASSIFY_ID)
      references DM_CLASSIFY (ID)
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

