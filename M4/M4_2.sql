-- 1
SELECT DISTINCT vendor_name
FROM vendors
WHERE vendor_id IN
     (SELECT vendor_id FROM invoices)
ORDER BY vendor_name;

-- 2
SELECT invoice_number, invoice_total
FROM invoices
WHERE payment_total >
     (SELECT AVG(payment_total)
      FROM invoices
      WHERE payment_total > 0)
ORDER BY invoice_total DESC;

-- 3
SELECT account_number, account_description
FROM general_ledger_accounts gl
WHERE  NOT EXISTS
    (SELECT account_number
     FROM invoice_line_items
     WHERE account_number = gl.account_number)
ORDER BY account_number;

-- 4
SELECT vendor_name, i.invoice_id, invoice_sequence, line_item_amount
FROM vendors v JOIN invoices i
  ON v.vendor_id = i.vendor_id
JOIN invoice_line_items li
  ON i.invoice_id = li.invoice_id
WHERE i.invoice_id IN
      (SELECT invoice_id
       FROM invoice_line_items               
       WHERE invoice_sequence > 1)
ORDER BY vendor_name, i.invoice_id, invoice_sequence;

-- 5
SELECT SUM(unpaid_max) AS maximums_sum
FROM (SELECT vendor_id, MAX(invoice_total) AS unpaid_max
      FROM invoices
      WHERE invoice_total - credit_total - payment_total > 0
      GROUP BY vendor_id) AS sub;
      
-- 6(We should change only_full_group_by to avoid error)
select @@global.sql_mode;
set @@global.sql_mode ='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
SELECT vendor_name, vendor_city, vendor_state
FROM vendors
WHERE CONCAT(vendor_state, vendor_city) NOT IN 
    (SELECT CONCAT(vendor_state, vendor_city) as fullname
     FROM vendors
     GROUP BY fullname
     HAVING COUNT(*) > 1)
ORDER BY vendor_state, vendor_city;

-- 7
SELECT vendor_name, invoice_number, invoice_date, invoice_total
FROM invoices i JOIN vendors v
  ON i.vendor_id = v.vendor_id
WHERE invoice_date =
  (SELECT MIN(invoice_date)
   FROM invoices 
   WHERE vendor_id = i.vendor_id)
ORDER BY vendor_name;
