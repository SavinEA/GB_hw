-- -----------------------------------------------------
-- БД разрабатывается с целью хранения ежедневных отчетов по геологоразведке.
-- Данные приходят в файле excel и при помощи скрипта на python переносятся в данную БД.
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema daily_report
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS daily_report;

CREATE SCHEMA IF NOT EXISTS daily_report DEFAULT CHARACTER SET utf8;

USE daily_report;

-- -----------------------------------------------------
-- Table license_area 'Лицензионный участок' 
-- -----------------------------------------------------
DROP TABLE IF EXISTS license_area;

CREATE TABLE IF NOT EXISTS license_area (
  license_area_id serial primary key,
  license_area_name VARCHAR(100) NOT NULL unique
 );

-- -----------------------------------------------------
-- Table customer 'Заказчик'
-- -----------------------------------------------------
DROP TABLE IF EXISTS customer;

CREATE TABLE IF NOT EXISTS customer (
  customer_id serial primary key,
  customer_name VARCHAR(100) NOT NULL unique,
  customer_phone VARCHAR(20),
  customer_email VARCHAR(100)
 );

-- -----------------------------------------------------
-- Table contractor 'Подрядчик'
-- -----------------------------------------------------
DROP TABLE IF EXISTS contractor;

CREATE TABLE IF NOT EXISTS contractor (
  contractor_id serial primary key,
  contractor_name VARCHAR(100) NOT NULL unique,
  contractor_phone VARCHAR(20),
  contractor_email VARCHAR(100)
 );

-- -----------------------------------------------------
-- Table supervisor 'Подрядчик супервайзор'
-- -----------------------------------------------------
DROP TABLE IF EXISTS supervisor;

CREATE TABLE IF NOT EXISTS supervisor (
  supervisor_id serial primary key,
  supervisor_name VARCHAR(100) NOT NULL unique,
  supervisor_phone VARCHAR(20),
  supervisor_email VARCHAR(100)
);

-- -----------------------------------------------------
-- Table contract 'Контарктные данные'
-- Обьединяет в себе данные по контрактом, так же позволяет отследить какие работы относятся к какому контракту
-- -----------------------------------------------------
DROP TABLE IF EXISTS contract;

CREATE TABLE IF NOT EXISTS contract (
  contract_id serial primary key,
  contract_number VARCHAR(100) NOT NULL unique,
  license_area_fk BIGINT UNSIGNED,
  customer_fk BIGINT UNSIGNED,
  contractor_fk BIGINT UNSIGNED,
  supervisor_fk BIGINT UNSIGNED,
  foreign key (license_area_fk) references license_area(license_area_id),
  foreign key (customer_fk) references customer(customer_id),
  foreign key (contractor_fk) references contractor(contractor_id),
  foreign key (supervisor_fk) references supervisor(supervisor_id)
  );

-- -----------------------------------------------------
-- Table methodic 'Методика работ'
-- -----------------------------------------------------
DROP TABLE IF EXISTS methodic;

CREATE TABLE IF NOT EXISTS methodic (
  methodic_id serial primary key,
  methodic_name VARCHAR(100) NOT NULL unique
);

-- -----------------------------------------------------
-- Table source 'Источник'
-- -----------------------------------------------------
DROP TABLE IF EXISTS `source`;

CREATE TABLE IF NOT EXISTS `source` (
  source_id serial primary key,
  source_name VARCHAR(100) NOT NULL unique
);

-- -----------------------------------------------------
-- Table seismic_station 'Тип сейсмостанции'
-- -----------------------------------------------------
DROP TABLE IF EXISTS seismic_station;

CREATE TABLE IF NOT EXISTS seismic_station (
  seismic_station_id serial primary key,
  seismic_station_name VARCHAR(100) NOT NULL unique
 );

-- -----------------------------------------------------
-- Table geophone 'Тип геофонов'
-- -----------------------------------------------------
DROP TABLE IF EXISTS geophone;

CREATE TABLE IF NOT EXISTS geophone (
  geophone_id serial primary key,
  geophone_name VARCHAR(100) NOT NULL unique
);

-- -----------------------------------------------------
-- Table methodology 'Методы сейсморазведочных работ'
-- Хранит набор данных из справочных таблиц, для определени методологии работ по данному контракту
-- -----------------------------------------------------
DROP TABLE IF EXISTS Methodology;

CREATE TABLE IF NOT EXISTS methodology (
  Methodology_id serial primary key,
  line_explosion float not null,
  point_explosion float not null,
  line_reception float not null,
  point_reception float not null,
  active_placement float not null,
  multiplicity float not null,
  v_work_po float not null,
  v_work_km float not null,
  source_fk BIGINT UNSIGNED NOT NULL,
  methodic_fk BIGINT UNSIGNED NOT NULL,
  seismic_station_fk BIGINT UNSIGNED NOT NULL,
  geophone_fk BIGINT UNSIGNED NOT NULL,
  contract_fk BIGINT UNSIGNED NOT NULL,
  foreign key (source_fk) references `source`(source_id),
  foreign key (methodic_fk) references methodic(methodic_id),
  foreign key (seismic_station_fk) references seismic_station(seismic_station_id),
  foreign key (geophone_fk) references geophone(geophone_id),
  foreign key (contract_fk) references contract(contract_id)
);

