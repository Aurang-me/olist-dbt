{% materialization view, adapter='synapse' %}

  {%- set identifier = model['alias'] -%}
  {%- set target_relation = api.Relation.create(
        identifier=identifier, schema=schema, database=database,
        type='view') -%}
  {%- set existing_relation = adapter.get_relation(
        database=database, schema=schema, identifier=identifier) -%}

  {{ run_hooks(pre_hooks, inside_transaction=False) }}
  {{ run_hooks(pre_hooks, inside_transaction=True) }}

  -- drop the existing object first (serverless can't rename)
  {% if existing_relation is not none %}
    {{ adapter.drop_relation(existing_relation) }}
  {% endif %}

  {% call statement('main') -%}
    {{ get_create_view_as_sql(target_relation, sql) }}
  {%- endcall %}

  {{ run_hooks(post_hooks, inside_transaction=True) }}
  {{ adapter.commit() }}
  {{ run_hooks(post_hooks, inside_transaction=False) }}

  {{ return({'relations': [target_relation]}) }}

{% endmaterialization %}