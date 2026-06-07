-- ============================================================
--  MI CARTERA — Supabase Setup
--  Ejecuta este script en el SQL Editor de tu proyecto Supabase
-- ============================================================

-- 1. Tabla de usuarios (roles y contraseñas)
CREATE TABLE IF NOT EXISTS cartera_usuarios (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  usuario text UNIQUE NOT NULL,
  password_hash text NOT NULL,
  rol text NOT NULL CHECK (rol IN ('supervisor','admin')),
  created_at timestamptz DEFAULT now()
);

-- 2. Tabla de registros (préstamos y ventas)
CREATE TABLE IF NOT EXISTS cartera_registros (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  tipo text NOT NULL CHECK (tipo IN ('venta','prestamo')),
  nombre text NOT NULL,
  cedula text,
  dir text,
  tel text,
  ciudad text,
  monto numeric NOT NULL,
  total numeric NOT NULL,
  productos jsonb,
  modalidad text,
  cuotas integer,
  inicio date,
  vence date,
  notas text,
  pdf_base64 text,
  created_at timestamptz DEFAULT now(),
  created_by text
);

-- 3. Tabla de pagos/abonos
CREATE TABLE IF NOT EXISTS cartera_pagos (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  registro_id bigint REFERENCES cartera_registros(id) ON DELETE CASCADE,
  monto numeric NOT NULL,
  fecha date NOT NULL DEFAULT CURRENT_DATE,
  medio_pago text DEFAULT 'efectivo',
  registrado_por text,
  created_at timestamptz DEFAULT now()
);

-- 4. Tabla de configuración del negocio
CREATE TABLE IF NOT EXISTS cartera_config (
  id int DEFAULT 1 PRIMARY KEY,
  negocio text,
  nombre text,
  tel text,
  ciudad text,
  slogan text,
  logo_base64 text,
  updated_at timestamptz DEFAULT now()
);

-- 5. Habilitar RLS
ALTER TABLE cartera_usuarios  ENABLE ROW LEVEL SECURITY;
ALTER TABLE cartera_registros ENABLE ROW LEVEL SECURITY;
ALTER TABLE cartera_pagos     ENABLE ROW LEVEL SECURITY;
ALTER TABLE cartera_config    ENABLE ROW LEVEL SECURITY;

-- 6. Políticas RLS — acceso público con anon key
CREATE POLICY "anon_all_usuarios"  ON cartera_usuarios  FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "anon_all_registros" ON cartera_registros FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "anon_all_pagos"     ON cartera_pagos     FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "anon_all_config"    ON cartera_config    FOR ALL TO anon USING (true) WITH CHECK (true);

-- 7. GRANT permisos
GRANT ALL ON cartera_usuarios  TO anon;
GRANT ALL ON cartera_registros TO anon;
GRANT ALL ON cartera_pagos     TO anon;
GRANT ALL ON cartera_config    TO anon;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO anon;

-- Usuarios del sistema
INSERT INTO cartera_usuarios (usuario, password_hash, rol) VALUES
  ('1045748984', 'avitola02', 'admin'),
  ('1047035857', 'svitola30', 'supervisor')
ON CONFLICT (usuario) DO NOTHING;

-- 9. Config inicial
INSERT INTO cartera_config (id) VALUES (1) ON CONFLICT (id) DO NOTHING;

-- ── ACTUALIZACIÓN: agregar columna medio_pago si no existe
ALTER TABLE cartera_pagos ADD COLUMN IF NOT EXISTS medio_pago text DEFAULT 'efectivo';

-- ── ACTUALIZACIÓN: invertir roles
UPDATE cartera_usuarios SET rol='admin' WHERE usuario='1045748984';
UPDATE cartera_usuarios SET rol='supervisor' WHERE usuario='1047035857';

-- ── ACTUALIZACIÓN: agregar columna dia_pago
ALTER TABLE cartera_registros ADD COLUMN IF NOT EXISTS dia_pago integer;

ALTER TABLE cartera_registros ADD COLUMN IF NOT EXISTS rentabilidad integer DEFAULT 20;
