/**
* Queries to build tables for a Northwind 
* data warehouse.
**/


-- Fact table for product data
CREATE TABLE dim_products
(
	id SERIAL PRIMARY KEY,
	unitsinstock INT NOT NULL,
	unitsinorder INT NOT NULL,
	reorderlevel INT,
	discontinued INT NOT NULL
);

-- Fact table for order data 
CREATE TABLE fact_orders
(
	-- From orders table
	id SERIAL PRIMARY KEY,
	order_id INT NOT NULL,
	customer_id INT NOT NULL,
	employeeid INT NOT NULL,
	productid INT NOT NULL REFERENCES dim_products(id),
	requireddate DATE NOT NULL,
	orderdate DATE NOT NULL,
	shippeddate DATE NOT NULL, 
	shipvia INT,
	freight INT,
	shipname VARCHAR(255) NOT NULL,
	shipaddress VARCHAR(255) NOT NULL,
	shipcity VARCHAR(255) NOT NULL,
	shipregion VARCHAR(4),
	shippostalcode VARCHAR(10) NOT NULL,
	shipcountry VARCHAR(15) NOT NULL,
	-- From order_details table
	unitprice FLOAT,
	quantity INT NOT NULL,
	discount INT
);
