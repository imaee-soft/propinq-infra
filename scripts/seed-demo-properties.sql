-- Seed demo: casas + edificios con deptos en Villa María, Córdoba Capital y CABA
-- Imágenes Unsplash (casas / depto interiores / edificios). Cada URL es única (PK).

SET NAMES utf8mb4;

-- OWNER de prueba (password bcrypt = misma del seed original: "password" o la del hash seed)
INSERT IGNORE INTO users (
    user_id, password, birth_date, first_name, last_name, email,
    address, phone_number, role, activated, deleted
) VALUES (
    UNHEX('11111111111111111111111111111111'),
    '$2a$10$XuN33pdjkfpv3SfA8I.jm.hQHV3aempTZquspVNsBSCUkxmKzydjS',
    '1985-05-15',
    'Juan',
    'Propietario',
    'propietario@propinq.com',
    'Villa María, Córdoba',
    '+5493534987654',
    'OWNER',
    1,
    0
);

-- ===================== IMÁGENES =====================
-- Casas
INSERT IGNORE INTO images (url, deleted, public_id, file_name) VALUES
('https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=1200&q=80', 0, 'house-ext-01', 'house-ext-01.jpg'),
('https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=1200&q=80', 0, 'house-ext-02', 'house-ext-02.jpg'),
('https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=1200&q=80', 0, 'house-ext-03', 'house-ext-03.jpg'),
('https://images.unsplash.com/photo-1600047509807-ba8f99d2cd0c?w=1200&q=80', 0, 'house-ext-04', 'house-ext-04.jpg'),
('https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=1200&q=80', 0, 'house-ext-05', 'house-ext-05.jpg'),
('https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=1200&q=80', 0, 'house-ext-06', 'house-ext-06.jpg'),
('https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=1200&q=80', 0, 'house-ext-07', 'house-ext-07.jpg'),
('https://images.unsplash.com/photo-1580587771525-78b9eaa60c84?w=1200&q=80', 0, 'house-ext-08', 'house-ext-08.jpg'),
('https://images.unsplash.com/photo-1568605114967-8130f3a36994?w=1200&q=80', 0, 'house-ext-09', 'house-ext-09.jpg'),
('https://images.unsplash.com/photo-1605276374104-dee2c83bf63f?w=1200&q=80', 0, 'house-ext-10', 'house-ext-10.jpg'),
('https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?w=1200&q=80', 0, 'house-int-01', 'house-int-01.jpg'),
('https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?w=1200&q=80', 0, 'house-int-02', 'house-int-02.jpg'),
-- Edificios exteriores
('https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=1200&q=80', 0, 'bldg-ext-01', 'bldg-ext-01.jpg'),
('https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=1200&q=80', 0, 'bldg-ext-02', 'bldg-ext-02.jpg'),
('https://images.unsplash.com/photo-1460317441624-23cfa11eb17a?w=1200&q=80', 0, 'bldg-ext-03', 'bldg-ext-03.jpg'),
('https://images.unsplash.com/photo-1486325212027-8081e4854094?w=1200&q=80', 0, 'bldg-ext-04', 'bldg-ext-04.jpg'),
('https://images.unsplash.com/photo-1493809842364-78817add7ffb?w=1200&q=80', 0, 'bldg-ext-05', 'bldg-ext-05.jpg'),
('https://images.unsplash.com/photo-1582407947304-fd86f028f716?w=1200&q=80', 0, 'bldg-ext-06', 'bldg-ext-06.jpg'),
-- Departamentos interiores
('https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=1200&q=80', 0, 'apt-int-01', 'apt-int-01.jpg'),
('https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=1200&q=80', 0, 'apt-int-02', 'apt-int-02.jpg'),
('https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?w=1200&q=80', 0, 'apt-int-03', 'apt-int-03.jpg'),
('https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=1200&q=80', 0, 'apt-int-04', 'apt-int-04.jpg'),
('https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=1200&q=80', 0, 'apt-int-05', 'apt-int-05.jpg'),
('https://images.unsplash.com/photo-1536376072261-38c75010e6c9?w=1200&q=80', 0, 'apt-int-06', 'apt-int-06.jpg'),
('https://images.unsplash.com/photo-1554995207-c18c203602cb?w=1200&q=80', 0, 'apt-int-07', 'apt-int-07.jpg'),
('https://images.unsplash.com/photo-1560185127-6ed189bf02f4?w=1200&q=80', 0, 'apt-int-08', 'apt-int-08.jpg'),
('https://images.unsplash.com/photo-1630699144867-37acec97df5e?w=1200&q=80', 0, 'apt-int-09', 'apt-int-09.jpg'),
('https://images.unsplash.com/photo-1616594039964-ae9021a400a0?w=1200&q=80', 0, 'apt-int-10', 'apt-int-10.jpg'),
('https://images.unsplash.com/photo-1615874959474-d609969a20ed?w=1200&q=80', 0, 'apt-int-11', 'apt-int-11.jpg'),
('https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?w=1200&q=80', 0, 'apt-int-12', 'apt-int-12.jpg'),
('https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?w=1200&q=80', 0, 'apt-int-13', 'apt-int-13.jpg'),
('https://images.unsplash.com/photo-1615529182904-14819c35db37?w=1200&q=80', 0, 'apt-int-14', 'apt-int-14.jpg'),
('https://images.unsplash.com/photo-1616137466211-f939a420be84?w=1200&q=80', 0, 'apt-int-15', 'apt-int-15.jpg'),
('https://images.unsplash.com/photo-1600585154526-990dced4db0d?w=1200&q=80', 0, 'apt-int-16', 'apt-int-16.jpg'),
('https://images.unsplash.com/photo-1600573472592-401b489a3cdc?w=1200&q=80', 0, 'apt-int-17', 'apt-int-17.jpg'),
('https://images.unsplash.com/photo-1600047509358-9dc75507daeb?w=1200&q=80', 0, 'apt-int-18', 'apt-int-18.jpg');

