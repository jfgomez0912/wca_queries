with cities as (
    select
        case
            when c.cityName in ('Armenia') then 'Armenia, Quindío'
            when c.cityName in ('Barrancabermeja') then 'Barrancabermeja, Santander'
            when c.cityName in ('Bogotá', 'Bogotá D.C.', 'Bogotá, Cundinamarca') then 'Bogotá, Cundinamarca'
            when c.cityName in ('Bucaramanga') then 'Bucaramanga, Santander'
            when c.cityName in ('Cartagena') then 'Cartagena, Bolivar'
            when c.cityName in ('Cartago') then 'Cartago, Valle del Cauca'
            when c.cityName in ('Chocontá') then 'Chocontá, Cundinamarca'
            when c.cityName in ('El Carmen De Viboral') then 'El Carmen de Viboral, Antioquia'
            when c.cityName in ('Facatativá') then 'Facatativá, Cundinamarca'
            when c.cityName in ('Florencia') then 'Florencia, Caquetá'
            when c.cityName in ('Floridablanca') then 'Floridablanca, Santander'
            when c.cityName in ('Funza') then 'Funza, Cundinamarca'
            when c.cityName in ('Fusagasugá') then 'Fusagasugá, Cundinamarca'
            when c.cityName in ('La Estrella') then 'La Estrella, Antioquia'
            when c.cityName in ('La Sierra, Quipile, Cundinamarca') then 'La Sierra, Cundinamarca'
            when c.cityName in ('Medellín - Antioquia', 'Medellin') then 'Medellín, Antioquia'
            when c.cityName in ('Melgar') then 'Melgar, Tolima'
            when c.cityName in ('Mosquera') then 'Mosquera, Cundinamarca'
            when c.cityName in ('Neiva') then 'Neiva, Huila'
            when c.cityName in ('Pereira') then 'Pereira, Risaralda'
            when c.cityName in ('Quimbaya') then 'Quimbaya, Quindío'
            when c.cityName in ('Ricaurte') then 'Ricaurte, Cundinamarca'
            when c.cityName in ('San Gil') then 'San Gil, Santander'
            when c.cityName in ('Tocancipá, Cundinamarca, Colombia') then 'Tocancipá, Cundinamarca'
            when c.cityName in ('Tunja') then 'Tunja, Boyacá'
            when c.cityName in ('Villavicencio') then 'Villavicencio, Meta'
            when c.cityName in ('Yopal') then 'Yopal, Casanare'
            when c.cityName in ('Zipaquirá') then 'Zipaquirá, Cundinamarca'
            else replace(c.cityName, '.', '')
        end as normalized_city,
        count(*) cnt
    from Competitions c
    where countryId = 'Colombia' and cityName != 'Multiple locations' and cityName != 'Multiple Cities'
    group by 1
)
select distinct
    substring_index(normalized_city, ',', -1) department,
    sum(cnt) competitions
from cities
group by 1
order by 2 desc
;
