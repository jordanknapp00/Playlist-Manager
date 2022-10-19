For 1.2:

- Update README
- Sort columns by clicking on title
- Show records in table even if there are no albums or songs
- Don't reset the queried set when favorite boxes are clicked
- Find and eliminate memory leaks (as this will be final major version before 2.0 overhaul)

For 2.0 and beyond:

- Fully migrate to ```TClientDataSet```, though maybe dictionaries should at least be kept for saving/loading data, as they're more conducive to JSON format
- Overhaul the adding of records (no more individual windows, but also minimal data duplication)
- Select multiple rows and export only what's selected (also allow copying what's selected)
- Other UI improvements (better resizing?)
- More querying options
- More metadata (length for albums and songs)
- Improved statistics (count per band and album, maybe)