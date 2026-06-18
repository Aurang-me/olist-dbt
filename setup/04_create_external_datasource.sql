CREATE EXTERNAL DATA SOURCE silver_adls
WITH (
    LOCATION = 'https://stolist01.dfs.core.windows.net/silver',
    CREDENTIAL = adls_credential
);
