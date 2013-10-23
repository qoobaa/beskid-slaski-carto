@contour: #333;

#contours100 {
    [zoom >= 10] {
        line-color: @contour;
        line-smooth: 1;
        line-opacity: 0.2;
    	line-width: 0.5;
    }
    [zoom >= 12] {
    	line-opacity: 0.2;
    }
    [zoom >= 13] {
        line-opacity: 0.2;
    }
    [zoom >= 14] {
        text-halo-radius: 1;
        text-face-name: @book-fonts;
        text-name: [height];
        text-size: 8;
        text-placement: line;
        text-fill: @contour;
    }
}

#contours50 {
    [zoom >= 11] {
        line-smooth: 1;
        line-color: @contour;
        line-width: 0.5;
        line-opacity: 0.2;
    }
    [zoom >= 13] {
        line-opacity: 0.2;
    }
}

#contours10 {
    [zoom >= 13] {
        line-color: @contour;
        line-smooth: 1;
        line-width: 0.5;
        line-opacity: 0.2;
    }
}

#hillshade {
    raster-opacity: 0.5;
}
