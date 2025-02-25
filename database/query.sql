-- patients with parameters and, eventually, episodes
select 
	* 
from 
	patients
	inner join parameters on
		parameters.patient_id = patients.patient_id
	left join freezings on
		parameters.parameter_id = freezings.parameter_id
where 
	patients.patient_id = 1