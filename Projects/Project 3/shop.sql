-- CLEANUP
DROP TABLE IF EXISTS OrderDetails CASCADE;
DROP TABLE IF EXISTS OrderHeader CASCADE;
DROP TABLE IF EXISTS Cart CASCADE;
DROP TABLE IF EXISTS Users CASCADE;
DROP TABLE IF EXISTS ProductsMenu CASCADE;

DROP FUNCTION IF EXISTS manage_cart(integer, text, integer);

-- CREATE TABLES
CREATE TABLE ProductsMenu (
    Id INT PRIMARY KEY,
    Name VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Users (
    User_ID INT PRIMARY KEY,
    Username VARCHAR(50)
);

CREATE TABLE Cart (
    ProductId INT PRIMARY KEY,
    Qty INT,
    FOREIGN KEY (ProductId) REFERENCES ProductsMenu(Id)
);

CREATE TABLE OrderHeader (
    OrderID INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    User_ID INT,
    OrderDate TIMESTAMP,
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID)
);

CREATE TABLE OrderDetails (
    OrderHeader INT,
    ProdID INT,
    Qty INT,
    FOREIGN KEY (OrderHeader) REFERENCES OrderHeader(OrderID),
    FOREIGN KEY (ProdID) REFERENCES ProductsMenu(Id)
);

-- SAMPLE DATA
INSERT INTO ProductsMenu VALUES (1, 'Coke', 10.00), (2, 'Chips', 5.00);
INSERT INTO Users VALUES (1, 'Arnold'), (2, 'David'), (3, 'Jada');

-- FUNCTION: Manage Cart
CREATE OR REPLACE FUNCTION ManageCart(
    p_product_id INT,
    p_action TEXT,
    p_qty INT DEFAULT 1
)
RETURNS TEXT AS $$
BEGIN 
    IF LOWER(p_action) = 'add' THEN
        -- If product exists, update qty
        UPDATE Cart
        SET Qty = Qty + p_qty
        WHERE ProductId = p_product_id;

        -- If not found, insert new row
        IF NOT FOUND THEN
            INSERT INTO Cart (ProductId, Qty)
            VALUES (p_product_id, p_qty);
        END IF;
        RETURN 'Item added or updated';

    ELSIF LOWER(p_action) = 'remove_one' THEN
        -- Reduce qty if more than 1
        UPDATE Cart
        SET Qty = Qty - 1
        WHERE ProductId = p_product_id AND Qty > 1;

        -- If qty is 1, remove completely
        DELETE FROM Cart
        WHERE ProductId = p_product_id AND Qty = 1;
        RETURN 'Item reduced or removed';

    ELSIF LOWER(p_action) = 'remove_all' THEN
        DELETE FROM Cart
        WHERE ProductId = p_product_id;
        RETURN 'Item removed completely';

    ELSE
        RAISE EXCEPTION 'Invalid action: Use add, remove_one, or remove_all';
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Add items
SELECT ManageCart(1, 'add', 3);        -- Coke
SELECT ManageCart(2, 'add', 2);     -- Chips x2

-- Remove one Coke
SELECT ManageCart(1, 'remove_one');

-- Remove all Chips
SELECT ManageCart(2, 'remove_all');

-- View current cart
SELECT c.ProductId, p.Name, c.Qty
FROM Cart c
JOIN ProductsMenu p ON c.ProductId = p.Id;

-- FUNCTION: Checkout
CREATE OR REPLACE FUNCTION CheckoutCart(p_user_id INT)
RETURNS INT AS $$
DECLARE
    new_order_id INT;
BEGIN
    -- Create order
    INSERT INTO OrderHeader (User_ID, OrderDate)
    VALUES (p_user_id, NOW())
    RETURNING OrderID INTO new_order_id;

    -- Move items from cart to order details
    INSERT INTO OrderDetails (OrderHeader, ProdID, Qty)
    SELECT new_order_id, ProductId, Qty FROM Cart;

    RETURN new_order_id;
END;
$$ LANGUAGE plpgsql;

-- Checkout for User 1
SELECT CheckoutCart(1);

-- View Orders
SELECT * FROM OrderHeader;
SELECT * FROM OrderDetails;

-- View current cart
SELECT c.ProductId, p.Name, c.Qty
FROM Cart c
JOIN ProductsMenu p ON c.ProductId = p.Id;

--Show All Orders with Details
SELECT oh.OrderID,
       oh.User_ID,
       u.Username,
       oh.OrderDate,
       p.Name AS Product,
       od.Qty,
       p.Price,
       (p.Price * od.Qty) AS LineTotal
FROM OrderHeader oh
JOIN Users u ON oh.User_ID = u.User_ID
JOIN OrderDetails od ON oh.OrderID = od.OrderHeader
JOIN ProductsMenu p ON od.ProdID = p.Id
ORDER BY oh.OrderID;

--Show a Single Order by OrderID
SELECT oh.OrderID,
       oh.OrderDate,
       u.Username,
       p.Name,
       od.Qty,
       p.Price,
       (p.Price * od.Qty) AS LineTotal
FROM OrderHeader oh
JOIN Users u ON oh.User_ID = u.User_ID
JOIN OrderDetails od ON oh.OrderID = od.OrderHeader
JOIN ProductsMenu p ON od.ProdID = p.Id
WHERE oh.OrderID = 1; -- Change 1 to the desired order number
   
-- Empty cart
    DELETE FROM Cart;

--BOUNES(ADD)
CREATE OR REPLACE FUNCTION AddCartItem(
    p_product_id INT,
    p_qty INT DEFAULT 1
)
RETURNS TEXT AS $$
BEGIN
    -- If product already exists, increase quantity
    UPDATE Cart
    SET Qty = Qty + p_qty
    WHERE ProductId = p_product_id;

    -- If no rows were updated, insert it
    IF NOT FOUND THEN
        INSERT INTO Cart (ProductId, Qty)
        VALUES (p_product_id, p_qty);
    END IF;

    RETURN 'Item added or updated';
END;
$$ LANGUAGE plpgsql;

--(SUBTRACT)
CREATE OR REPLACE FUNCTION RemoveCartItem(
    p_product_id INT,
    p_qty INT DEFAULT 1
)
RETURNS TEXT AS $$
BEGIN
    -- Reduce quantity if greater than the amount being removed
    UPDATE Cart
    SET Qty = Qty - p_qty
    WHERE ProductId = p_product_id AND Qty > p_qty;

    -- If quantity would become zero or less, delete the item
    DELETE FROM Cart
    WHERE ProductId = p_product_id AND Qty <= p_qty;

    RETURN 'Item reduced or removed completely';
END;
$$ LANGUAGE plpgsql;

-- Add items
SELECT AddCartItem(1, 3);  -- Adds 3 units of Product ID 1
SELECT AddCartItem(2, 1);  -- Adds 1 unit of Product ID 2

-- Remove items
SELECT RemoveCartItem(1, 1); -- Removes 1 unit of Product ID 1
SELECT RemoveCartItem(2, 5); -- Removes all if 5+ requested

SELECT * FROM Cart;




