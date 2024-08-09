-- Query 1: Find a list of customer names who are using the product 'Digital Subscriber Line'
-- Original query:
select "Customer Name" from TELECOM_CUSTOMER where PRODUCT='Digital Subscriber Line';
-- Optimized query:
create index telecom_Customer_name_product_idx on TELECOM_CUSTOMER("Customer Name", product);
select "Customer Name" from TELECOM_CUSTOMER where PRODUCT='Digital Subscriber Line';

-- Query 2: List customerid and customer name whose name starts with 'sa'
-- Original query:
select CUSTOMERID,"Customer Name" from TELECOM_CUSTOMER where "Customer Name" like 'sa%';
-- Optimized query:
create index telecom_Customer_name_idx on TELECOM_CUSTOMER("Customer Name");
select CUSTOMERID,"Customer Name" from TELECOM_CUSTOMER where "Customer Name" like 'sa%';

-- Query 3: List the Customer IDs and names belonging to the gold customer segment
-- Original query:
select CUSTOMERID,"Customer Name" from TELECOM_CUSTOMER where "Service Segment"='Gold';
-- Optimized query:
create index telecom_customerid_servicesegment_idx on TELECOM_CUSTOMER("Service Segment", "CUSTOMERID", "Customer Name");
select CUSTOMERID,"Customer Name" from TELECOM_CUSTOMER where "Service Segment"='Gold';

-- Query 4: Count the Customer list product-wise
-- Original query:
select PRODUCT, count(PRODUCT) from TELECOM_CUSTOMER group by PRODUCT;
-- Optimized query:
CREATE BITMAP INDEX telecom_product_idx ON TELECOM_CUSTOMER(PRODUCT);
select PRODUCT, count(PRODUCT) from TELECOM_CUSTOMER group by PRODUCT;

-- Query 5: List the Customer name of zone = 'Mountain'
-- Original query:
select "Customer Name" from TELECOM_CUSTOMER where ZONE in ('Mountain');
-- Optimized query:
create index telecom_customer_name_zone_idx on TELECOM_CUSTOMER("Customer Name", zone);
select "Customer Name" from TELECOM_CUSTOMER where ZONE in ('Mountain');
