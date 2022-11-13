-- 1
USE ap;
SELECT vendor_id, SUM(invoice_total) AS invoice_total_sum
FROM invoices
GROUP BY vendor_id;

-- 2
SELECT vendor_name, SUM(payment_total) AS payment_total_sum
FROM vendors v JOIN invoices i
  ON v.vendor_id = i.vendor_id
GROUP BY vendor_name
ORDER BY payment_total_sum DESC;

-- 3
SELECT vendor_name, COUNT(*) AS invoice_count, SUM(invoice_total) AS invoice_total_sum
FROM vendors v JOIN invoices i
  ON v.vendor_id = i.vendor_id
GROUP BY vendor_name
ORDER BY invoice_count DESC;

-- 4
SELECT account_description, COUNT(*) AS line_item_count, SUM(line_item_amount) AS line_item_amount_sum
FROM general_ledger_accounts g JOIN invoice_line_items l
    ON g.account_number = l.account_number
GROUP BY account_description
HAVING line_item_count > 1
ORDER BY line_item_amount_sum DESC;

-- 5
SELECT account_description, COUNT(*) AS line_item_count, SUM(line_item_amount) AS line_item_amount_sum
FROM general_ledger_accounts g 
  JOIN invoice_line_items l
    ON g.account_number = l.account_number
  JOIN invoices i
    ON l.invoice_id = i.invoice_id
WHERE invoice_date BETWEEN '2018-04-01' AND '2018-06-30'
GROUP BY account_description
HAVING line_item_count > 1
ORDER BY line_item_amount_sum DESC;

-- 6
SELECT account_number, SUM(line_item_amount) AS line_item_sum
FROM invoice_line_items
GROUP BY account_number WITH ROLLUP;

-- 7
SELECT vendor_name, COUNT(DISTINCT l.account_number) AS number_of_gl_accounts
FROM vendors v 
  JOIN invoices i
    ON v.vendor_id = i.vendor_id
  JOIN invoice_line_items l
    ON i.invoice_id = l.invoice_id
GROUP BY vendor_name
HAVING number_of_gl_accounts > 1
ORDER BY vendor_name;

-- 8
SELECT IF(GROUPING(terms_id) = 1, 'All Totals', terms_id) AS terms_id,
       IF(GROUPING(vendor_id) = 1, 'Terms Totals', vendor_id) AS vendor_id,
       MAX(payment_date) AS max_payment_date,
       SUM(invoice_total - credit_total - payment_total) AS balance_due
FROM invoices
GROUP BY terms_id, vendor_id WITH ROLLUP;
