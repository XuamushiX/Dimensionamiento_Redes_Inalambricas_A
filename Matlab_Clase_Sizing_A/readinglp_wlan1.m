%clc; clear all; close all
fid = fopen('wlan2.csv', 'r');
tline = fgetl(fid); 
tline = fgetl(fid);
ind=1;
%Reading of the results from LPSOLVE
while 1
    tline = fgetl(fid);
    if ~ischar(tline),
        break,
    end
    array=split(tline,';');
    if str2num(array{end})==1
        data{ind}=array{1};
        value(ind)=str2num(array{end});
        ind=ind+1;
    end
end
fclose(fid);
%====================================================================
for i=1:length(value)
     
    temp=split(data{i},'_');% Símbolo de división luego de la letra "Z"
    if temp{1}=='Z'
    n1=str2num(char(temp(2)));%Obtengo el segundo valor junto a "Z"
    %n2=str2num(char(temp(3))); %Esto ya no se usa porque LPSolve solo
    %entrega los valores de Z
    sln(i)=[n1];
    sln % Imprime en command window la solución de "Z"
    end
end
load scen_wlan1;
escenario.sln=sln;
%figure(3); 
graficar_escenario_wlan1(escenario);
% print -dpng -r800 Optimal_AP_LPSolve_wlan1
% print -depsc -r800 Optimal_AP_LPSolve_wlan1
