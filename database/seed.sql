-- ============================================
-- MINEENCHANT API SEED DATA
-- ============================================


-- ============================================
-- CATEGORIES
-- ============================================

INSERT INTO categories (name, description) VALUES
('All Purpose', 'Enchantments that can be applied to multiple types of equipment.'),
('Armor', 'Enchantments designed for armor and wearable equipment.'),
('Melee Weapons', 'Enchantments for close-range weapons.'),
('Ranged Weapons', 'Enchantments for bows, crossbows, and tridents.'),
('Tools', 'Enchantments designed for mining and utility tools.');


-- ============================================
-- ITEMS
-- ============================================

INSERT INTO items (name, item_type, description) VALUES
('Pickaxe', 'Tool', 'Used for mining stone and ores.'),
('Axe', 'Tool / Weapon', 'Used for chopping wood and melee combat.'),
('Shovel', 'Tool', 'Used for digging dirt, sand, and gravel.'),
('Hoe', 'Tool', 'Used for farming and breaking certain blocks.'),
('Shears', 'Tool', 'Used for shearing sheep and collecting specific blocks.'),

('Sword', 'Melee Weapon', 'Used for close-range combat.'),
('Mace', 'Melee Weapon', 'Heavy melee weapon that deals increased damage while falling.'),

('Bow', 'Ranged Weapon', 'Ranged weapon that shoots arrows.'),
('Crossbow', 'Ranged Weapon', 'Ranged weapon with chargeable projectiles.'),
('Trident', 'Ranged / Melee Weapon', 'Weapon that can be thrown or used in melee combat.'),

('Helmet', 'Armor', 'Protective equipment worn on the head.'),
('Chestplate', 'Armor', 'Protective equipment worn on the chest.'),
('Leggings', 'Armor', 'Protective equipment worn on the legs.'),
('Boots', 'Armor', 'Protective equipment worn on the feet.'),

('Elytra', 'Wearable', 'Allows the player to glide through the air.'),
('Fishing Rod', 'Tool', 'Used for fishing and catching aquatic loot.');

-- ============================================
-- ENCHANTMENTS
-- ============================================

INSERT INTO enchantments
(name, description, max_level, is_curse)
VALUES

-- ALL PURPOSE
('Mending', 'Repairs the item when gaining XP orbs.', 1, FALSE),
('Unbreaking', 'Increases item durability.', 3, FALSE),
('Curse of Vanishing', 'Item is destroyed upon death.', 1, TRUE),

-- ARMOR
('Aqua Affinity', 'Increases underwater mining speed.', 1, FALSE),
('Blast Protection', 'Reduces explosion damage and knockback.', 4, FALSE),
('Curse of Binding', 'Items cannot be removed from armor slots unless the player dies or the item breaks.', 1, TRUE),
('Depth Strider', 'Increases underwater movement speed.', 3, FALSE),
('Feather Falling', 'Reduces fall damage.', 4, FALSE),
('Fire Protection', 'Reduces fire damage and burn time.', 4, FALSE),
('Frost Walker', 'Turns water beneath the player into frosted ice and provides protection from magma block damage.', 2, FALSE),
('Projectile Protection', 'Reduces projectile damage.', 4, FALSE),
('Protection', 'Reduces most types of damage.', 4, FALSE),
('Respiration', 'Extends underwater breathing time.', 3, FALSE),
('Soul Speed', 'Increases movement speed on soul sand and soul soil.', 3, FALSE),
('Thorns', 'Reflects some damage back to attackers at the cost of durability.', 3, FALSE),
('Swift Sneak', 'Increases movement speed while crouching.', 3, FALSE),

-- MELEE WEAPONS
('Bane of Arthropods', 'Increases damage and applies Slowness to arthropod mobs.', 5, FALSE),
('Breach', 'Reduces the effectiveness of enemy armor.', 4, FALSE),
('Density', 'Increases mace damage while falling.', 5, FALSE),
('Efficiency', 'Increases mining speed and provides additional effects when applied to certain weapons.', 5, FALSE),
('Fire Aspect', 'Sets the target on fire.', 2, FALSE),
('Looting', 'Increases the amount of loot dropped by mobs.', 3, FALSE),
('Lunge', 'Provides a burst of speed when using a spear attack.', 3, FALSE),
('Impaling', 'Increases trident damage against certain aquatic mobs.', 5, FALSE),
('Knockback', 'Knocks targets away when hit.', 2, FALSE),
('Sharpness', 'Increases weapon damage.', 5, FALSE),
('Smite', 'Increases damage against undead mobs.', 5, FALSE),
('Sweeping Edge', 'Increases sweeping attack damage.', 3, FALSE),
('Wind Burst', 'Launches the player upward after a successful mace hit.', 3, FALSE),

