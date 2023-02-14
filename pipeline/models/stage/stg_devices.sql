{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model:
  raw: "raw_devices"
derived_columns:
  SOURCE: "!1"
{#  LOAD_DATETIME: "CRM_DATA_INGESTION_TIME"#}
  EFFECTIVE_FROM: "CURRENT_DATE"
  START_DATE: "CURRENT_DATE"
  END_DATE: "TO_DATE('9999-12-31')"
hashed_columns:
  devices_HK: "device_id"
  devices_HASHDIFF:
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