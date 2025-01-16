-- Diagnosis data
SELECT 
    ROW_NUMBER() OVER (ORDER BY NHC, Codificacion, Codigo_diagnostico) AS condition_occurrence_id,
    NHC AS person_id,
    Codigo_diagnostico AS condition_concept_id, 
    FechaDiag AS condition_start_date,
    HoraDiag AS condition_start_time,
    38000245 AS condition_type_concept_id, -- Default: 'EHR record'
    'diagnosticos_hospital1' AS source
FROM diagnosticos_hospital1
UNION ALL
SELECT 
    ROW_NUMBER() OVER (ORDER BY paciente_id, codigo) AS condition_occurrence_id,
    paciente_id AS person_id,
    codigo AS condition_concept_id, 
    DATE(fecha_hora_diagnostico) AS condition_start_date,
    TIME(fecha_hora_diagnostico) AS condition_start_time, 
    38000245 AS condition_type_concept_id, 
    'diagnosticos_hospital2' AS source
FROM diagnosticos_hospital2
UNION ALL
SELECT 
    ROW_NUMBER() OVER (ORDER BY id_dx, codi_dx) AS condition_occurrence_id,
    id_dx AS person_id,
    codi_dx AS condition_concept_id, 
    fecha_dx AS condition_start_date,
    NULL AS condition_start_time, -- Missing in Hospital 3
    38000245 AS condition_type_concept_id,
    'diagnosticos_hospital3' AS source
FROM diagnosticos_hospital3;

-- drug data
SELECT
    ROW_NUMBER() OVER (ORDER BY NHC, idPrec) AS drug_exposure_id,
    NHC AS person_id,
    code_ATC AS drug_concept_id, 
    IniDiaPres AS drug_exposure_start_date,
    FinDiaPres AS drug_exposure_end_date,
    idViaAdm AS route_concept_id, 
    'farmacos_hospital1' AS source
FROM farmacos_hospital1
UNION ALL
SELECT
    ROW_NUMBER() OVER (ORDER BY paciente_id, prescripcion_id) AS drug_exposure_id,
    paciente_id AS person_id,
    codigo_atc AS drug_concept_id, 
    DATE(fecha_hora_inicio) AS drug_exposure_start_date,
    DATE(fecha_hora_fin) AS drug_exposure_end_date,
    NULL AS route_concept_id,
    'farmacos_hospital2' AS source
FROM farmacos_hospital2
UNION ALL
SELECT
    ROW_NUMBER() OVER (ORDER BY id_drugp, codi_snomed) AS drug_exposure_id,
    id_px AS person_id,
    codi_snomed AS drug_concept_id, 
    fecha_inicio AS drug_exposure_start_date,
    fecha_fin AS drug_exposure_end_date,
    route_snomed AS route_concept_id,
    'farmacos_hospital3' AS source
FROM farmacos_hospital3;

-- laboratory data
SELECT
    ROW_NUMBER() OVER (ORDER BY NHC, Episodio) AS measurement_id,
    NHC AS person_id,
    codigo_local_lab AS measurement_concept_id, 
    FechaExtraccion AS measurement_date,
    HoraExtraccion AS measurement_time,
    resultado AS value_as_number, 
    Unidades AS unit_source_value, 
    'laboratorio_hospital1' AS source
FROM laboratorio_hospital1
UNION ALL
SELECT
    ROW_NUMBER() OVER (ORDER BY paciente_id, solicitud_lab_id) AS measurement_id,
    paciente_id AS person_id,
    analitica_loinc AS measurement_concept_id,
    DATE(fecha_hora_extraccion) AS measurement_date,
    TIME(fecha_hora_extraccion) AS measurement_time, 
    valor_laboratorio AS value_as_number, 
    unidad_lab AS unit_source_value, 
    'laboratorio_hospital2' AS source
FROM laboratorio_hospital2
UNION ALL
SELECT
    ROW_NUMBER() OVER (ORDER BY id_lab, idreflab_local) AS measurement_id,
    id_px AS person_id,
    idreflab_local AS measurement_concept_id, 
    fecha_lab AS measurement_date,
    hora_lab AS measurement_time,
    res_lab AS value_as_number, 
    uni_lab AS unit_source_value, 
    'laboratorio_hospital3' AS source
FROM laboratorio_hospital3;

-- Patient data
SELECT
    NHC AS person_id,
    Sexo AS gender_concept_id, 
    FecNaci AS birth_datetime,
    fechaExitus AS death_datetime, 
    'paciente_hospital1' AS source
FROM paciente_hospital1
UNION ALL
SELECT
    paciente_id AS person_id,
    NULL AS gender_concept_id, -- Missing in Hospital 2
    fecha_nacim AS birth_datetime,
    fecha_muerte AS death_datetime,
    'paciente_hospital2' AS source
FROM paciente_hospital2
UNION ALL
SELECT
    id_px AS person_id,
    NULL AS gender_concept_id, -- Missing in Hospital 3
    fecha_birth AS birth_datetime,
    fecha_death AS death_datetime,
    'paciente_hospital3' AS source
FROM paciente_hospital3;

-- Signs/symptoms data
SELECT
    ROW_NUMBER() OVER (ORDER BY id_sv, NHC) AS observation_id,
    NHC AS person_id,
    NULL AS observation_concept_id, 
    fecha_sv AS observation_date,
    hora_sv AS observation_time,
    CAST(valor_sv AS DECIMAL) AS value_as_number,
    'signos_vitales_hospital1' AS source
FROM signos_vitales_hospital1
UNION ALL
SELECT
    ROW_NUMBER() OVER (ORDER BY signos_vitales_id, paciente_id) AS observation_id,
    paciente_id AS person_id,
    signo_vital_local AS observation_concept_id, 
    DATE(fecha_hora_signo_vital) AS observation_date,
    TIME(fecha_hora_signo_vital) AS observation_time, 
    CAST(resultado_signo_vital AS DECIMAL) AS value_as_number,
    'signos_vitales_hospital2' AS source
FROM signos_vitales_hospital2
UNION ALL
SELECT
    ROW_NUMBER() OVER (ORDER BY id_sigvit, id_px) AS observation_id,
    id_px AS person_id,
    snomed_sv AS observation_concept_id, 
    fechasv AS observation_date,
    horasv AS observation_time,
    resultado_sv AS value_as_number,
    'signos_vitales_hospital3' AS source
FROM signos_vitales_hospital3;
