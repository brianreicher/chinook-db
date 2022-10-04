SELECT al.title as AlbumTitle, ar.name as ArtistName
FROM albums al JOIN  artists ar on al.ArtistId = ar.ArtistId JOIN tracks t
    on al.AlbumId = t.AlbumId
GROUP BY AlbumTitle
HAVING COUNT(distinct(GenreId)) > 1
ORDER BY ArtistName;