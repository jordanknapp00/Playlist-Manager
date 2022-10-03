# Playlist Manager (v1.0)

Playlist Manager is a program designed to organize all the songs on your playlist. Playlist Manager makes creating a playlist easier and quicker than doing so through a streaming site's interface. Bands, albums, and songs can be added, categorized with metadata including tags, and queried to make managing your playlist easy no matter how many songs it has. Data can be exported in a variety of formats, including ```.xlsx``` and ```.csv``` for creating spreadsheets and ```.txt``` files that can be imported into sites such as [TuneMyMusic](www.tunemymusic.com) or [Soundiiz](www.soundiiz.com). These sites will then allow you to import your playlist into a wide variety of streaming sites.

Playlist Manager makes it easier than ever to create a playlist with thousands of songs, without having to deal with streaming sites' clunky and slow interfaces.

## How to Use

The three basic units are bands, albums, and songs. A band has a list of albums, and an album has a list of songs. Note, however, that it is not necessary to categorize by album if you don't want to. Every band has an implicit "N/A" album that can be used if you only want to categorize by band and song. Data for each unit can be modified, including adding tags and marking certain units as favorites. This data can be used when querying to find specific records. Finally, your playlist can be exported to a number of file formats, as mentioned above.

### Adding Bands

The first step to creating a playlist is listing all the bands you intend to include. Click the "Add Band(s)" button to pull up the Add Bands Dialog. This dialog consists simply of a text box and an "Add" button. Enter each band you want to add on its own line in the text box and click the button to add them to the playlist.

### Adding Albums

As mentioned above, this step is not technically necessary. Clicking the "Add Album(s) From a Band" button will pull up that dialog. It consists of a dropdown and two text boxes. The dropdown will contain all the bands in the current playlist. Select the band you wish to add albums to. In the left text box, enter the names of all the albums you want to add from this band, with each album going on its own line. In the right text box, enter the corresponding year that each album was released. At this time, it is necessary to enter a year for every album. In the future, this stipulation may be removed. Once all the data has been entered, click the "Add" button.

### Adding Songs

The Add Songs dialog consists of two dropdowns and two text boxes. The left dropdown will contain all the bands that are part of the current playlist. Once a band is selected, the right dropdown will contain all of that band's albums that have been added to the playlist. Note the "N/A" album is part of every band, but it will only show up in the table if songs have been added to it. Once an album is selected, enter each song you wish to add on its own line in the left text box. Then enter the corresponding track numbers on the album for each song. Again, this is currently a necessary step, but the requirement may be removed in the future. Another possible addition in the future is automatic sequential numbering, in which each song is numbered from 1 to *n*, with *n* being the number of songs you've entered. But for now, entering numbers manually is required.

### Modifying Data

Bands, albums, and songs all have their own distinct modifiying dialogs, accessed with the buttons to the right of the "Add" buttons on the main menu. The modifying dialogs allow adding tags to a band, album, or song, as well as marking bands, albums, or songs as favorites. Tags can be applied to all units above or below the current one. For example, tags you enter for a band can also be applied to all its albums. Tags applied to an album can be added to all its songs, as well as the band that it belongs to, and so on.

It is also in these menus that bands, albums, and songs can be deleted from a playlist. Deleting a band will remove all of its albums, and deleting an album will remove all of its songs.

### Querying Data

Data can be queried on any of the fields mentioned above. For example, you can enter a list of band names and return all records with one of those band names. Favorite status and tags can be used to query on bands, albums, and songs, while albums can be queried by year (and whether or not "N/A" should be included), and songs can be queried by track number. Any number of different data can be included in the same query. For example, one could query records with bands named "Metallica" or "Iron Maiden" that are marked as favorites, as well as only including albums from the year 1986, and songs with track number 1. With the example playlist file provided, this will return Iron Maiden's "Caught Somewhere in Time", off their 1986 album *Somewhere in Time*, and Metallica's "Battery", off their 1986 album *Master of Puppets*.

Queries can be saved and loaded in ```.json``` files, the same format used to store playlists themselves.

### Saving Playlists

Playlists can be saved in ```.json``` format. This allows them to be edited by hand if so desired. Attempting to load ```.json``` files not created by Playlist Manager could result in undefined behavior. It is more than likely that the program will not allow loading an invalid ```.json``` file, but if the formatting is just right, you may be able to load junk data. The same applies to query files.

### Exporting Playlists

Arguably the most important feature of the program, playlists can be exported to a few file formats. ```.xlsx``` and ```.csv``` file formats are supported, allowing the data to be turned into a spreadsheet that could be used in a program like Excel.

Files can also be exported to ```.txt``` files, which can be used on a handful of websites (such as the two listed above) that will then allow importing the playlist into various streaming sites, including Spotify, YouTube, Pandora, etc. The ```.txt``` file format simply consists of each record on its own line, with the format "Band name - Song name - Album name", with the album name being omitted for "N/A" albums. Note that if there are any bands with no albums or albums with no songs, they will be omitted from the ```.txt``` export.

## Coming in Later Versions

v1.0 sees the program in a completely functional state. However, there are a few features planned for future versions. Planned features include, but are not limited to:

- Overhauling the underlying data structures to use Delphi's ```TClientDataSet``` rather than nested dictionaries
- Improved user interface, hopefully including a table with sortable columns
- Make album year and song track number non-mandatory
- Ability to export only the currently queried set
- Copy text from the table (and export only the selected set)
- Allow specifying order of bands, albums, or songs in the export (as right now, the order is fairly arbitrary due to unordered nature of dictionaries)