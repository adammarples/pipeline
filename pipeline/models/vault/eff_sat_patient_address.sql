{{ config(materialized='incremental', is_auto_end_dating=True)  }}

{%- set source_model = "stg_patients" -%}
{%- set src_pk = "PATIENT_ADDRESS_HK" -%}
{%- set src_dfk = "PATIENT_HK"       -%}
{%- set src_sfk = "ADDRESS_HK"         -%}
{%- set src_start_date = "START_DATE" -%}    # when is_auto_end_dating=true, this is the start date ALIAS
{%- set src_end_date = "END_DATE" -%}
{%- set src_eff = "EFFECTIVE_FROM"    -%}      # when is_auto_end_dating=true, this is the start date
{%- set src_ldts = "LOAD_DATETIME"    -%}
{%- set src_source = "SOURCE"  -%}

{{ dbtvault.bigquery__eff_sat(src_pk=src_pk, src_dfk=src_dfk, src_sfk=src_sfk,
                    src_start_date=src_start_date,
                    src_end_date=src_end_date,
                    src_eff=src_eff, src_ldts=src_ldts,
                    src_source=src_source,
                    source_model=source_model) }}
