SELECT g.Name as GenreName, COUNT(t.Name) as NumberOfTracks
FROM tracks t join albums a on a.AlbumId = t.AlbumId join genres g on g.GenreId = t.GenreId
GROUP BY g.Name
ORDER BY NumberOfTracks DESC;