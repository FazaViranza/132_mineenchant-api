-- ============================================
-- MINEENCHANT API DATABASE SCHEMA
-- ============================================

-- USERS TABLE
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- API KEYS TABLE
CREATE TABLE api_keys (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    api_key VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(100) DEFAULT 'Default API Key',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE
);


-- ENCHANTMENTS TABLE
CREATE TABLE enchantments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT NOT NULL,
    max_level INTEGER NOT NULL,
    is_curse BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- CATEGORIES TABLE
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);


-- ITEMS TABLE
CREATE TABLE items (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    item_type VARCHAR(50) NOT NULL,
    description TEXT
);


-- ENCHANTMENT CATEGORIES
CREATE TABLE enchantment_categories (
    id SERIAL PRIMARY KEY,
    enchantment_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,

    CONSTRAINT fk_enchantment_category
        FOREIGN KEY (enchantment_id)
        REFERENCES enchantments(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_category
        FOREIGN KEY (category_id)
        REFERENCES categories(id)
        ON DELETE CASCADE,

    UNIQUE(enchantment_id, category_id)
);


-- ENCHANTMENT ITEMS
CREATE TABLE enchantment_items (
    id SERIAL PRIMARY KEY,
    enchantment_id INTEGER NOT NULL,
    item_id INTEGER NOT NULL,

    CONSTRAINT fk_enchantment_item
        FOREIGN KEY (enchantment_id)
        REFERENCES enchantments(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_item
        FOREIGN KEY (item_id)
        REFERENCES items(id)
        ON DELETE CASCADE,

    UNIQUE(enchantment_id, item_id)
);