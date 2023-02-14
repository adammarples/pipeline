{{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
source_model: "stg_devices"
src_pk: "DEVICE_HK"
src_hashdiff:
  source_column: "DEVICE_HASHDIFF"
  alias: "HASHDIFF"
src_payload:
  - "device_type"
  - "device_model"
src_eff: "EFFECTIVE_FROM"
src_ldts: "LOAD_DATETIME"
src_source: "SOURCE"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ dbtvault.sat(src_pk=metadata_dict["src_pk"],
                src_hashdiff=metadata_dict["src_hashdiff"],
                src_payload=metadata_dict["src_payload"],
                src_eff=metadata_dict["src_eff"],
                src_ldts=metadata_dict["src_ldts"],
                src_source=metadata_dict["src_source"],
                source_model=metadata_dict["source_model"])   }}