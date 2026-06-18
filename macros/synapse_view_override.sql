{% macro synapse__create_view_as(relation, sql) -%}
  EXEC('
    create view {{ relation.include(database=False) }} as
    {{ sql | replace("'", "''") }}
  ');
{%- endmacro %}