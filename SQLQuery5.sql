----where clause

select * from [dbo].[olist_customers_dataset]
where  customer_state = 'SP';


----order clause--
select * from [dbo].[olist_customers_dataset]
where customer_state is 'SP'and 'MG'
group by 
order by customer_zip_code_prefix;


---like--

SELECT * 
FROM [dbo].[olist_customers_dataset]
WHERE customer_state IN ('SP', 'MG')
  AND customer_id LIKE '%7'
ORDER BY customer_zip_code_prefix;


---inner join--


SELECT i.order_id, i.price, p.payment_installments
FROM 
[dbo].[olist_order_items_dataset] AS i
INNER JOIN 
[dbo].[olist_order_payments_dataset] AS p ON i.order_id = p.order_id;


---left outer join--
SELECT 
    i.order_id, 
    i.price, 
    p.payment_installments
FROM 
    [dbo].[olist_order_items_dataset] AS i
LEFT OUTER JOIN 
    [dbo].[olist_order_payments_dataset] AS p 
    ON i.order_id = p.order_id;


---full outer join--

SELECT 
    i.order_id AS item_order_id, 
    i.price, 
    p.order_id AS payment_order_id, 
    p.payment_installments
FROM 
    [dbo].[olist_order_items_dataset] AS i
FULL OUTER JOIN 
    [dbo].[olist_order_payments_dataset] AS p 
    ON i.order_id = p.order_id;


	----subquerres--

SELECT * 
FROM [dbo].[olist_order_payments_dataset]
WHERE order_id IN (
    SELECT order_id 
    FROM [dbo].[olist_order_items_dataset]
    WHERE price > 500
);


----
SELECT 
    order_id,
    (SELECT SUM(price) 
     FROM [dbo].[olist_order_items_dataset] AS i 
     WHERE i.order_id = p.order_id) AS total_item_price,
    payment_type
FROM [dbo].[olist_order_payments_dataset] AS p;


----aggregate functions--
SELECT AVG(payment_installments) AS avg_installments
FROM [dbo].[olist_order_payments_dataset];

SELECT SUM(price) AS total_revenue
FROM [dbo].[olist_order_items_dataset];

---creating views--

CREATE VIEW vw_total_order_revenue AS
SELECT 
    order_id,
    SUM(price + freight_value) AS total_order_revenue
FROM [dbo].[olist_order_items_dataset]
GROUP BY order_id;


CREATE VIEW vw_avg_installments_by_payment_type AS
SELECT 
    payment_type,
    AVG(payment_installments) AS avg_installments
FROM [dbo].[olist_order_payments_dataset]
GROUP BY payment_type;



----optimizing querries--

CREATE NONCLUSTERED INDEX idx_product_id 
ON [dbo].[olist_order_items_dataset] (product_id);


CREATE NONCLUSTERED INDEX idx_customer_state_id 
ON [dbo].[olist_customers_dataset] (customer_state, customer_id);






