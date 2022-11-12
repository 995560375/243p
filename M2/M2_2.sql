-- 1
select *
from vendors join invoices
on vendors.vendor_id = invoices.vendor_id;

-- 2
select vendor_name, invoice_number, invoice_date,
       invoice_total - payment_total - credit_total as balance_due
from vendors v join invoices i
on v.vendor_id = i.vendor_id
where invoice_total - payment_total - credit_total != 0
order by vendor_name;

-- 3
select vendor_name, default_account_number as default_account, 
       account_description as description
from vendors v join general_ledger_accounts g
on v.default_account_number = g.account_number
order by account_description, vendor_name;

-- 4
select vendor_name, invoice_date, invoice_number, invoice_sequence as li_sequence, line_item_amount as li_amount
from vendors v join invoices i
  on v.vendor_id = i.vendor_id
 join invoice_line_items li
   on i.invoice_id = li.invoice_id
order by vendor_name, invoice_date, invoice_number, invoice_sequence;

-- 5
select v1.vendor_id, v1.vendor_name,
       concat(v1.vendor_contact_first_name, ' ', v1.vendor_contact_last_name) as contact_name
from vendors v1 join vendors v2
    on v1.vendor_id != v2.vendor_id and
       v1.vendor_contact_last_name = v2.vendor_contact_last_name  
order by v1.vendor_contact_last_name;

-- 6
SELECT g.account_number, account_description, invoice_id
FROM general_ledger_accounts g LEFT JOIN invoice_line_items i
  ON g.account_number = i.account_number
WHERE i.invoice_id IS NULL
ORDER BY g.account_number;

-- 7
  SELECT vendor_name, vendor_state
  FROM vendors
  WHERE vendor_state = 'CA'
UNION
  SELECT vendor_name, 'Outside CA'
  FROM vendors
  WHERE vendor_state != 'CA'
ORDER BY vendor_name;