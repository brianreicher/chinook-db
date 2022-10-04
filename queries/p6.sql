SELECT DISTINCT t.Composer as forgotComposer
FROM employees JOIN customers c on employees.EmployeeId = c.SupportRepId JOIN
    invoices i on c.CustomerId = i.CustomerId JOIN invoice_items ii on i.InvoiceId = ii.InvoiceId
    JOIN tracks t on t.TrackId = ii.TrackId JOIN genres g on g.GenreId = t.GenreId
WHERE employees.FirstName = 'Margaret' and employees.LastName = 'Park'
  and i.Total>10 and i.BillingCountry = 'France' and g.Name in ('Jazz', 'Classical') and forgotComposer IS NOT NULL;