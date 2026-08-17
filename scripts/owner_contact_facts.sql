-- Vista para reportes Metabase (contactos por dueño de propiedad).
-- Aplicar en MySQL propinq: mysql -u propinq_app -p propinq < owner_contact_facts.sql

CREATE OR REPLACE VIEW owner_contact_facts AS
SELECT
  c.contact_id,
  c.issue_date,
  c.state AS contact_state,
  c.contact_message,
  p.property_id,
  p.title AS property_title,
  p.user_user_id AS owner_id,
  u.email AS owner_email,
  u.first_name AS owner_first_name,
  u.last_name AS owner_last_name
FROM contacts c
INNER JOIN properties p ON c.property_property_id = p.property_id
INNER JOIN users u ON p.user_user_id = u.user_id
WHERE p.deleted = 0 AND u.deleted = 0;
