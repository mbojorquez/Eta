#!/bin/bash

for i in `seq -f %02g 0 48`
do
#wgrib -s WRF_PNOR_$i | grep ":UGRD:500 mb:" | wgrib -i -grib WRF_PNOR_$i -o WRF_PNOR_MODIF_$i

/opt/grads-2.1.0.oga.1/Contents/wgrib -s /home/comun/Actual/data_grib/WRF/Dominios/SPJC/06z/d03/WRFPRS_d03.$i | egrep ":TMP:|:SPFH:|:DPT:|:RH:|:UGRD:|:VGRD:" | egrep ":2 m above gnd:|:10 m above gnd:" | /opt/grads-2.1.0.oga.1/Contents/wgrib -i -grib /home/comun/Actual/data_grib/WRF/Dominios/SPJC/06z/d03/WRFPRS_d03.$i -o /home/spzo/Datos_extraidos/WRF_SFC_SPJC_$i

done

cat /home/spzo/Datos_extraidos/WRF_SFC_SPJC_* > /home/spzo/Datos_extraidos/WRFsfc_SPJC.grb
rm /home/spzo/Datos_extraidos/WRF_SFC_SPJC_*

cd /home/spzo/Datos_extraidos/
/home/spzo/Documents/grib2ctl.pl -verf WRFsfc_SPJC.grb > WRFsfc_SPJC.ctl
/opt/grads-2.1.0.oga.1/Contents/gribmap -i WRFsfc_SPJC.ctl