-- ===================== EDIFICIOS =====================
-- property_type: 0=APARTAMENTO, 1=CASA
INSERT IGNORE INTO buildings (
    building_id, name, description, address, latitude, longitude,
    user_user_id, building_type, deleted, created_at
) VALUES
(
    UNHEX(REPLACE('b1000000-0000-4000-8000-000000000001', '-', '')),
    'Torre Villa María Centro',
    'Edificio residencial de prueba en Villa María, Córdoba',
    'Bv. España 1000, Villa María, Córdoba',
    -32.4094, -63.2432,
    UNHEX('11111111111111111111111111111111'),
    'EDIFICIO', 0, NOW(6)
),
(
    UNHEX(REPLACE('b1000000-0000-4000-8000-000000000002', '-', '')),
    'Edificio Nueva Córdoba',
    'Torre con departamentos en Nueva Córdoba, Córdoba Capital',
    'Av. Hipólito Yrigoyen 450, Córdoba Capital',
    -31.4265, -64.1865,
    UNHEX('11111111111111111111111111111111'),
    'EDIFICIO', 0, NOW(6)
),
(
    UNHEX(REPLACE('b1000000-0000-4000-8000-000000000003', '-', '')),
    'Torre Palermo Soho',
    'Edificio con amenities en Palermo, CABA',
    'Honduras 4800, Palermo, CABA',
    -34.5889, -58.4258,
    UNHEX('11111111111111111111111111111111'),
    'EDIFICIO', 0, NOW(6)
);

