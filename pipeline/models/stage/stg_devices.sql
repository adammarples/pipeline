{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model:
  raw: "raw_devices"
derived_columns:
  SOURCE: FILE_NAME
  EFFECTIVE_FROM: DATE(REGEXP_EXTRACT(FILE_NAME, ".*devices_([0-9]{4}-[0-9]{2}-[0-9]{2}).csv"))
  EFFECTIVE_TO: "date('9999-12-31')"
  LOAD_DATETIME: "CURRENT_DATE"
hashed_columns:
  DEVICE_HK: "device_id"
  DEVICE_HASHDIFF:
    is_hashdiff: true
    columns:
      - "device_id"
      - "device_type"
      - "device_model"

{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ dbtvault.stage(include_source_columns=true,
                  source_model=metadata_dict['source_model'],
                  derived_columns=metadata_dict['derived_columns'],
                  null_columns=none,
                  hashed_columns=metadata_dict['hashed_columns'],
                  ranked_columns=none) }}