CREATE TABLE peeps (id SERIAL PRIMARY KEY, message VARCHAR(240) NOT NULL, created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP);
