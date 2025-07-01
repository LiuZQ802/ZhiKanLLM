/*==============================================================*/
/* DBMS name:      Sybase SQL Anywhere 12                       */
/* Created on:     2025/6/24 15:36:40                           */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_DM_A_TRA_变压器技术参数-主_DM_DEVIC') then
    alter table DM_A_TRANSFORMER
       delete foreign key "FK_DM_A_TRA_变压器技术参数-主_DM_DEVIC"
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_DM_DEVIC_主网设备-设备类别_DM_CLASS') then
    alter table DM_DEVICE_M
       delete foreign key "FK_DM_DEVIC_主网设备-设备类别_DM_CLASS"
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_DM_NODE__主网台账层级-主网_DM_DEVIC') then
    alter table DM_NODE_RELATION_M
       delete foreign key "FK_DM_NODE__主网台账层级-主网_DM_DEVIC"
end if;

drop table if exists DM_A_TRANSFORMER;

drop table if exists DM_CLASSIFY;

drop index if exists DM_DEVICE_M.IDX_DM_DEVICE_M_PTDATE;

drop index if exists DM_DEVICE_M.IDX_DEVICE_M_DEVCIE_MODEL;

drop index if exists DM_DEVICE_M.IDX_DEVICE_M_DEVICEVENDOR;

drop index if exists DM_DEVICE_M.IDX_DEVICE_M_CLASSIFYID;

drop table if exists DM_DEVICE_M;

drop index if exists DM_NODE_RELATION_M.IDX_DM_NODE_M_PCODE;

drop index if exists DM_NODE_RELATION_M.IDX_DM_NODE_M_PID;

drop table if exists DM_NODE_RELATION_M;

/*==============================================================*/
/* Table: DM_A_TRANSFORMER                                      */
/*==============================================================*/
create table DM_A_TRANSFORMER 
(
   ID                   VARCHAR2(50)                   not null,
   TYPE                 VARCHAR2(100)                  null,
   HIGN_LOW_IMPE_VL_MAX NUMBER(16,4)                   null,
   HIGN_LOW_IMPE_VL_RATED NUMBER(16,4)                   null,
   HIGN_LOW_IMPE_VL_MIN NUMBER(16,4)                   null,
   HIGN_MID_IMPE_VL_MAX NUMBER(16,4)                   null,
   HIGN_MID_IMPE_VL_RATED NUMBER(16,4)                   null,
   HIGN_MID_IMPE_VL_MIN NUMBER(16,4)                   null,
   MID_LOW_IMPEDANCE_VL NUMBER(16,4)                   null,
   NO_LOAD_WASTAGE      NUMBER(16,4)                   null,
   NO_LOAD_CURRENT      NUMBER(16,4)                   null,
   ZERO_SEQ_IMPEDANCE   VARCHAR2(200)                  null,
   MID_VOL_RATED_LITTLE_SCC NUMBER(16,4)                   null,
   LOW_VOL_RATED_LITTLE_SCC NUMBER(16,4)                   null,
   OIL_WEIGHT           NUMBER(16,4)                   null,
   OIL_MARK             VARCHAR2(100)                  null,
   TRAFFIC_WEIGHT       NUMBER(16,4)                   null,
   UPPER_OIL_BOX_WEIGHT NUMBER(16,4)                   null,
   MACHINE_WEIGHT       NUMBER(16,4)                   null,
   TOTAL_WEIGHT         NUMBER(16,4)                   null,
   OIL_MANUFACTURER     VARCHAR2(100)                  null,
   RATED_VOLTAGE        VARCHAR2(100)                  null,
   ADJUST_TYPE          VARCHAR2(100)                  null,
   RATED_VOLTAGE_RATIO  VARCHAR2(100)                  null,
   COOLING_MODE         VARCHAR2(100)                  null,
   HIGH_VOL_RATED_CAPACITY NUMBER(16,4)                   null,
   HIGH_VOL_RATED_CURRENT NUMBER(16,4)                   null,
   MID_VOL_RATED_CAPACITY NUMBER(16,4)                   null,
   MID_VOL_RATED_CURRENT NUMBER(16,4)                   null,
   LOW_VOL_RATED_CAPACITY NUMBER(16,4)                   null,
   LOW_VOL_RATED_CURRENT NUMBER(16,4)                   null,
   TIE_LINE_GROUP       VARCHAR2(100)                  null,
   STANDARD_CODE        VARCHAR2(200)                  null,
   HIGHT_LOW_LOAD_WASTAGE NUMBER(16,4)                   null,
   HIGHT_MID_LOAD_WASTAGE NUMBER(16,4)                   null,
   MID_LOW_LOAD_WASTAGE NUMBER(16,4)                   null,
   PHASES               VARCHAR2(100)                  null,
   DYRCP                VARCHAR2(100)                  null,
   WIDING_COUNT         NUMBER(16,4)                   null,
   HIGN_VOL_RATED_LITTLE_SCC VARCHAR(100)                   null,
   BULK_GAS             NUMBER(16,4)                   null,
   RATED_PRESSURE       VARCHAR2(100)                  null,
   HIGH_VOLTAGE_BOX_GAS NUMBER(16,4)                   null,
   COOLING_SYSTEM_GAS   NUMBER(16,4)                   null,
   EQUIPMENT_TYPE       VARCHAR2(100)                  null,
   IS_STANDBY_PHASE     VARCHAR2(32)                   null,
   OLTC_GAS             NUMBER(16,4)                   null,
   NEUTRAL_GROUN_MODE   VARCHAR2(100)                  null,
   HIGH_SIDE_POWER_FRE_UIMP NUMBER(4)                      null,
   MEDIUM_SIDE_POWER_FRE_UIMP NUMBER(4)                      null,
   LOW_SIDE_POWER_FRE_UIMP NUMBER(4)                      null,
   HIGH_RATED_VOLTAGE   VARCHAR2(20)                   null,
   MEDIUM_RATED_VOLTAGE VARCHAR2(20)                   null,
   LOW_RATED_VOLTAGE    VARCHAR2(20)                   null,
   NET_INSULATION_LEVEL VARCHAR2(16)                   null,
   constraint PK_DM_A_TRANSFORMER primary key (ID)
)
partition by list (List(BUREAU_CODE));

