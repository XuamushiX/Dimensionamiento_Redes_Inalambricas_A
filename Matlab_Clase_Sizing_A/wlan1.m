clear all; close all; 
R=15; %Radio de Cobertura
P=1;  % Probabilidad de Cobertura 1=100% 
x=[61.880343, 67.922558, 64.901451, 69.845082, 65.450743, 60.781758, 66.000035, 74.788713, 81.380221, 79.183052, 68.197205, 61.605696, 63.802866, 72.866190, 71.492959, 72.591544, 70.943666];
y=[13.191516, 14.924364, 23.093502, 23.588602, 17.399860, 28.044495, 28.539595, 28.539595, 28.044495, 34.728336, 34.975885, 36.213634, 32.747939, 32.500389, 29.034694, 35.966084, 12.696417];
N=length(x); 
% xs=(rand(M,1)-0.5)*200; ys=(rand(M,1)-0.5)*200;
%[xs, ys]=meshgrid(0:4.5:27, 0:4.5:72); xs=reshape(xs, size(xs,1)*size(xs,2),1); ys=reshape(ys, size(ys,1)*size(ys,2),1);
xs=[59.133881, 58.859235, 59.133881, 53.915603, 53.640957, 53.091665, 58.035296, 66.000035, 72.866190, 81.105575, 85.499914, 84.950622, 84.950622, 77.809821, 73.964774, 73.964774, 73.415482, 73.415482, 66.823974, 62.154989, 65.450743];
ys=[10.716020, 18.885158, 25.568999, 26.064098, 32.500389, 38.194031, 38.936680, 38.936680, 39.679329, 39.431779, 37.451382, 30.767541, 25.321449, 25.073899, 24.331251, 18.390059, 12.943967, 9.478272, 9.230722, 9.230722, 26.311648];
M=length(xs);

for i=1:M;
    for j=1:N
        dist(i,j)=sqrt((xs(i)-x(j))^2+(ys(i)-y(j))^2);% Distancia Euclideana
    end
end
% Grabar variables en una base de datos llamado "escenario"
escenario.xs=xs; 
escenario.ys=ys; 
escenario.x=x; 
escenario.y=y; 
escenario.R=R; 
escenario.dist=dist;
%Llamar a la función Graficar el escenario
graficar_escenario_wlan1(escenario);
% Guardar el "escenario" en un archivo *.mat "scen_wlan1.mat"
save scen_wlan1.mat escenario;
% Ingreso de la función en LPSolve
fid = fopen('wlan2.lp', 'w');
clc
% Función Objetivo
fprintf(fid,'min: +Z_1');
for j=2:M
    fprintf(fid,'+Z_%d',j);
end
fprintf(fid,';\n');

fprintf(fid,'min_num_usuarios: +Y_1');
for j=2:N
    fprintf(fid,'+Y_%d',j);
end
fprintf(fid,'>=%f;\n',P*N);

for j=1:N
    %Ecuación de restricción de cobertura de cada usuario
    fprintf(fid,'Cobertura_usuario_%d: Y_%d<=',j,j); 
    flag=0; 
    temp=0;
    for i=1:M
        if dist(i,j)<=R
            temp=1;
            if flag==0,
                flag=1;
                fprintf(fid,'Z_%d',i);
            else
                fprintf(fid,'+Z_%d',i);
            end
        end
    end
    if temp==1
        fprintf(fid,';\n');
    else
        fprintf(fid,'0;\n');
    end
end

fprintf(fid,'binary ');
for i=1:N
    fprintf(fid,'Y_%d, ',i);
end
for i=1:(M-1)
    fprintf(fid,'Z_%d, ',i);
end
fprintf(fid,'Z_%d;\n',M);

% break;
% pause
%PROCESO DE SOLUCIÓN POR METAHEURÍSTICAS
% A=dist<=R; cobertura=1;
% covered=zeros(1,N); activos=zeros(M,1);
% while sum(covered)<=P*N  & sum(cobertura)>0 %Cobertura real 
%     cobertura=sum(A,2);
%     if sum(cobertura)>0;
%         [vmax, ind]=max(cobertura);
%         ind=randsrc(1,1,ind);
%         activos(ind)=1
%         cubiertos=find(A(ind,:));
%         A(:,cubiertos)=0;
%         covered(cubiertos)=1;
%     end
% end


