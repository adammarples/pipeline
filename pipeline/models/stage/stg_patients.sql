{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model:
  raw: "raw_patients"
derived_columns:
  SOURCE: FILE_NAME
  EFFECTIVE_FROM: DATE(REGEXP_EXTRACT(FILE_NAME, ".*patients_([0-9]{4}-[0-9]{2}-[0-9]{2}).csv"))
  START_DATE: DATE(REGEXP_EXTRACT(FILE_NAME, ".*patients_([0-9]{4}-[0-9]{2}-[0-9]{2}).csv"))
  END_DATE: "date('9999-12-31')"
  LOAD_DATETIME: "CURRENT_DATE"
hashed_columns:
  PATIENT_HK: "patient_id"
  ADDRESS_HK: [
    "address_line_1",
    "address_line_2",
    "city",
    "state",
    "zip",
  ]
  PATIENT_ADDRESS_HK: [
    "patient_id",
    "address_line_1",
    "address_line_2",
    "city",
    "state",
    "zip",
  ]
  PATIENT_HASHDIFF:
    is_hashdiff: true
    columns:
      - "patient_id"
      - "name"
  ADDRESS_HASHDIFF:
    is_hashdiff: true
    columns:
      - "address_line_1"
      - "address_line_2"
      - "city"
      - "state"
      - "zip"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ dbtvault.stage(include_source_columns=true,
                  source_model=metadata_dict['source_model'],
                  derived_columns=metadata_dict['derived_columns'],
                  null_columns=none,
                  hashed_columns=metadata_dict['hashed_columns'],
                  ranked_columns=none) }}