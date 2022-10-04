/*
 1. We have some customers that like variety in each album.
 Which albums have tracks associated with more than 1 genre?
 Please provide the album name and artist name. Sort the list by ArtistName.
 */

SELECT al.title as AlbumTitle, ar.name as ArtistName
FROM albums al JOIN  artists ar on al.ArtistId = ar.ArtistId JOIN tracks t
    on al.AlbumId = t.AlbumId
GROUP BY AlbumTitle
HAVING COUNT(distinct(GenreId)) > 1
ORDER BY ArtistName;


/*
 2. In which countries did we bill for videos from the Drama genre?
 Give a list of the countries in alphabetical order.
 */

SELECT DISTINCT Country as CountryName
FROM customers JOIN invoices i on customers.CustomerId = i.CustomerId JOIN
    invoice_items ii on i.InvoiceId = ii.InvoiceId JOIN tracks t on t.TrackId = ii.TrackId JOIN genres g on g.GenreId = t.GenreId
WHERE g.Name = 'Drama'
ORDER BY Country;


/*
 3. How many tracks are associated with each genre? Provide the Genre Name and number of tracks.
    Sort the list by number of tracks in descending order.
 */

SELECT g.Name as GenreName, COUNT(t.Name) as NumberOfTracks
FROM tracks t join albums a on a.AlbumId = t.AlbumId join genres g on g.GenreId = t.GenreId
GROUP BY g.Name
ORDER BY NumberOfTracks DESC;


/*
 4. A new customer LOVES things composed by Steven Tyler but is not a fan of Joe Perry compositions.
 Create a query that will pull all tracks that were composed by Steven Tyler but not Joe Perry.
 To make the customer happy, please include the names of the Track, the title of the album each is on, and the composers of the track.
 The list should be alphabetized in ascending order by the track name.
 */

SELECT tr.Name as TrackName, al.Title as AlbumTitle, Composer as ComposerList
FROM tracks tr JOIN albums al on al.AlbumId = tr.AlbumId
WHERE Composer like '%Steven Tyler%' and Composer not like '%Joe Perry%'
ORDER BY TrackName;


/*
 5. Which albums have above-average total play time?
 Provide a list of album titles with the artist's name in alphabetic order by Album name.
 */

SELECT Title as AlbumTitle, a2.Name as ArtistName
FROM albums join tracks t on albums.AlbumId = t.AlbumId join artists a2 on albums.ArtistId = a2.ArtistId
GROUP BY Title
HAVING SUM(t.Milliseconds) >
(SELECT AVG(AlbumTotal) as AvgAlbumTotalLength
    FROM (SELECT SUM(Milliseconds) as AlbumTotal
    FROM tracks t JOIN albums a on a.AlbumId = t.AlbumId
    GROUP BY a.Title))
ORDER BY AlbumTitle;


/*
 6. Write a query to help Margaret Park, one of the Chinook sales representatives:
 she just closed a big sale (over $10!!) and was about to celebrate, but the customer called with a question:
 “Margaret, mon amie, do you recall the composer of that track?
 It was either the . . . Jazz or Classical one?”
 Margaret is so shocked, she has forgotten who the customer is, and so can’t lookup the track/invoice directly;
 and of course, she doesn’t want to ask the customer’s name just after a big sale . . . eek!
 Fortunately, the customer used a bit of French, and so Margaret remembers the customer is from France.
 You are to write a query to answer the customer’s question using only the information supplied.
 You cannot hardcode any numeric ids (e.g., EmployeeId, GenreId, CustomerId, SupportRepId, TrackId),
 nor identifying information about the track/invoice/etc other than the criteria described above.
 */

SELECT DISTINCT t.Composer as forgotComposer
FROM employees JOIN customers c on employees.EmployeeId = c.SupportRepId JOIN
    invoices i on c.CustomerId = i.CustomerId JOIN invoice_items ii on i.InvoiceId = ii.InvoiceId
    JOIN tracks t on t.TrackId = ii.TrackId JOIN genres g on g.GenreId = t.GenreId
WHERE employees.FirstName = 'Margaret' and employees.LastName = 'Park'
  and i.Total>10 and i.BillingCountry = 'France' and g.Name in ('Jazz', 'Classical') and forgotComposer IS NOT NULL;