% DONE BY 22BEE051 JAIVIN PATEL
% bus-shunt 
% 1-bus number
% 2- capacitive admittance shunt (only magnitude)

% line data 
% 1-start bus 
% 2-end bus
% 3- impedance (series)(r+jx)
% 4-admittance shunt 

%bus_data
% 1- bus no
% 2- bus type
% 3- Voltage magnitude for slack and pv with pq as 1
% 4- angle as inital zero
% 5- Generation power
% 6- Load Power 
% 7- Qmax only for pv
% 8- Qmin only for pv
bus_shunt = [3 0.04]
line_data = [1 2 0.042+0.168j  0.082j ;
             2 3 0.031+0.126j  0.062j ;
             3 1 0.031+0.126j  0.062j ]
bus_data = [1 0 1.04 0 complex(0,0) complex(0,0) 0 0;
            2 1 1.02 0 complex(1,0) complex(0,0) 100 -100;
            3 2 1.00 0 complex(0,0) complex(1.2,0.7) 0 0;]