-- RANGED WEAPONS
('Channeling', 'Summons lightning when a trident hits an entity during a thunderstorm.', 1, FALSE),
('Flame', 'Sets targets on fire when hit by arrows.', 1, FALSE),
('Infinity', 'Allows arrows to be used without consuming them.', 1, FALSE),
('Loyalty', 'Causes a thrown trident to return to the player.', 3, FALSE),
('Riptide', 'Launches the player with a trident when used in water or rain.', 3, FALSE),
('Multishot', 'Fires three projectiles while consuming only one.', 1, FALSE),
('Piercing', 'Allows crossbow projectiles to pass through multiple entities.', 4, FALSE),
('Power', 'Increases arrow damage.', 5, FALSE),
('Punch', 'Increases arrow knockback.', 2, FALSE),
('Quick Charge', 'Decreases crossbow charging time.', 3, FALSE),

-- TOOLS
('Fortune', 'Increases certain item drop chances from blocks.', 3, FALSE),
('Luck of the Sea', 'Increases the chance of catching valuable fishing loot.', 3, FALSE),
('Lure', 'Decreases the waiting time for fish or loot to bite.', 3, FALSE),
('Silk Touch', 'Causes mined blocks to drop themselves instead of their normal drops.', 1, FALSE);


SELECT * FROM categories;
SELECT * FROM items;
SELECT * FROM enchantments;

-- ============================================
-- ENCHANTMENT ↔ CATEGORY RELATIONSHIPS
-- ============================================

-- All Purpose
INSERT INTO enchantment_categories (enchantment_id, category_id)
SELECT e.id, c.id
FROM enchantments e, categories c
WHERE e.name IN (
    'Mending',
    'Unbreaking',
    'Curse of Vanishing'
)
AND c.name = 'All Purpose';


-- Armor
INSERT INTO enchantment_categories (enchantment_id, category_id)
SELECT e.id, c.id
FROM enchantments e, categories c
WHERE e.name IN (
    'Aqua Affinity',
    'Blast Protection',
    'Curse of Binding',
    'Depth Strider',
    'Feather Falling',
    'Fire Protection',
    'Frost Walker',
    'Projectile Protection',
    'Protection',
    'Respiration',
    'Soul Speed',
    'Thorns',
    'Swift Sneak'
)
AND c.name = 'Armor';


-- Melee Weapons
INSERT INTO enchantment_categories (enchantment_id, category_id)
SELECT e.id, c.id
FROM enchantments e, categories c
WHERE e.name IN (
    'Bane of Arthropods',
    'Breach',
    'Density',
    'Efficiency',
    'Fire Aspect',
    'Looting',
    'Lunge',
    'Impaling',
    'Knockback',
    'Sharpness',
    'Smite',
    'Sweeping Edge',
    'Wind Burst'
)
AND c.name = 'Melee Weapons';


-- Ranged Weapons
INSERT INTO enchantment_categories (enchantment_id, category_id)
SELECT e.id, c.id
FROM enchantments e, categories c
WHERE e.name IN (
    'Channeling',
    'Flame',
    'Impaling',
    'Infinity',
    'Loyalty',
    'Riptide',
    'Multishot',
    'Piercing',
    'Power',
    'Punch',
    'Quick Charge'
)
AND c.name = 'Ranged Weapons';


-- Tools
INSERT INTO enchantment_categories (enchantment_id, category_id)
SELECT e.id, c.id
FROM enchantments e, categories c
WHERE e.name IN (
    'Efficiency',
    'Fortune',
    'Luck of the Sea',
    'Lure',
    'Silk Touch'
)
AND c.name = 'Tools';

SELECT COUNT(*) FROM enchantment_categories;






-- ============================================
-- ENCHANTMENT ↔ ITEM RELATIONSHIPS
-- ============================================


-- ============================================
-- ALL PURPOSE ENCHANTMENTS
-- ============================================

-- Mending -> almost all supported equipment
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Mending'
AND i.name IN (
    'Pickaxe', 'Axe', 'Shovel', 'Hoe', 'Shears',
    'Sword', 'Mace',
    'Bow', 'Crossbow', 'Trident',
    'Helmet', 'Chestplate', 'Leggings', 'Boots',
    'Elytra', 'Fishing Rod'
);


