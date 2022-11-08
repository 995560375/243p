-- 8
select vendor_name, vendor_contact_last_name as LastName, vendor_contact_first_name as FirstName
from vendors
order by LastName, FirstName;

-- 9
select concat(vendor_contact_last_name, ', ', vendor_contact_first_name) as full_name
from vendors
where vendor_contact_last_name regexp '^[ABCE]'
order by vendor_contact_last_name, vendor_contact_first_name;

-- 10
select invoice_due_date as "Due Date", invoice_total as "Invoice Total", invoice_total * 0.1 as "10%", 
		invoice_total * 1.1 as "Plus 10%"
from invoices
where invoice_total >= 500 and invoice_total <= 1000
order by invoice_due_date desc;

-- 11
select invoice_number, invoice_total, payment_total + credit_total as payment_credit_total, 
		invoice_total - payment_total - credit_total as balance_due
from invoices
where invoice_total - payment_total - credit_total > 50
order by balance_due desc
limit 5;

-- 12
select invoice_number, invoice_date, invoice_total - payment_total - credit_total as balance_due,
		payment_date
from invoices
where payment_date is null;

-- 13
select date_format(current_date(), '%m-%d-%Y') as "current_date";

-- 14
select 50000 as starting_principal, 50000 * 0.065 as interest, 50000 + 50000 * 0.065 as principal_plus_interest;