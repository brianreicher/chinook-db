SELECT tr.Name as TrackName, al.Title as AlbumTitle, Composer as ComposerList
FROM tracks tr JOIN albums al on al.AlbumId = tr.AlbumId
WHERE Composer like '%Steven Tyler%' and Composer not like '%Joe Perry%'
ORDER BY TrackName;