-- Unbreaking -> almost all supported equipment
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Unbreaking'
AND i.name IN (
    'Pickaxe', 'Axe', 'Shovel', 'Hoe', 'Shears',
    'Sword', 'Mace',
    'Bow', 'Crossbow', 'Trident',
    'Helmet', 'Chestplate', 'Leggings', 'Boots',
    'Elytra', 'Fishing Rod'
);


-- Curse of Vanishing
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Curse of Vanishing'
AND i.name IN (
    'Pickaxe', 'Axe', 'Shovel', 'Hoe', 'Shears',
    'Sword', 'Mace',
    'Bow', 'Crossbow', 'Trident',
    'Helmet', 'Chestplate', 'Leggings', 'Boots',
    'Elytra', 'Fishing Rod'
);


-- ============================================
-- ARMOR ENCHANTMENTS
-- ============================================

-- Aqua Affinity
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Aqua Affinity'
AND i.name = 'Helmet';


-- Blast Protection
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Blast Protection'
AND i.name IN ('Helmet', 'Chestplate', 'Leggings', 'Boots');


-- Curse of Binding
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Curse of Binding'
AND i.name IN ('Helmet', 'Chestplate', 'Leggings', 'Boots', 'Elytra');


-- Depth Strider
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Depth Strider'
AND i.name = 'Boots';


-- Feather Falling
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Feather Falling'
AND i.name = 'Boots';


-- Fire Protection
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Fire Protection'
AND i.name IN ('Helmet', 'Chestplate', 'Leggings', 'Boots');


-- Frost Walker
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Frost Walker'
AND i.name = 'Boots';


-- Projectile Protection
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Projectile Protection'
AND i.name IN ('Helmet', 'Chestplate', 'Leggings', 'Boots');


-- Protection
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Protection'
AND i.name IN ('Helmet', 'Chestplate', 'Leggings', 'Boots');


-- Respiration
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Respiration'
AND i.name = 'Helmet';


-- Soul Speed
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Soul Speed'
AND i.name = 'Boots';


-- Thorns
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Thorns'
AND i.name IN ('Helmet', 'Chestplate', 'Leggings', 'Boots');


-- Swift Sneak
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Swift Sneak'
AND i.name = 'Leggings';


-- ============================================
-- MELEE WEAPONS
-- ============================================

-- Bane of Arthropods
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Bane of Arthropods'
AND i.name IN ('Sword', 'Axe');


-- Breach
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Breach'
AND i.name = 'Mace';


-- Density
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Density'
AND i.name = 'Mace';


-- Efficiency
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Efficiency'
AND i.name IN ('Pickaxe', 'Axe', 'Shovel', 'Hoe', 'Shears');


-- Fire Aspect
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Fire Aspect'
AND i.name IN ('Sword', 'Axe');


-- Looting
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Looting'
AND i.name IN ('Sword', 'Axe');


-- Impaling
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Impaling'
AND i.name = 'Trident';


-- Knockback
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Knockback'
AND i.name = 'Sword';


-- Sharpness
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Sharpness'
AND i.name IN ('Sword', 'Axe');


-- Smite
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Smite'
AND i.name IN ('Sword', 'Axe');


-- Sweeping Edge
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Sweeping Edge'
AND i.name = 'Sword';


-- Wind Burst
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Wind Burst'
AND i.name = 'Mace';


-- ============================================
-- RANGED WEAPONS
-- ============================================

-- Channeling
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Channeling'
AND i.name = 'Trident';


-- Flame
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Flame'
AND i.name = 'Bow';


-- Infinity
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Infinity'
AND i.name = 'Bow';


-- Loyalty
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Loyalty'
AND i.name = 'Trident';


-- Riptide
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Riptide'
AND i.name = 'Trident';


-- Multishot
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Multishot'
AND i.name = 'Crossbow';


-- Piercing
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Piercing'
AND i.name = 'Crossbow';


-- Power
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Power'
AND i.name = 'Bow';


-- Punch
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Punch'
AND i.name = 'Bow';


-- Quick Charge
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Quick Charge'
AND i.name = 'Crossbow';


-- ============================================
-- TOOLS
-- ============================================

-- Fortune
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Fortune'
AND i.name IN ('Pickaxe', 'Axe', 'Shovel', 'Hoe');


-- Luck of the Sea
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Luck of the Sea'
AND i.name = 'Fishing Rod';


-- Lure
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Lure'
AND i.name = 'Fishing Rod';


-- Silk Touch
INSERT INTO enchantment_items (enchantment_id, item_id)
SELECT e.id, i.id
FROM enchantments e, items i
WHERE e.name = 'Silk Touch'
AND i.name IN ('Pickaxe', 'Axe', 'Shovel', 'Hoe');

SELECT COUNT(*) FROM enchantment_items;