comment on table DM_A_TRANSFORMER is 
'主配网变压器的技术参数表';

comment on column DM_A_TRANSFORMER.ID is 
'ID';

comment on column DM_A_TRANSFORMER.TYPE is 
'变压器类型';

comment on column DM_A_TRANSFORMER.HIGN_LOW_IMPE_VL_MAX is 
'高压－低压阻抗电压（最大档位）';

comment on column DM_A_TRANSFORMER.HIGN_LOW_IMPE_VL_RATED is 
'高压－低压阻抗电压（额定档位）';

comment on column DM_A_TRANSFORMER.HIGN_LOW_IMPE_VL_MIN is 
'高压－低压阻抗电压（最小档位）';

comment on column DM_A_TRANSFORMER.HIGN_MID_IMPE_VL_MAX is 
'高压－中压阻抗电压（最大档位）';

comment on column DM_A_TRANSFORMER.HIGN_MID_IMPE_VL_RATED is 
'高压－中压阻抗电压（额定档位）';

comment on column DM_A_TRANSFORMER.HIGN_MID_IMPE_VL_MIN is 
'高压－中压阻抗电压（最小档位）';

comment on column DM_A_TRANSFORMER.MID_LOW_IMPEDANCE_VL is 
'中压－低压阻抗电压';

comment on column DM_A_TRANSFORMER.NO_LOAD_WASTAGE is 
'空载损耗';

comment on column DM_A_TRANSFORMER.NO_LOAD_CURRENT is 
'空载电流';

comment on column DM_A_TRANSFORMER.ZERO_SEQ_IMPEDANCE is 
'零序阻抗';

comment on column DM_A_TRANSFORMER.MID_VOL_RATED_LITTLE_SCC is 
'中压侧额定短时耐受短路电流';

comment on column DM_A_TRANSFORMER.LOW_VOL_RATED_LITTLE_SCC is 
'低压侧额定短时耐受短路电流';

comment on column DM_A_TRANSFORMER.OIL_WEIGHT is 
'油重/气重';

comment on column DM_A_TRANSFORMER.OIL_MARK is 
'油号';

comment on column DM_A_TRANSFORMER.TRAFFIC_WEIGHT is 
'运输重';

comment on column DM_A_TRANSFORMER.UPPER_OIL_BOX_WEIGHT is 
'上节油箱吊重';

comment on column DM_A_TRANSFORMER.MACHINE_WEIGHT is 
'器身吊重';

comment on column DM_A_TRANSFORMER.TOTAL_WEIGHT is 
'总重量';

comment on column DM_A_TRANSFORMER.OIL_MANUFACTURER is 
'变压器油（或SF6）厂家';

comment on column DM_A_TRANSFORMER.RATED_VOLTAGE is 
'额定电压';

comment on column DM_A_TRANSFORMER.ADJUST_TYPE is 
'调压方式';

comment on column DM_A_TRANSFORMER.RATED_VOLTAGE_RATIO is 
'额定电压比及电压级差';

comment on column DM_A_TRANSFORMER.COOLING_MODE is 
'冷却方式';

comment on column DM_A_TRANSFORMER.HIGH_VOL_RATED_CAPACITY is 
'高压额定容量';

comment on column DM_A_TRANSFORMER.HIGH_VOL_RATED_CURRENT is 
'高压额定电流';

comment on column DM_A_TRANSFORMER.MID_VOL_RATED_CAPACITY is 
'中压额定容量';

comment on column DM_A_TRANSFORMER.MID_VOL_RATED_CURRENT is 
'中压额定电流';

