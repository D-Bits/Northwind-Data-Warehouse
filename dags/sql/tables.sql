/**
* Queries to build tables for a Northwind 
* data warehouse.
**/


-- Fact table for product data
CREATE TABLE dim_products
(
	id SERIAL PRIMARY KEY,
	unitsinstock INT,
	unitsinorder INT,
	reorderlevel INT,
	discontinued INT
);

-- Fact table for order data 
CREATE TABLE fact_orders
(
	-- From orders table
	id SERIAL PRIMARY KEY,
	order_id INT,
	customer_id INT,
	employeeid INT,
	productid INT NOT NULL REFERENCES dim_products(id),
	requireddate DATE,
	orderdate DATE,
	shippeddate DATE, 
	shipvia INT,
	freight INT,
	shipname VARCHAR(255),
	shipaddress VARCHAR(255),
	shipcity VARCHAR(255),
	shipregion VARCHAR(4),
	shippostalcode VARCHAR(10),
	shipcountry VARCHAR(15),
	-- From order_details table
	unitprice FLOAT,
	quantity INT,
	discount INT
);
