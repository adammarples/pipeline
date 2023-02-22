{{ config(materialized='incremental')    }}

{%- set source_model = "stg_patients"   -%}
{%- set src_pk = "PATIENT_HK"          -%}
{%- set src_nk = "patient_id"          -%}
{%- set src_ldts = "LOAD_DATETIME"      -%}
{%- set src_source = "SOURCE"    -%}

{{ dbtvault.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}
