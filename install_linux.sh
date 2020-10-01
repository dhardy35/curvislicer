#!/bin/sh

chmod +x ./curvislice.sh
chmod +x ./tools/icesl/bin/IceSL-slicer



#################################################################
#
# TetWild installation
#
# maybe required:
# sudo dnf install mpfr-devel CGAL-devel CGAL-qt5-devel 
#
#################################################################
cd tools
git clone https://github.com/Yixin-Hu/TetWild
cd TetWild
mkdir build
cd build

# -DTETWILD_WITH_HUNTER=ON can be required see:
# https://github.com/Yixin-Hu/TetWild/issues/69
cmake -DTETWILD_WITH_HUNTER=ON  ..
make
cp TetWild ../.

cd ../../..

#################################################################
#
# curvislicer_osqp installation
#
# maybe required:
# sudo dnf install libjpeg-turbo-devel
#
#################################################################
mkdir bin
cd bin
cmake ..
make
cd ..

#################################################################
#
# curvislicer_gurobi installation
#
# maybe required:
# sudo dnf install libjpeg-turbo-devel
#
#################################################################

#quick fix for SolverWrapper
grep -vi "osqp" libs/SolverWrapper/CMakeLists.txt > tmp
mv tmp libs/SolverWrapper/CMakeLists.txt

cd bin
cmake -DBUILD_WITH_GRB=ON  -DGRB_VERSION=90 .. 
make

cd ..
 
# path for gurobi in case of ld issues
# https://support.gurobi.com/hc/en-us/articles/360039093112
# short:
# cd /opt/gurobi902/linux64/src/build
# make
# cp libgurobi_c++.a ../../lib/

