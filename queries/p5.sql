SELECT Title as AlbumTitle, a2.Name as ArtistName
FROM albums join tracks t on albums.AlbumId = t.AlbumId join artists a2 on albums.ArtistId = a2.ArtistId
GROUP BY Title
HAVING SUM(t.Milliseconds) >
(SELECT AVG(AlbumTotal) as AvgAlbumTotalLength
    FROM (SELECT SUM(Milliseconds) as AlbumTotal
    FROM tracks t JOIN albums a on a.AlbumId = t.AlbumId
    GROUP BY a.Title))
ORDER BY AlbumTitle;