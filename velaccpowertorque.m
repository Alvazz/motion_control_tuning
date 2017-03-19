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
%% torque = inertia * acc
%% power = torque * angvel
inertiaazimuth = 1.6; %% [kg.m^2] 
maxtorqueazimuth = inertiaazimuth * maxangaccrads2; %% [Nm]
%%maxpowerazimuth = maxtorqueazimuth * maxangvelrads; %% [watt]
%% plot the assumed profiles
tres = period / 100; %% [seconds]
t = 0:tres:period;
posdegarr = deltaposdeg/2 * cos(angfreg*t);
figure;
plot(t,posdegarr);
grid;
title('position of the load vs time')
xlabel('time [seconds]');
ylabel('position [degree]');
angveldegsarr = -1*maxangveldegs * sin(angfreg*t);
figure;
plot(t,angveldegsarr);
grid;
title('angular velocity of the load vs time')
xlabel('time [seconds]');
ylabel('angular velocity [degree/s]');
angaccdegs2arr = -1*maxangaccdegs2 * cos(angfreg*t);
figure;
plot(t,angaccdegs2arr);
grid;
title('angular acceleration of the load vs time')
xlabel('time [seconds]');
ylabel('angular acceleration [degree/s^2]');
angaccrads2arr = -1*maxangaccrads2 * cos(angfreg*t);
torqueazimutharr = inertiaazimuth * angaccrads2arr;
figure;
plot(t,torqueazimutharr);
grid;
title('requirred torque of the load vs time')
xlabel('time [seconds]');
ylabel('torque [Nm]');
angvelradsarr = -1*maxangvelrads * sin(angfreg*t);
powerazimutharr = torqueazimutharr .* angvelradsarr;
figure;
plot(t,powerazimutharr);
grid;
title('requirred power of the load vs time')
xlabel('time [seconds]');
ylabel('power [Watt]');