-- -----------------------------------------------------
-- Table mobilization 'Вид работ - Мобилизация'
-- ------------------------ -----------------------------
DROP TABLE IF EXISTS mobilization;

CREATE TABLE IF NOT EXISTS mobilization (
  mobilization_id serial primary key,
  mobilization_finish_plan DATE not null,
  mobilization_finish_fact DATE,
  mobilization_comment VARCHAR(100) COMMENT 'Причины отклонений'
);

-- -----------------------------------------------------
-- Table cutting 'Вид работ - Рубка'
-- -----------------------------------------------------
 
DROP TABLE IF EXISTS cutting;

CREATE TABLE IF NOT EXISTS cutting (
  cutting_id serial primary key,
  cutting_start_plan DATE NOT NULL,
  cutting_start_fact DATE,
  cutting_finish_plan DATE NOT NULL,
  cutting_finish_fact DATE,
  cutting_comment VARCHAR(100) COMMENT 'Причины отклонений'
);

-- -----------------------------------------------------
-- Table TGO 'Вид работ - ТГО'
-- -----------------------------------------------------
DROP TABLE IF EXISTS TGO;

CREATE TABLE IF NOT EXISTS TGO (
  TGO_id serial primary key,
  TGO_start_plan DATE NOT NULL,
  TGO_start_fact DATE,
  TGO_finish_plan DATE NOT NULL,
  TGO_finish_fact DATE,
  TGO_comment VARCHAR(100) COMMENT 'Причины отклонений'
);

-- -----------------------------------------------------
-- Table BVO 'Вид работ - БВО'
-- -----------------------------------------------------
 
DROP TABLE IF EXISTS BVO;

CREATE TABLE IF NOT EXISTS BVO (
  BVO_id serial primary key,
  BVO_start_plan DATE NOT NULL,
  BVO_start_fact DATE,
  BVO_finish_plan DATE NOT NULL,
  BVO_finish_fact DATE,
  BVO_comment VARCHAR(100) COMMENT 'Причины отклонений'
);

-- -----------------------------------------------------
-- Table OMR 'Вид работ - ОМР'
-- -----------------------------------------------------
DROP TABLE IF EXISTS OMR;

CREATE TABLE IF NOT EXISTS OMR (
  OMR_id serial primary key,
  OMR_start_plan DATE NOT NULL,
  OMR_start_fact DATE,
  OMR_finish_plan DATE NOT NULL,
  OMR_finish_fact DATE,
  OMR_comment VARCHAR(100) COMMENT 'Причины отклонений'
);

-- -----------------------------------------------------
-- Table registration 'Вид работ - Регистрация'
-- -----------------------------------------------------
DROP TABLE IF EXISTS registration;

CREATE TABLE IF NOT EXISTS registration (
  registration_id serial primary key,
  registration_start_plan DATE NOT NULL,
  registration_start_fact DATE,
  registration_finish_plan DATE NOT NULL,
  registration_finish_fact DATE,
  registration_comment VARCHAR(100) COMMENT 'Причины отклонений'
);

-- -----------------------------------------------------
-- Table demobilization 'Вид работ - Демобилизация'
-- -----------------------------------------------------
DROP TABLE IF EXISTS demobilization;

CREATE TABLE IF NOT EXISTS demobilization (
  demobilization_id serial primary key,
  demobilization_start_plan DATE NOT NULL,
  demobilization_start_fact DATE,
  demobilization_finish_plan DATE NOT NULL,
  demobilization_comment VARCHAR(100) COMMENT 'Причины отклонений'
);

-- -----------------------------------------------------
-- Table term_of_work 'Сроки выполнения основных видов работ'
-- Таблица хранит сроки по выполнению работ данного контракта
-- -----------------------------------------------------
DROP TABLE IF EXISTS term_of_work;

CREATE TABLE IF NOT EXISTS term_of_work (
  tow_id serial primary key,
  mobilization_fk BIGINT UNSIGNED NOT NULL,
  cutting_fk BIGINT UNSIGNED NOT NULL,
  TGO_fk BIGINT UNSIGNED NOT NULL,
  BVO_fk BIGINT UNSIGNED NOT NULL,
  OMR_fk BIGINT UNSIGNED NOT NULL,
  registration_fk BIGINT UNSIGNED NOT NULL,
  demobilization_fk BIGINT UNSIGNED NOT NULL,
  contract_fk BIGINT UNSIGNED NOT NULL,
  foreign key (mobilization_fk) references mobilization(mobilization_id),
  foreign key (cutting_fk) references cutting(cutting_id),
  foreign key (TGO_fk) references TGO(TGO_id),
  foreign key (BVO_fk) references BVO(BVO_id),
  foreign key (OMR_fk) references OMR(OMR_id),
  foreign key (registration_fk) references registration(registration_id),
  foreign key (demobilization_fk) references demobilization(demobilization_id),
  foreign key (contract_fk) references contract(contract_id)
);

