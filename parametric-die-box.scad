/*
Parametric wafer sample box.
This SCAD file is a tool to design boxes for holding
thin film samples grown on thin (<1mm) wafers.
They are meant to hold multiple samples in place so that they will
not get mixed up or damaged.

auth: Alex D.
*/


/* GLOBAL PARAMS */
/* 
If you're looking at this for the first time, this is where
you will set the dimensions and design parameters for your box.
Simply change the values below corresponding to the values that
you want to be different from the default. Please refer to the
diagram in the readme if you are unsure of what parameters do what.
*/

/* xlen and ylen specify the overall length & width of the box. */
xlen = 50;
ylen = 50;

/* nrows and ncols decide how many rows & columns of die compartments
there will be.*/
nrows = 4;
ncols = 1;

/* twall decides the thickness of the compartment walls */
twall = 1.5;
/* hwall decides the height of the compartment walls */
hwall = 4;

/* tbase sets the width of the base plate lip, and hbase its height. */
tbase = 2;
hbase = 2;

module main() {
    bottom();
}

module bottom() {
    xbase = xlen + 2 * tbase;
    ybase = ylen + 2 * tbase;
    translate([-tbase,-tbase,-hbase])
    cube([xbase,ybase,hbase]);
    nxwalls = ncols - 1;
    nywalls = nrows - 1;
    xclen = (xlen - nxwalls*twall) / ncols;
    for (i = [0:nrows]) {
        translate([i*(xlen - twall) / nrows, 0, 0])
        cube([twall, ylen, hwall]);
    }
    for (k = [0:ncols]) {
        translate([0, k*(ylen - twall) / ncols, 0])
        cube([xlen, twall, hwall]);
    }
}

main();
