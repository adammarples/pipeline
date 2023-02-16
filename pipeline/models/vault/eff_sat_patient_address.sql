{{ config(materialized='incremental')  }}

{%- set source_model = "stg_patients" -%}
{%- set src_pk = "PATIENT_ADDRESS_HK" -%}
{%- set src_dfk = "PATIENT_HK"       -%}
{%- set src_sfk = "ADDRESS_HK"         -%}
{%- set src_start_date = "EFFECTIVE_FROM" -%}
{%- set src_end_date = "EFFECTIVE_TO" -%}

{%- set src_eff = "EFFECTIVE_FROM"    -%}
{%- set src_ldts = "LOAD_DATETIME"    -%}
{%- set src_source = "SOURCE"  -%}

{{ dbtvault.eff_sat(src_pk=src_pk, src_dfk=src_dfk, src_sfk=src_sfk,
                    src_start_date=src_start_date,
                    src_end_date=src_end_date,
                    src_eff=src_eff, src_ldts=src_ldts,
                    src_source=src_source,
                    source_model=source_model) }}
