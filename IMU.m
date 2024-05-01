clc
clear
close all

%% Run "blelist" to find device
deviceAddress = "34851806CD36";
sensor = ble(deviceAddress); %Connect                    

%% Run "b.Characteristics" to check available Services
serviceUUID = "19B10000-E8F2-537E-4F6C-D104768A1214";
characteristicUUID = "19B10001-E8F2-537E-4F6C-D104768A1214";
c = characteristic(sensor,serviceUUID,characteristicUUID);    %add characteristic
count = 0;
fid=fopen('FinalkMotion.sto','a+');
fprintf(fid,'%6s\r\n',"DataRate=100.000000");
fprintf(fid,'%6s\r\n',"DataType=Quaternion");
fprintf(fid,'%6s\r\n',"version=3");
fprintf(fid,'%6s\r\n',"OpenSimVersion=4.4-2022-07-23-0e9fedc");
fprintf(fid,'%6s\r\n',"endheader");
fprintf(fid,'%6s\r\n',"time	tibia_l_imu	calcn_l_imu");
fclose(fid);
tic
%% Read data
for i = 0:500
    data = read(c);
    acc(1) = swapbytes(typecast(fliplr(uint8(data(1:4))),'single'));
    acc(2) = swapbytes(typecast(fliplr(uint8(data(5:8))),'single'));
    acc(3) = swapbytes(typecast(fliplr(uint8(data(9:12))),'single'));
    acc(4) = swapbytes(typecast(fliplr(uint8(data(13:16))),'single'));
    acc(5) = swapbytes(typecast(fliplr(uint8(data(17:20))),'single'));
    acc(6) = swapbytes(typecast(fliplr(uint8(data(21:24))),'single'));
    acc(7) = swapbytes(typecast(fliplr(uint8(data(25:28))),'single'));
    acc(8) = swapbytes(typecast(fliplr(uint8(data(29:32))),'single'));
    display(acc);
    fid=fopen('save2.sto','a+');
    fprintf(fid,'%.2f\t',toc);
    fprintf(fid,'%f%s%f%s%f%s%f\t',acc(1), ',', acc(2), ',', acc(3), ',', acc(4));
    fprintf(fid,'%f%s%f%s%f%s%f\n',acc(5), ',', acc(6), ',', acc(7), ',', acc(8));
    fclose(fid);
end

