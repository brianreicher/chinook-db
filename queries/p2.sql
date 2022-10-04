SELECT DISTINCT Country as CountryName
FROM customers JOIN invoices i on customers.CustomerId = i.CustomerId JOIN
    invoice_items ii on i.InvoiceId = ii.InvoiceId JOIN tracks t on t.TrackId = ii.TrackId JOIN genres g on g.GenreId = t.GenreId
WHERE g.Name = 'Drama'
ORDER BY Country;
