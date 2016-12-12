/*
Parametric wafer sample box.
This SCAD file is a tool to design boxes for holding
thin film samples grown on thin (<1mm) wafers.
They are meant to hold multiple samples in place so that they will
not get mixed up or damaged.
*/


/* GLOBAL PARAMS */
/* 
If you're looking at this for the first time, this is where
you will set the dimensions and design parameters for your box.
Simply change the values below corresponding to the values that
you want to be different from the default. Please refer to the
diagram in the readme if you are unsure of what parameters do what.
*/

module main() {
    cube(5);
}

main();
