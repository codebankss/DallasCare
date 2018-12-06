CREATE OR REPLACE VIEW ReorderMeds AS(
SELECT medicene_code, medicene_name, quantity, date_of_expiry
FROM PHARMACY
WHERE Date_of_expiry <= DATE_ADD(CURDATE(), INTERVAL 1 month) 
OR Quantity < 1000
);