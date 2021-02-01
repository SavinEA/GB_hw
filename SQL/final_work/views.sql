-- -----------------------------------------------------
-- вывод таблицы контрактов со значениями из справочных таблиц вместо ключей
-- -----------------------------------------------------

create view all_contracts as select
	contract_id,
	contract_number,
    (select license_area.license_area_name from license_area where license_area.license_area_id=contract.license_area_fk) as license_area,
    (select customer.customer_name from customer where customer.customer_id=contract.customer_fk) as customer,
    (select contractor.contractor_name from contractor where contractor.contractor_id=contract.contractor_fk) as contractor,
	(select supervisor.supervisor_name from supervisor where supervisor.supervisor_id=contract.supervisor_fk) as supervisor    
from contract;

select * from all_contracts;

-- -----------------------------------------------------
-- вывод таблицы методов работы со значениями из справочных таблиц вместо ключей
-- -----------------------------------------------------

create view all_methodology as select
	Methodology_id,
	line_explosion,
	point_explosion,
	line_reception,
	point_reception,
	active_placement,
	multiplicity,
	v_work_po,
	v_work_km,
	(select source.source_name from source where source.source_id=methodology.source_fk) as source,
	(select methodic.methodic_name from methodic where methodic.methodic_id=methodology.methodic_fk) as methodic,
	(select seismic_station.seismic_station_name from seismic_station where seismic_station.seismic_station_id=methodology.seismic_station_fk) as seismic_station,
	(select geophone.geophone_name from geophone where geophone.geophone_id=methodology.geophone_fk) as geophone,
	(select contract.contract_number from contract where contract.contract_id=methodology.contract_fk) as contract_namber
from methodology;

select * from all_methodology;

-- -----------------------------------------------------
-- вывод таблицы завершения плановых работ со значениями из таблиц вместо ключей
-- -----------------------------------------------------

create view all_tow as select
	tow_id,
	(select mobilization.mobilization_finish_plan from mobilization where mobilization.mobilization_id=term_of_work.mobilization_fk) as mobilization,
	(select cutting.cutting_finish_plan from cutting where cutting.cutting_id=term_of_work.cutting_fk) as cutting,
	(select TGO.TGO_finish_plan from TGO where TGO.TGO_id=term_of_work.TGO_fk) as TGO,
	(select BVO.BVO_finish_plan from BVO where BVO.BVO_id=term_of_work.BVO_fk) as BVO,
	(select OMR.OMR_finish_plan from OMR where OMR.OMR_id=term_of_work.OMR_fk) as OMR,
	(select registration.registration_finish_plan from registration where registration.registration_id=term_of_work.registration_fk) as registration,
	(select demobilization.demobilization_finish_plan from demobilization where demobilization.demobilization_id=term_of_work.demobilization_fk) as demobilization,
	(select contract.contract_number from contract where contract.contract_id=term_of_work.contract_fk) as contract_namber
from term_of_work;

select * from all_tow;