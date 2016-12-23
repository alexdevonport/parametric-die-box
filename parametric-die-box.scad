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
nrows = 3;
ncols = 3;

/* twall decides the thickness of the compartment walls */
twall = 1;
/* hwall decides the height of the compartment walls */
hwall = 5;
/* hlid decides how tall the little squares on the top side
that cap off the compartments are (or, equivalently, how
far the squares go into the compartments when the box is closed).*/
hlid = 2;
/* tbase sets the width of the base plate lip, and hbase its height. */
tbase = 2;
hbase = 2;

/* expf is a fudge factor for plastic expansion, intended
to improve the fit between top and bottom. If it's too tight,
increse it. If it's too loose, decrease it.*/
expf = 0.6;

module main() {
    bottom();
    translate([1.1*(xlen+2*tbase),0,0])
    top();
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

module top() {
    xbase = xlen + 2 * tbase;
    ybase = ylen + 2 * tbase;
    nxwalls = ncols - 1;
    nywalls = nrows - 1;
    xclen = (xlen - nxwalls*twall) / ncols;
    translate([-tbase,-tbase,-hbase])
    cube([xbase,ybase,hbase]);
    /* 3% expansion factor built in to account for ABS,
    should change to allow for arbitrary amount*/
    twall2 = (1+expf)*twall;
    difference() {
        cube([xlen-twall/2,ylen-twall/2,hlid]);
        for (i = [0:nrows]) {
            translate([i*(xlen - twall2) / nrows, 0, 0])
            cube([twall2, ylen, hwall]);
        }
        for (k = [0:ncols]) {
            translate([0, k*(ylen - twall2) / ncols, 0])
            cube([xlen, twall2, hwall]);
        }
    }
}

main();
