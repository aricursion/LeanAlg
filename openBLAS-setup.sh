mkdir third_party
cd third_party
mkdir OpenBLASLib

git clone https://github.com/xianyi/OpenBLAS
cd OpenBLAS
make
make install PREFIX=../OpenBLASLib
