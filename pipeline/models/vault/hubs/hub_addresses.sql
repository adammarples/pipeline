{{ config(materialized='incremental')    }}

{%- set source_model = "stg_patients"   -%}
{%- set src_pk = "ADDRESS_HK"          -%}
{%- set src_nk = [
    "address_line_1",
    "address_line_2",
    "city",
    "state",
    "zip",
  ]          -%}
{%- set src_ldts = "LOAD_DATETIME"      -%}
{%- set src_source = "SOURCE"    -%}

{{ dbtvault.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}