-- -----------------------------------------------------
-- Table secondary_info 'Общая информация о ходе работ за сутки'
-- Данные о погоде и расходе топлива
-- -----------------------------------------------------
DROP TABLE IF EXISTS secondary_info;

CREATE TABLE IF NOT EXISTS secondary_info (
  secondary_info_id serial primary key,
  consumption_disel float not null,
  consumption_gazoline float not null,
  remaining_disel float not null,
  remaining_gazoline float not null,
  t_eight float not null,
  t_eighteen float not null,
  wind_eight float not null,
  wind_eighteen float not null,
  secondary_info_comment VARCHAR(100) COMMENT 'Проблемы, происшествия, примечания'
);

-- -----------------------------------------------------
-- Table cutting_work 'Лесорубочные работы'
-- -----------------------------------------------------
DROP TABLE IF EXISTS cutting_work;

CREATE TABLE IF NOT EXISTS cutting_work (
  cutting_work_id serial primary key,
  cutting_work_plan_season float not null,
  cutting_work_plan_on_today float not null,
  cutting_work_fact_on_today float not null,
  cutting_work_done_today float not null
);

-- -----------------------------------------------------
-- Table TGO_work 'Топографо-геодезические работы'
-- -----------------------------------------------------
DROP TABLE IF EXISTS TGO_work;

CREATE TABLE IF NOT EXISTS TGO_work (
  TGO_work_id serial primary key,
  TGO_work_plan_season float not null,
  TGO_work_plan_on_today float not null,
  TGO_work_fact_on_today float not null,
  TGO_work_done_today float not null
);

-- -----------------------------------------------------
-- Table BVO_work 'Буровзрывные работы'
-- -----------------------------------------------------
DROP TABLE IF EXISTS BVO_work;

CREATE TABLE IF NOT EXISTS BVO_work (
  BVO_work_id serial primary key,
  BVO_work_plan_season float not null,
  BVO_work_plan_on_today float not null,
  BVO_work_fact_on_today float not null,
  BVO_work_done_today float not null
);

-- -----------------------------------------------------
-- Table OMR_work 'Сейсморазведочные работы'
-- -----------------------------------------------------
DROP TABLE IF EXISTS OMR_work;

CREATE TABLE IF NOT EXISTS OMR_work (
  OMR_work_id serial primary key,
  OMR_work_plan_season_po float not null,
  OMR_work_plan_on_today_po float not null,
  OMR_work_fact_on_today_po float not null,
  OMR_work_done_today_po float not null,
  OMR_work_plan_season_km float not null,
  OMR_work_plan_on_today_km float not null,
  OMR_work_fact_on_today_km float not null,
  OMR_work_done_today_km float not null
);

-- -----------------------------------------------------
-- Table time_tracking 'Учет рабочего времени'
-- -----------------------------------------------------
DROP TABLE IF EXISTS time_tracking;

CREATE TABLE IF NOT EXISTS time_tracking (
  time_tracking_id serial primary key,
  registration time not null,
  climate_simple time not null,
  waiting_topiramat time not null,
  waiting_roll_out time not null,
  LP_setup time not null,
  terrain_features time not null,
  moving time not null,
  changing_staff time not null,
  pronomina time not null,
  malfunction time not null,
  organizational_downtime time not null,
  maintenance time not null,
  development_work time not null,
  simply_reasons time not null,
  refueling_sources_excitement time not null,
  repairs_FSSP time not null,
  waiting_PV_drilling time not null,
  waiting_iterations time not null,
  noise_drilling time not null,
  entering_ship time not null,
  pingerovka time not null,
  changing_source time not null,
  tidal_interference time not null,
  compressor_failure time not null
);

-- -----------------------------------------------------
-- Table daily_report 'Сводная таблица о выполненной работе за сутки'
-- Позволяет  ежедневно контролировать сроки выполнения работ
-- -----------------------------------------------------
DROP TABLE IF EXISTS daily_report;

CREATE TABLE IF NOT EXISTS daily_report (
  daily_report_id serial primary key,
  daily_report_date DATE not null,
  secondary_info_fk BIGINT UNSIGNED NOT NULL,
  cutting_work_fk BIGINT UNSIGNED NOT NULL,
  TGO_work_fk BIGINT UNSIGNED NOT NULL,
  BVO_work_fk BIGINT UNSIGNED NOT NULL,
  OMR_work_fk BIGINT UNSIGNED NOT NULL,
  time_tracking_fk BIGINT UNSIGNED NOT NULL,
  contract_fk BIGINT UNSIGNED NOT NULL,
  foreign key (secondary_info_fk) references secondary_info(secondary_info_id),
  foreign key (cutting_work_fk) references cutting_work(cutting_work_id),
  foreign key (TGO_work_fk) references TGO_work(TGO_work_id),
  foreign key (BVO_work_fk) references BVO_work(BVO_work_id),
  foreign key (OMR_work_fk) references OMR_work(OMR_work_id),
  foreign key (time_tracking_fk) references time_tracking(time_tracking_id),
  foreign key (contract_fk) references contract(contract_id) 
);