INSERT IGNORE INTO buildings_images (buildings_building_id, images_url) VALUES
(UNHEX(REPLACE('b1000000-0000-4000-8000-000000000001', '-', '')), 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=1200&q=80'),
(UNHEX(REPLACE('b1000000-0000-4000-8000-000000000001', '-', '')), 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=1200&q=80'),
(UNHEX(REPLACE('b1000000-0000-4000-8000-000000000002', '-', '')), 'https://images.unsplash.com/photo-1460317441624-23cfa11eb17a?w=1200&q=80'),
(UNHEX(REPLACE('b1000000-0000-4000-8000-000000000002', '-', '')), 'https://images.unsplash.com/photo-1486325212027-8081e4854094?w=1200&q=80'),
(UNHEX(REPLACE('b1000000-0000-4000-8000-000000000003', '-', '')), 'https://images.unsplash.com/photo-1493809842364-78817add7ffb?w=1200&q=80'),
(UNHEX(REPLACE('b1000000-0000-4000-8000-000000000003', '-', '')), 'https://images.unsplash.com/photo-1582407947304-fd86f028f716?w=1200&q=80');

-- ===================== CASAS (independientes) =====================
INSERT IGNORE INTO properties (
    property_id, address, latitude, longitude, building_building_id,
    property_type, price, description, title, floor, bedrooms, bathrooms,
    pets_allowed, apartment_number, user_user_id, furnishing, expenses, deleted, created_at
) VALUES
-- Villa María
(UNHEX(REPLACE('a1000000-0000-4000-8000-000000000001', '-', '')),
 'Bv. España 1500, Villa María, Córdoba', -32.4097, -63.2428, NULL,
 1, 185000, 'Casa independiente con patio en zona céntrica de Villa María.',
 'Casa 3 ambientes — Villa María', NULL, 3, 2, 1, NULL,
 UNHEX('11111111111111111111111111111111'), 0, 0, 0, NOW(6)),
(UNHEX(REPLACE('a1000000-0000-4000-8000-000000000002', '-', '')),
 'Calle Mendoza 220, Villa María, Córdoba', -32.4112, -63.2491, NULL,
 1, 240000, 'Casa con jardín y cochera en barrio residencial.',
 'Casa 4 ambientes con jardín — Villa María', NULL, 4, 2, 1, NULL,
 UNHEX('11111111111111111111111111111111'), 1, 0, 0, NOW(6)),
(UNHEX(REPLACE('a1000000-0000-4000-8000-000000000003', '-', '')),
 'Av. Sabattini 890, Villa María, Córdoba', -32.4158, -63.2405, NULL,
 1, 160000, 'Casa luminosa cerca del centro comercial.',
 'Casa 2 ambientes — Villa María', NULL, 2, 1, 0, NULL,
 UNHEX('11111111111111111111111111111111'), 0, 0, 0, NOW(6)),
-- Córdoba Capital
(UNHEX(REPLACE('a1000000-0000-4000-8000-000000000004', '-', '')),
 'Calle Obispo Trejo 850, Córdoba Capital', -31.4165, -64.1836, NULL,
 1, 320000, 'Casa céntrica en Córdoba Capital, ideal para familia.',
 'Casa 4 ambientes — Córdoba Capital', NULL, 4, 3, 1, NULL,
 UNHEX('11111111111111111111111111111111'), 1, 0, 0, NOW(6)),
(UNHEX(REPLACE('a1000000-0000-4000-8000-000000000005', '-', '')),
 'Av. Colón 1850, Córdoba Capital', -31.4089, -64.1982, NULL,
 1, 280000, 'Casa con patio y parrilla en zona Norte.',
 'Casa 3 ambientes con patio — Córdoba Capital', NULL, 3, 2, 1, NULL,
 UNHEX('11111111111111111111111111111111'), 0, 0, 0, NOW(6)),
(UNHEX(REPLACE('a1000000-0000-4000-8000-000000000006', '-', '')),
 'Calle Duarte Quirós 2100, Córdoba Capital', -31.4201, -64.2015, NULL,
 1, 210000, 'Casa reciclada en barrio residencial de Córdoba.',
 'Casa 2 ambientes reciclada — Córdoba Capital', NULL, 2, 1, 0, NULL,
 UNHEX('11111111111111111111111111111111'), 1, 0, 0, NOW(6)),
-- CABA
(UNHEX(REPLACE('a1000000-0000-4000-8000-000000000007', '-', '')),
 'Av. Cabildo 2800, Belgrano, CABA', -34.5621, -58.4563, NULL,
 1, 450000, 'Casa en Belgrano con terraza y cochera.',
 'Casa 4 ambientes — Belgrano, CABA', NULL, 4, 3, 1, NULL,
 UNHEX('11111111111111111111111111111111'), 1, 0, 0, NOW(6)),
(UNHEX(REPLACE('a1000000-0000-4000-8000-000000000008', '-', '')),
 'Calle Conde 1250, Colegiales, CABA', -34.5755, -58.4492, NULL,
 1, 390000, 'Casa PH reciclada en Colegiales.',
 'Casa 3 ambientes PH — Colegiales, CABA', NULL, 3, 2, 1, NULL,
 UNHEX('11111111111111111111111111111111'), 0, 0, 0, NOW(6)),
(UNHEX(REPLACE('a1000000-0000-4000-8000-000000000009', '-', '')),
 'Calle Fray Justo Santa María de Oro 2400, Palermo, CABA', -34.5832, -58.4215, NULL,
 1, 520000, 'Casa estilo PH en Palermo con patio interno.',
 'Casa 3 ambientes — Palermo, CABA', NULL, 3, 2, 0, NULL,
 UNHEX('11111111111111111111111111111111'), 1, 0, 0, NOW(6));

-- Imágenes casas (1–2 por propiedad)
INSERT IGNORE INTO properties_images (properties_property_id, images_url) VALUES
(UNHEX(REPLACE('a1000000-0000-4000-8000-000000000001', '-', '')), 'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=1200&q=80'),
(UNHEX(REPLACE('a1000000-0000-4000-8000-000000000001', '-', '')), 'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?w=1200&q=80'),
(UNHEX(REPLACE('a1000000-0000-4000-8000-000000000002', '-', '')), 'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=1200&q=80'),
(UNHEX(REPLACE('a1000000-0000-4000-8000-000000000003', '-', '')), 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=1200&q=80'),
(UNHEX(REPLACE('a1000000-0000-4000-8000-000000000004', '-', '')), 'https://images.unsplash.com/photo-1600047509807-ba8f99d2cd0c?w=1200&q=80'),
(UNHEX(REPLACE('a1000000-0000-4000-8000-000000000004', '-', '')), 'https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?w=1200&q=80'),
(UNHEX(REPLACE('a1000000-0000-4000-8000-000000000005', '-', '')), 'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=1200&q=80'),
(UNHEX(REPLACE('a1000000-0000-4000-8000-000000000006', '-', '')), 'https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=1200&q=80'),
(UNHEX(REPLACE('a1000000-0000-4000-8000-000000000007', '-', '')), 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=1200&q=80'),
(UNHEX(REPLACE('a1000000-0000-4000-8000-000000000008', '-', '')), 'https://images.unsplash.com/photo-1580587771525-78b9eaa60c84?w=1200&q=80'),
(UNHEX(REPLACE('a1000000-0000-4000-8000-000000000009', '-', '')), 'https://images.unsplash.com/photo-1568605114967-8130f3a36994?w=1200&q=80');

-- ===================== DEPARTAMENTOS EN EDIFICIOS =====================
INSERT IGNORE INTO properties (
    property_id, address, latitude, longitude, building_building_id,
    property_type, price, description, title, floor, bedrooms, bathrooms,
    pets_allowed, apartment_number, user_user_id, furnishing, expenses, deleted, created_at
) VALUES
-- Torre Villa María
(UNHEX(REPLACE('a2000000-0000-4000-8000-000000000001', '-', '')),
 'Bv. España 1000, Depto 3A, Villa María, Córdoba', -32.4094, -63.2432,
 UNHEX(REPLACE('b1000000-0000-4000-8000-000000000001', '-', '')),
 0, 95000, 'Departamento luminoso en Torre Villa María.',
 'Depto 2 ambientes — Torre Villa María', 3, 2, 1, 1, '3A',
 UNHEX('11111111111111111111111111111111'), 1, 1, 0, NOW(6)),
(UNHEX(REPLACE('a2000000-0000-4000-8000-000000000002', '-', '')),
 'Bv. España 1000, Depto 5B, Villa María, Córdoba', -32.4094, -63.2432,
 UNHEX(REPLACE('b1000000-0000-4000-8000-000000000001', '-', '')),
 0, 125000, 'Departamento amplio con balcón.',
 'Depto 3 ambientes — Torre Villa María', 5, 3, 2, 0, '5B',
 UNHEX('11111111111111111111111111111111'), 0, 1, 0, NOW(6)),
(UNHEX(REPLACE('a2000000-0000-4000-8000-000000000003', '-', '')),
 'Bv. España 1000, Depto 8C, Villa María, Córdoba', -32.4094, -63.2432,
 UNHEX(REPLACE('b1000000-0000-4000-8000-000000000001', '-', '')),
 0, 78000, 'Monoambiente reciclado con cocina integrada.',
 'Monoambiente — Torre Villa María', 8, 1, 1, 0, '8C',
 UNHEX('11111111111111111111111111111111'), 1, 1, 0, NOW(6)),
-- Edificio Nueva Córdoba
(UNHEX(REPLACE('a2000000-0000-4000-8000-000000000004', '-', '')),
 'Av. Hipólito Yrigoyen 450, Depto 4A, Córdoba Capital', -31.4265, -64.1865,
 UNHEX(REPLACE('b1000000-0000-4000-8000-000000000002', '-', '')),
 0, 145000, 'Departamento en Nueva Córdoba cerca de la UNC.',
 'Depto 2 ambientes — Nueva Córdoba', 4, 2, 1, 1, '4A',
 UNHEX('11111111111111111111111111111111'), 1, 1, 0, NOW(6)),
(UNHEX(REPLACE('a2000000-0000-4000-8000-000000000005', '-', '')),
 'Av. Hipólito Yrigoyen 450, Depto 10B, Córdoba Capital', -31.4265, -64.1865,
 UNHEX(REPLACE('b1000000-0000-4000-8000-000000000002', '-', '')),
 0, 195000, 'Departamento con vista a las sierras.',
 'Depto 3 ambientes — Nueva Córdoba', 10, 3, 2, 0, '10B',
 UNHEX('11111111111111111111111111111111'), 0, 1, 0, NOW(6)),
(UNHEX(REPLACE('a2000000-0000-4000-8000-000000000006', '-', '')),
 'Av. Hipólito Yrigoyen 450, Depto 2C, Córdoba Capital', -31.4265, -64.1865,
 UNHEX(REPLACE('b1000000-0000-4000-8000-000000000002', '-', '')),
 0, 110000, 'Departamento amoblado listo para mudarse.',
 'Depto 2 ambientes amoblado — Nueva Córdoba', 2, 2, 1, 1, '2C',
 UNHEX('11111111111111111111111111111111'), 1, 1, 0, NOW(6)),
-- Torre Palermo Soho CABA
(UNHEX(REPLACE('a2000000-0000-4000-8000-000000000007', '-', '')),
 'Honduras 4800, Depto 6A, Palermo, CABA', -34.5889, -58.4258,
 UNHEX(REPLACE('b1000000-0000-4000-8000-000000000003', '-', '')),
 0, 280000, 'Departamento en Palermo Soho con amenities.',
 'Depto 2 ambientes — Palermo Soho', 6, 2, 1, 1, '6A',
 UNHEX('11111111111111111111111111111111'), 1, 1, 0, NOW(6)),
(UNHEX(REPLACE('a2000000-0000-4000-8000-000000000008', '-', '')),
 'Honduras 4800, Depto 12B, Palermo, CABA', -34.5889, -58.4258,
 UNHEX(REPLACE('b1000000-0000-4000-8000-000000000003', '-', '')),
 0, 350000, 'Departamento premium con terraza privada.',
 'Depto 3 ambientes premium — Palermo', 12, 3, 2, 0, '12B',
 UNHEX('11111111111111111111111111111111'), 1, 1, 0, NOW(6)),
(UNHEX(REPLACE('a2000000-0000-4000-8000-000000000009', '-', '')),
 'Honduras 4800, Depto 3C, Palermo, CABA', -34.5889, -58.4258,
 UNHEX(REPLACE('b1000000-0000-4000-8000-000000000003', '-', '')),
 0, 210000, 'Monoambiente amplio con balcón a la calle.',
 'Monoambiente con balcón — Palermo', 3, 1, 1, 1, '3C',
 UNHEX('11111111111111111111111111111111'), 0, 1, 0, NOW(6));

INSERT IGNORE INTO properties_images (properties_property_id, images_url) VALUES
(UNHEX(REPLACE('a2000000-0000-4000-8000-000000000001', '-', '')), 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=1200&q=80'),
(UNHEX(REPLACE('a2000000-0000-4000-8000-000000000002', '-', '')), 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=1200&q=80'),
(UNHEX(REPLACE('a2000000-0000-4000-8000-000000000003', '-', '')), 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=1200&q=80'),
(UNHEX(REPLACE('a2000000-0000-4000-8000-000000000004', '-', '')), 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=1200&q=80'),
(UNHEX(REPLACE('a2000000-0000-4000-8000-000000000005', '-', '')), 'https://images.unsplash.com/photo-1536376072261-38c75010e6c9?w=1200&q=80'),
(UNHEX(REPLACE('a2000000-0000-4000-8000-000000000006', '-', '')), 'https://images.unsplash.com/photo-1554995207-c18c203602cb?w=1200&q=80'),
(UNHEX(REPLACE('a2000000-0000-4000-8000-000000000007', '-', '')), 'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?w=1200&q=80'),
(UNHEX(REPLACE('a2000000-0000-4000-8000-000000000008', '-', '')), 'https://images.unsplash.com/photo-1630699144867-37acec97df5e?w=1200&q=80'),
(UNHEX(REPLACE('a2000000-0000-4000-8000-000000000009', '-', '')), 'https://images.unsplash.com/photo-1616594039964-ae9021a400a0?w=1200&q=80');
