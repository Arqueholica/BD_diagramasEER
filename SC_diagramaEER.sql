
----------- DATOS --------------

insert into places (place_code, place_name, place_region, place_type, place_warded) values
('pike_town',      'Pike Creek',              'Delaware',  'town',    false),
('letters_bunker', 'Men of Letters Bunker',   'Kansas',    'bunker',  true),
('stull_cem',      'Stull Cemetery',          'Kansas',    'cemetery',true),
('frontier_motel', null,                      'Nebraska',  'motel',   false),
('sioux_falls',    'Sioux Falls',             'South Dakota', null,   false),
('black_forest',   'Black Forest',            'Colorado',  'forest',  false),
('st_marys',       'St. Mary''s Church',      'Ohio',      'church',  true),
('cabin_woods',    'Abandoned Cabin',         'Montana',   'cabin',   false);


insert into monsters (monster_code, monster_species, monster_origin, threat_level, last_seen, killing_method) values

('lev_001','Leviathan','ancient deep','apocalyptic','pike_town',
'Rocíalo con boro en solución, inmoviliza con cadenas y decapita con hoja afilada; 
mantén la cabeza separada. Evita el contacto prolongado: regenera rápido y muerde con fuerza extraordinaria.'),

('vamp_012','Vampire','transylvanian lore','high','sioux_falls',
'Debilítalo con sangre de muerto y decapita con machete. Evita la mirada hipnótica; la luz UV ayuda. 
La estaca inmoviliza, no siempre mata, si no hay oportunidad clara.'),

('demon_003','Demon','infernal pact','high',null,
'Trampa demoníaca y exorcismo en latín hasta expulsarlo. 
Un arma de ángel es letal; agua bendita y líneas de sal frenan su avance mientras preparas el ritual.'),

('angel_004','Fallen Angel','celestial','good Lord','stull_cem',
'Atrápalo con sigilos enoquianos, quémalo con fuego sagrado y remata con hoja arcángel al corazón. 
Evita el choque directo; aisla el recipiente primero.'),

('shifter_009','Shapeshifter','urban legend','medium','frontier_motel',
'Detecta el brillo ocular plateado; usa balas o cuchillo de plata. 
No te fíes de llamadas: copia recuerdos. Aísla civiles, ilumina y remata rápido.'),

('wendigo_010','Wendigo','cannibal curse','high','black_forest',
'Atrae al wéndigo a terreno abierto; usa fuego continuo, bengalas o cócteles molotov. 
Mantén líneas de sal y ataca en equipo, nunca en túneles estrechos.'),

('ghost_011','Vengeful Spirit','unresolved death','medium','st_marys',
'Localiza restos o anclas; esparce sal y prende fuego hasta consumir. 
El hierro rompe su forma y dispersa el ectoplasma; repite si surgen nuevos anclajes.'),

('djinn_013','Djinn','desert myth','high','cabin_woods',
'Inyéctale adrenalina para liberar a las víctimas del sueño; h
iérelo con cuchillo de plata bañado en sangre de cordero. Evita su toxina alucinógena.'),

('rougarou_014','Rougarou','bayou legend','medium','pike_town',
'Impide que pruebe carne humana; si cruza el umbral, el fuego lo mata.
 Plata funciona; corta acceso a presas y destruye nidos.'),

('werewolf_015','Werewolf','old curse','high','sioux_falls',
'Bala de plata directa al corazón. Encadena durante luna llena; 
identifica mordidas y aísla al infectado. Wolfsbane ayuda; evita espacios cerrados.'),

('ghoul_016','Ghoul','grave feeder','low','stull_cem',
'Decapitación rápida y fuego sobre restos. Vigila cementerios y morgues; 
imitan a sus víctimas. Hierro interrumpe sus ataques.'),

('siren_017','Siren','coastal myth','medium',null,
'Bloquea su canto con cera o ruido blanco; 
usa daga de bronce untada con sangre del hechizado para romper el control. No permitas contacto directo.');


----------- CONSULTAS --------------


select m.monster_code as MonsterType, m.threat_level as LevelThreat,
       concat(coalesce(p.place_name, 'lugar desconocido'),
              ' (', coalesce(p.place_region, 'región desconocida'), ')') as LastSeen
from monsters m
inner join places p on p.place_code = m.last_seen
order by m.threat_level asc, m.monster_species desc
limit 7;




select p.place_code as PlaceCode, p.place_name as PlaceName,
       if(p.place_warded, 'sí','no') as IsWarded,
       format(count(m.monster_code), 0) as TotalMonsters
from places p
left join monsters m on m.last_seen = p.place_code
group by p.place_code, p.place_name, p.place_warded
having count(m.monster_code) >= 1
order by count(m.monster_code) desc, p.place_code asc;





select m.monster_code as MonsterType,
       concat(m.monster_species, ' en ',
              coalesce(p.place_name, 'lugar desconocido')) as Report,
       m.threat_level as LevelThreat
from monsters m
left join places p on p.place_code = m.last_seen
where m.monster_species like '%l%'
   or m.last_seen is null
order by m.threat_level desc, m.monster_species asc
limit 10;























