{{ config(materialized='incremental')    }}

{%- set source_model = "stg_events"   -%}
{%- set src_pk = "EVENT_HK"          -%}
{%- set src_nk = "event_id"          -%}
{%- set src_ldts = "LOAD_DATETIME"      -%}
{%- set src_source = "SOURCE"    -%}

{{ dbtvault.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}
