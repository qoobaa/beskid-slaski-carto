#!/bin/bash
set -e -u

UNZIP_OPTS=-qqu

mkdir -p data/
mkdir -p data/srtm

# SRTM
echo "dowloading srtm..."
curl -z "data/N49E018.hgt.zip" -L -o "data/N49E018.hgt.zip" "http://dds.cr.usgs.gov/srtm/version2_1/SRTM3/Eurasia/N49E018.hgt.zip"
curl -z "data/N49E019.hgt.zip" -L -o "data/N49E019.hgt.zip" "http://dds.cr.usgs.gov/srtm/version2_1/SRTM3/Eurasia/N49E019.hgt.zip"
unzip $UNZIP_OPTS data/N49E018.hgt.zip N49E018.hgt -d data/srtm
unzip $UNZIP_OPTS data/N49E019.hgt.zip N49E019.hgt -d data/srtm

# merging
echo "merging srtm..."
gdal_merge.py data/srtm/N49E018.hgt data/srtm/N49E019.hgt -o data/srtm/merged.tif

# contours
echo "generating contours..."
gdal_contour -i 100 -snodata 32767 -a height data/srtm/merged.tif data/srtm/contours100.shp
gdal_contour -i 50 -snodata 32767 -a height data/srtm/merged.tif data/srtm/contours50.shp
gdal_contour -i 10 -snodata 32767 -a height data/srtm/merged.tif data/srtm/contours10.shp

# warping
echo "warping srtm..."
gdalwarp -of GTiff -co "TILED=YES" -srcnodata 32767 -t_srs "+proj=merc +ellps=sphere +R=6378137 +a=6378137 +units=m" -rcs -order 3 -tr 30 30 -multi data/srtm/merged.tif data/srtm/warped.tif

# hillshade
echo "generating hillshade..."
gdaldem hillshade -co compress=lzw data/srtm/warped.tif data/srtm/hillshade.tif

# cleaning
echo "cleaning up..."
rm data/srtm/N49E018.hgt
rm data/srtm/N49E019.hgt
rm data/srtm/merged.tif
rm data/srtm/warped.tif
