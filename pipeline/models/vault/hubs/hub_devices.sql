{{ config(materialized='incremental')    }}

{%- set source_model = ["stg_devices", "stg_events"]   -%}
{%- set src_pk = "DEVICE_HK"          -%}
{%- set src_nk = "device_id"          -%}
{%- set src_ldts = "LOAD_DATETIME"      -%}
{%- set src_source = "SOURCE"    -%}

{{ dbtvault.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}