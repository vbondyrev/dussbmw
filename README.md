# dussbmw
Analysis project conducted exclusively using open source data (Licence CC 1.0, CC BY 4.0)


Business Request
    ...

Solution Overview
    ...


Azure architecture
    ...


ETL piplene 

1. Data gathering. Parsing
    Collect open-source references and parse data that can be useful for future analysis.
    Raw data that we are going to analyze;

2. Data ingestion
    Raw data is gathered from various sources and stored to Azure PostgresSQL service;
    Utilize Azure Data Factory to save data from PostgresSQL DB to Bronze zone in .parquet format  

3. Data Preprocessing. Cleaning.
    Deduplication; Data validation. Checking data types etc.

4. Data transformation.
    Standatise colmn names; Add new calculation, combine of data etc.; 
    Processing structured and cleaned data from Broze to Silver zone;

5. Data loading to 
    Procesing data from Silver to Gold zone;
    Ready datasets for BI analysis; 





The list with open-source data:

    - Nationaal Georegister NL - Provincie - Bestuurlijke grenzen - historie 2013-2021
        https://www.nationaalgeoregister.nl/geonetwork/srv/dut/catalog.search#/metadata/fe24c2a7-b121-4177-887a-fa16d943729b?tab=general

    - Nationaal Georegister NL - Gemeenten - Bestuurlijke grenzen - historie 2013-2021
        https://www.nationaalgeoregister.nl/geonetwork/srv/dut/catalog.search#/metadata/fe24c2a7-b121-4177-887a-fa16d943729b?tab=general

    - CBS Centraal Bureau voor de Statistiek - Postcode -  Kerncijfers per postcode
        https://www.cbs.nl/nl-nl/dossier/nederland-regionaal/geografische-data/gegevens-per-postcode

    - RDW open data - car plates numbers, vehicle data, etc.
        https://github.com/maximnl/RDW_OPENDATA

    - RDW - Cijfers en letters op de kentekenplaat
        https://www.rdw.nl/de-kentekenplaat/cijfers-en-letters-op-de-kentekenplaat?utm_source=intern&utm_campaign=redirect&utm_medium=https%3A%2F%2Fwww.rdw.nl%2Fparticulier%2Fvoertuigen%2Fauto%2Fde-kentekenplaat%2Fcijfers-en-letters-op-de-kentekenplaat

        https://www.rdw.nl/de-kentekenplaat/overzicht-van-kentekenseries

    - Parsed data


    Other useful links

    - Open datasets van de overheid met actuele geo-informatie
        https://www.pdok.nl/
        https://app.pdok.nl/viewer/#x=254664.91&y=477084.13&z=5.6933&background=BRT-A%20standaard&layers=