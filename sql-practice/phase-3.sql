
-- 1. Rachel joins
INSERT INTO customers (name, phone)
VALUES ('Rachel', '1111111111');

-- Rachel buys 1 coffee
UPDATE customers SET points = points + 1 WHERE name = 'Rachel';
INSERT INTO coffee_orders (is_redeemed) VALUES (0);

-- 2. Monica and Phoebe join
INSERT INTO customers (name, email, phone)
VALUES ('Monica', 'monica@friends.show', '2222222222');

INSERT INTO customers (name, email, phone)
VALUES ('Phoebe', 'phoebe@friends.show', '3333333333');

-- Phoebe buys 3 coffees
UPDATE customers SET points = points + 3 WHERE name = 'Phoebe';
INSERT INTO coffee_orders (is_redeemed) VALUES (0);
INSERT INTO coffee_orders (is_redeemed) VALUES (0);
INSERT INTO coffee_orders (is_redeemed) VALUES (0);

-- 3. Rachel and Monica buy 4 coffees each
UPDATE customers SET points = points + 4 WHERE name = 'Rachel';
UPDATE customers SET points = points + 4 WHERE name = 'Monica';

INSERT INTO coffee_orders (is_redeemed) VALUES (0);
INSERT INTO coffee_orders (is_redeemed) VALUES (0);
INSERT INTO coffee_orders (is_redeemed) VALUES (0);
INSERT INTO coffee_orders (is_redeemed) VALUES (0);

INSERT INTO coffee_orders (is_redeemed) VALUES (0);
INSERT INTO coffee_orders (is_redeemed) VALUES (0);
INSERT INTO coffee_orders (is_redeemed) VALUES (0);
INSERT INTO coffee_orders (is_redeemed) VALUES (0);

-- 4. Monica checks points
SELECT points FROM customers WHERE name = 'Monica';

-- 5. Rachel checks points and redeems if possible
UPDATE customers SET points = points - 10 WHERE name = 'Rachel' AND points >= 10;
INSERT INTO coffee_orders (is_redeemed) VALUES (1);

-- 6. Joey, Chandler, Ross join
INSERT INTO customers (name, email)
VALUES ('Joey', 'joey@friends.show');

INSERT INTO customers (name, email)
VALUES ('Chandler', 'chandler@friends.show');

INSERT INTO customers (name, email)
VALUES ('Ross', 'ross@friends.show');

-- Ross buys 6 coffees
UPDATE customers SET points = points + 6 WHERE name = 'Ross';
INSERT INTO coffee_orders (is_redeemed) VALUES (0);
INSERT INTO coffee_orders (is_redeemed) VALUES (0);
INSERT INTO coffee_orders (is_redeemed) VALUES (0);
INSERT INTO coffee_orders (is_redeemed) VALUES (0);
INSERT INTO coffee_orders (is_redeemed) VALUES (0);
INSERT INTO coffee_orders (is_redeemed) VALUES (0);

-- 7. Monica buys 3 coffees
UPDATE customers SET points = points + 3 WHERE name = 'Monica';
INSERT INTO coffee_orders (is_redeemed) VALUES (0);
INSERT INTO coffee_orders (is_redeemed) VALUES (0);
INSERT INTO coffee_orders (is_redeemed) VALUES (0);

-- 8. Phoebe checks points and redeems
UPDATE customers SET points = points - 10 WHERE name = 'Phoebe' AND points >= 10;
INSERT INTO coffee_orders (is_redeemed) VALUES (1);

-- 9. Ross refunds last 2 coffees
DELETE FROM coffee_orders
WHERE id IN (
  SELECT id FROM coffee_orders
  ORDER BY id DESC
  LIMIT 2
);

UPDATE customers SET points = points - 2 WHERE name = 'Ross';

-- 10. Joey buys 2 coffees
UPDATE customers SET points = points + 2 WHERE name = 'Joey';
INSERT INTO coffee_orders (is_redeemed) VALUES (0);
INSERT INTO coffee_orders (is_redeemed) VALUES (0);

-- 11. Monica checks points and redeems if possible
UPDATE customers SET points = points - 10 WHERE name = 'Monica' AND points >= 10;
INSERT INTO coffee_orders (is_redeemed) VALUES (1);

-- 12. Chandler deletes account
DELETE FROM customers WHERE name = 'Chandler';

-- 13. Ross checks points and redeems if possible
UPDATE customers SET points = points - 10 WHERE name = 'Ross' AND points >= 10;
INSERT INTO coffee_orders (is_redeemed) VALUES (1);

-- 14. Joey checks points and redeems if possible
UPDATE customers SET points = points - 10 WHERE name = 'Joey' AND points >= 10;
INSERT INTO coffee_orders (is_redeemed) VALUES (1);

-- 15. Phoebe updates email
UPDATE customers
SET email = 'p_as_in_phoebe@friends.show'
WHERE name = 'Phoebe';