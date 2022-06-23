if ! [ -d "./third_party/OpenBLASLib/" ] 
then
    echo "OpenBLAS not installed. Please install it with ./openBLAS-setup.sh"
    exit
fi

./clean.sh
lake build
./build/bin/LeanAlg
