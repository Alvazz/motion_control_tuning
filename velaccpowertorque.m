%% velocity, acc, power, torque calculations
%% assume sinusoidal profiles
%% theta = A*cos(wt)   --> position
%% angvel = -A*w*sin(wt) --> angular velocity dtheta/dt
%% angacc = -A*w^2*cos(wt) --> angular acceleration dangvel/dt
%% desired requirement : 90° --> 100ms
deltaposdeg = 90; %% [degree] 
deltaposrad = deltaposdeg*2*pi / 360; %% [rad]  2*A
period = 0.2; %% [seconds] T
angfreg = 2*pi/period; %% [rad/s]  w = 2pi/T
maxangvelrads = (deltaposrad/2) * angfreg; %% [rad/s]
maxangveldegs = maxangvelrads * 360 / (2*pi); %% [deg/s]
maxangvelrpm = maxangvelrads * 60 / (2*pi); %% [rpm]
maxangaccrads2 = (deltaposrad/2) * angfreg^2; %% [rad/s^2]
maxangaccdegs2 = maxangaccrads2 * 360 / (2*pi); %% [deg/s^2]
