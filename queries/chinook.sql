/*
 1. We have some customers that like variety in each album.
 Which albums have tracks associated with more than 1 genre?
 Please provide the album name and artist name. Sort the list by ArtistName.
 */

SELECT al.title as AlbumTitle, ar.name as ArtistName
FROM albums al JOIN  artists ar on al.ArtistId = ar.ArtistId JOIN tracks t
    on al.AlbumId = t.AlbumId
GROUP BY AlbumTitle
-- Where COUNT(distinct(GenreId)) > 1;
having COUNT(distinct(GenreId)) > 1

ORDER BY AlbumTitle;

/*
 2. In which countries did we bill for videos from the Drama genre?
 Give a list of the countries in alphabetical order.
 */

SELECT DISTINCT Country
FROM customers JOIN invoices i on customers.CustomerId = i.CustomerId JOIN
    invoice_items ii on i.InvoiceId = ii.InvoiceId JOIN tracks t on t.TrackId = ii.TrackId JOIN genres g on g.GenreId = t.GenreId
WHERE g.Name = 'Drama'
ORDER BY Country;

/*
 3. How many tracks are associated with each genre? Provide the Genre Name and number of tracks.
    Sort the list by number of tracks in descending order.
 */

SELECT COUNT(t.Name) as Number, g.Name
FROM tracks t join albums a on a.AlbumId = t.AlbumId join genres g on g.GenreId = t.GenreId
GROUP BY g.Name
ORDER BY Number DESC;

/*
 4. A new customer LOVES things composed by Steven Tyler but is not a fan of Joe Perry compositions.
 Create a query that will pull all tracks that were composed by Steven Tyler but not Joe Perry.
 To make the customer happy, please include the names of the Track, the title of the album each is on, and the composers of the track.
 The list should be alphabetized in ascending order by the track name.
 */

SELECT tr.Name as TrackName, al.Title as AlbumTitle, Composer
FROM tracks tr JOIN albums al on al.AlbumId = tr.AlbumId
WHERE Composer like '%Steven Tyler%' and Composer not like '%Joe Perry%'
ORDER BY TrackName; --default is ASC

/*
 5. Which albums have above-average total play time?
 Provide a list of album titles with the artist's name in alphabetic order by Album name.
 */
SELECT AVG(AlbumTimeAvg)
FROM (SELECT AVG(Milliseconds) as AlbumTimeAvg
FROM tracks t JOIN albums a on a.AlbumId = t.AlbumId
GROUP BY a.Title);