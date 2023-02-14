{{ config(materialized='incremental')    }}

{%- set source_model = "stg_campaigns"   -%}
{%- set src_pk = "campaign_HK"          -%}
{%- set src_nk = "campaign_id"          -%}
{%- set src_ldts = "LOAD_DATETIME"      -%}
{%- set src_source = "SOURCE"    -%}

{{ dbtvault.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}
