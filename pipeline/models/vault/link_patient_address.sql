{{ config(materialized='incremental')         }}

{%- set source_model = "stg_patients"        -%}
{%- set src_pk = "PATIENT_ADDRESS_HK"         -%}
{%- set src_fk = ["PATIENT_HK", "ADDRESS_HK"] -%}
{%- set src_ldts = "LOAD_DATETIME"           -%}
{%- set src_source = "SOURCE"         -%}

{{ dbtvault.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                 src_source=src_source, source_model=source_model) }}