comment on column DM_A_TRANSFORMER.LOW_VOL_RATED_CAPACITY is 
'低压额定容量';

comment on column DM_A_TRANSFORMER.LOW_VOL_RATED_CURRENT is 
'低压额定电流';

comment on column DM_A_TRANSFORMER.TIE_LINE_GROUP is 
'结线组别';

comment on column DM_A_TRANSFORMER.STANDARD_CODE is 
'标准代号';

comment on column DM_A_TRANSFORMER.HIGHT_LOW_LOAD_WASTAGE is 
'高压－低压负载损耗';

comment on column DM_A_TRANSFORMER.HIGHT_MID_LOAD_WASTAGE is 
'高压－中压负载损耗';

comment on column DM_A_TRANSFORMER.MID_LOW_LOAD_WASTAGE is 
'中压－低压负载损耗';

comment on column DM_A_TRANSFORMER.PHASES is 
'相数';

comment on column DM_A_TRANSFORMER.DYRCP is 
'产品代号';

comment on column DM_A_TRANSFORMER.WIDING_COUNT is 
'绕组数';

comment on column DM_A_TRANSFORMER.HIGN_VOL_RATED_LITTLE_SCC is 
'高压侧额定短时耐受短路电流';

comment on column DM_A_TRANSFORMER.BULK_GAS is 
'本体气重';

comment on column DM_A_TRANSFORMER.RATED_PRESSURE is 
'额定气压';

comment on column DM_A_TRANSFORMER.HIGH_VOLTAGE_BOX_GAS is 
'高压电缆箱气重';

comment on column DM_A_TRANSFORMER.COOLING_SYSTEM_GAS is 
'冷却系统气重';

comment on column DM_A_TRANSFORMER.EQUIPMENT_TYPE is 
'设备型式';

comment on column DM_A_TRANSFORMER.IS_STANDBY_PHASE is 
'是否备用相';

comment on column DM_A_TRANSFORMER.OLTC_GAS is 
'有载调压开关气重';

comment on column DM_A_TRANSFORMER.NEUTRAL_GROUN_MODE is 
'中性点接地方式';

comment on column DM_A_TRANSFORMER.HIGH_SIDE_POWER_FRE_UIMP is 
'高压侧工频耐受电压';

comment on column DM_A_TRANSFORMER.MEDIUM_SIDE_POWER_FRE_UIMP is 
'中压侧工频耐受电压';

comment on column DM_A_TRANSFORMER.LOW_SIDE_POWER_FRE_UIMP is 
'低压侧工频耐受电压';

comment on column DM_A_TRANSFORMER.HIGH_RATED_VOLTAGE is 
'高压额定电压';

comment on column DM_A_TRANSFORMER.MEDIUM_RATED_VOLTAGE is 
'中压额定电压';

comment on column DM_A_TRANSFORMER.LOW_RATED_VOLTAGE is 
'低压额定电压';

comment on column DM_A_TRANSFORMER.NET_INSULATION_LEVEL is 
'网侧绝缘水平';

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
/* Table: DM_NODE_RELATION_M                                    */
/*==============================================================*/
create table DM_NODE_RELATION_M 
(
   ID                   VARCHAR2(50)                   not null,
   FULL_PATH            VARCHAR2(1000)                 null,
   OBJECT_ID            VARCHAR2(50)                   null,
   PARENT_ID            VARCHAR2(50)                   null,
   constraint PK_DM_NODE_RELATION_M primary key (ID)
);

comment on table DM_NODE_RELATION_M is 
'台帐层级关系表_主网';

comment on column DM_NODE_RELATION_M.ID is 
'业务ID';

comment on column DM_NODE_RELATION_M.FULL_PATH is 
'全路径';

/*==============================================================*/
/* Index: IDX_DM_NODE_M_PID                                     */
/*==============================================================*/
create index IDX_DM_NODE_M_PID on DM_NODE_RELATION_M (

);

/*==============================================================*/
/* Index: IDX_DM_NODE_M_PCODE                                   */
/*==============================================================*/
create index IDX_DM_NODE_M_PCODE on DM_NODE_RELATION_M (

);

alter table DM_A_TRANSFORMER
   add constraint "FK_DM_A_TRA_变压器技术参数-主_DM_DEVIC" foreign key (ID)
      references DM_DEVICE_M (ID)
      on update restrict
      on delete restrict;

alter table DM_DEVICE_M
   add constraint "FK_DM_DEVIC_主网设备-设备类别_DM_CLASS" foreign key (CLASSIFY_ID)
      references DM_CLASSIFY (ID)
      on update restrict
      on delete restrict;

alter table DM_NODE_RELATION_M
   add constraint "FK_DM_NODE__主网台账层级-主网_DM_DEVIC" foreign key (OBJECT_ID)
      references DM_DEVICE_M (ID)
      on update restrict
      on delete restrict;

