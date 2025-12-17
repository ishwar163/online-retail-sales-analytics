CREATE TABLE retail_sales (
    invoiceno VARCHAR(20),
    invoicedate TIMESTAMP,
    stockcode VARCHAR(20),
    description VARCHAR(255),
    quantity INT,
    unitPrice NUMERIC(10,2),
    customeriD INT,
    country VARCHAR(50),
    category VARCHAR(50),
    paymentmethod VARCHAR(50),
    channel VARCHAR(50),
    city VARCHAR(50),
    totalprice NUMERIC(10,2)
);
