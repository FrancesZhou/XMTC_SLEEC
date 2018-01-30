%Make SLEEC
cd SLEEC
make
cd sleec_train/liblinear-2.20/matlab
make
cd ../../../../
cd ReadData_Matlab
make

cd ..

fprintf('SLEEC make complete\n');
