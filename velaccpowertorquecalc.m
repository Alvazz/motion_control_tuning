%% velocity, acc, power, torque calculations
%% assume sinusoidal profiles
%% theta = A*cos(wt)   --> position
%% angvel = -A*w*sin(wt) --> angular velocity dtheta/dt
%% angacc = -A*w^2*cos(wt) --> angular acceleration dangvel/dt
%% desired requirement : 90° --> 100ms for azimuth
%% desired requirement : 60° --> 100ms for elevation
deltaposdegazmimuth = 90; %% [degree] 
deltaposdegelevation = 60; %% [degree] 
deltaposradazimuth = deltaposdegazmimuth*2*pi / 360; %% [rad]  2*A
deltaposradelevation = deltaposdegelevation*2*pi / 360; %% [rad]  2*A
period = 0.2; %% [seconds] T
angfreg = 2*pi/period; %% [rad/s]  w = 2pi/T
maxangvelazimuthrads = (deltaposradazimuth/2) * angfreg; %% [rad/s]
maxangvelelevationrads = (deltaposradelevation/2) * angfreg; %% [rad/s]
maxangvelazimuthdegs = maxangvelazimuthrads * 360 / (2*pi); %% [deg/s]
maxangvelelevationdegs = maxangvelelevationrads * 360 / (2*pi); %% [deg/s]
maxangvelazimuthrpm = maxangvelazimuthrads * 60 / (2*pi); %% [rpm]
maxangvelelevationrpm = maxangvelelevationrads * 60 / (2*pi); %% [rpm]
maxangaccazimuthrads2 = (deltaposradazimuth/2) * angfreg^2; %% [rad/s^2]
maxangaccelevationrads2 = (deltaposradelevation/2) * angfreg^2; %% [rad/s^2]
maxangaccazimuthdegs2 = maxangaccazimuthrads2 * 360 / (2*pi); %% [deg/s^2]
maxangaccelevationdegs2 = maxangaccelevationrads2 * 360 / (2*pi); %% [deg/s^2]
%% torque = inertia * acc
%% power = torque * angvel 
maxtorqueazimuth = inertiaazimuth * maxangaccazimuthrads2; %% [Nm]
maxtorqueelevation = inertiaelevation * maxangaccelevationrads2; %% [Nm]
%% plot the assumed profiles
tres = period / 100; %% [seconds]
t = 0:tres:period;
posdegazimutharr = deltaposdegazmimuth/2 * cos(angfreg*t);
posdegelevationarr = deltaposdegelevation/2 * cos(angfreg*t);
figure;
plot(t,posdegazimutharr);
hold on;
plot(t,posdegelevationarr,'r');
grid;
legend ('azimuth','elevation');
title('position of the load vs time')
xlabel('time [seconds]');
ylabel('position [degree]');
saveas(gcf, 'snapshots\position_load', 'png')
angveldegazimuthsarr = -1*maxangvelazimuthdegs * sin(angfreg*t);
angveldegelevationsarr = -1*maxangvelelevationdegs * sin(angfreg*t);
figure;
plot(t,angveldegazimuthsarr);
hold on;
plot(t,angveldegelevationsarr,'r');
grid;
legend ('azimuth','elevation');
title('angular velocity of the load vs time')
xlabel('time [seconds]');
ylabel('angular velocity [degree/s]');
saveas(gcf, 'snapshots\velocity_load', 'png')
angaccdegs2azimutharr = -1*maxangaccazimuthdegs2 * cos(angfreg*t);
angaccdegs2elevationarr = -1*maxangaccelevationdegs2 * cos(angfreg*t);
figure;
plot(t,angaccdegs2azimutharr);
hold on;
plot(t,angaccdegs2elevationarr,'r');
grid;
legend ('azimuth','elevation');
title('angular acceleration of the load vs time')
xlabel('time [seconds]');
ylabel('angular acceleration [degree/s^2]');
saveas(gcf, 'snapshots\acceleration_load', 'png')
angaccrads2azimutharr = -1*maxangaccazimuthrads2 * cos(angfreg*t);
angaccrads2elevationarr = -1*maxangaccelevationrads2 * cos(angfreg*t);
torqueazimutharr = inertiaazimuth * angaccrads2azimutharr;
torqueelevationarr = inertiaelevation * angaccrads2elevationarr;
figure;
plot(t,torqueazimutharr);
hold on;
plot(t,torqueelevationarr,'r');
grid;
legend ('azimuth','elevation');
title('requirred torque of the load vs time')
xlabel('time [seconds]');
ylabel('torque [Nm]');
saveas(gcf, 'snapshots\torque_load', 'png')
angvelradsazimutharr = -1*maxangvelazimuthrads * sin(angfreg*t);
angvelradselevationarr = -1*maxangvelelevationrads * sin(angfreg*t);
powerazimutharr = torqueazimutharr .* angvelradsazimutharr;
powerelevationarr = torqueelevationarr .* angvelradselevationarr;
maxpowerazimuth = max(powerazimutharr); %% [watt]
maxpowerelevation = max(powerelevationarr); %% [watt]
figure;
plot(t,powerazimutharr);
hold on;
plot(t,powerelevationarr,'r');
grid;
legend ('azimuth','elevation');
title('requirred power of the load vs time')
xlabel('time [seconds]');
ylabel('power [Watt]');
saveas(gcf, 'snapshots\power_load', 'png')