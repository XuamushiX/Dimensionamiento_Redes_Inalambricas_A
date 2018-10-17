function graficar_escenario_wlan1(escenario)
    figure(1);
    %======================================================================
    %img=imread('campus_map.png'); K=0.1184;
    img=imread('ingenieriasp1.png'); K=0.10465;
    if length(escenario.R)==1
        escenario.R=escenario.xs*0+escenario.R;
    end
    H=size(img,1); W=size(img,2);  
    image([0 W*K],[0 H*K], img); 
    hold on; 
    %=====================================================================
    z1=plot(escenario.x,escenario.y,'o','markerfacecolor',[1 0.5 0])
    hold on
    z2=plot(escenario.xs,escenario.ys,'sr', 'markerfacecolor',[0.5 0.6 0.6],'markersize',8); 
    grid on; 
    axis equal; 
    hold on; 
    xc=cos(0:0.01:2*pi+0.01); yc=sin(0:0.01:2*pi+0.01); 
    M=length(escenario.xs); % Longitud de muestras de AP 
    N=length(escenario.x);  % Longitus de muestras de usuarios
    
    % Graficar circunferencias de Cobertura de cada AP
    
    for i=1:M
       z3= plot(xc*escenario.R(i)+escenario.xs(i), yc*escenario.R(i)+escenario.ys(i),'--','color',[0 0.5 0]); 
        text(escenario.xs(i), escenario.ys(i),sprintf('\nBS%d',i),'color','b','fontsize',6); %Texto id
        for j=1:N
            if i==1
%                 text(escenario.x(j), escenario.y(j),sprintf('us%d',j)); 
            end
            if escenario.dist(i,j)<=escenario.R(i)
                plot([escenario.xs(i) escenario.x(j)],[escenario.ys(i) escenario.y(j)],'-','color',[0.6 0.6 0.6]);
            end
        end
    end
    xlabel('Coordenadas en X','FontName','Times New Roman','FontUnits','points','FontSize',11,'FontWeight','normal','FontAngle','normal');
    ylabel('Coordenadas en Y','FontName','Times New Roman','FontUnits','points','FontSize',11,'FontWeight','normal','FontAngle','normal');
%==========================================================================
% e = findobj('Color','b');
% v1 = [e(1)];% Variables color para leyenda
leyenda=legend([z1,z2,z3],'Estudiantes','# AP Candidatos','Cobertura/AP','Location','SO','Orientation','horizontal');
set(leyenda,'FontName','Times New Roman','FontUnits','points','FontSize',8,'FontWeight','normal','FontAngle','normal')
%==========================================================================
print -dpng -r800 No_Optimal_AP_H;
print -depsc -r450 No_Optimal_AP_H;
%==========================================================================
hold off; 
%==========================================================================
    if isfield(escenario, 'sln')
        figure(2); 
        %img=imread('campus_map.png'); K=0.1184;
        img=imread('ingenieriasp1.png'); K=0.1047;
        H=size(img,1); W=size(img,2);  
        image([0 W*K],[0 H*K], img); hold on; 
        z4=plot(escenario.x,escenario.y,'o','markerfacecolor',[0.5 0 1]);
        z5=plot(escenario.xs(escenario.sln),escenario.ys(escenario.sln),'s','markerfacecolor',[0.45 0.63 0.89],'markersize',8); grid on; axis equal; hold on; 
        xc=cos(0:0.01:2*pi+0.01); yc=sin(0:0.01:2*pi+0.01); 
        M=length(escenario.xs(escenario.sln)); 
        N=length(escenario.x); 
        for i=1:M
            fill(escenario.R(i)*1.01*xc+escenario.xs((escenario.sln(i))),escenario.R(i)*1.01*yc+escenario.ys((escenario.sln(i))),[0 0.92 0.98],'facealpha',0.1); 
            hold on;
            z6=plot(escenario.R(i)*xc+escenario.xs((escenario.sln(i))), escenario.R(i)*yc+escenario.ys((escenario.sln(i))),'--g'); 
             text(escenario.xs((escenario.sln(i))), escenario.ys((escenario.sln(i))),sprintf('\n\nBS%d',(escenario.sln(i))),'fontsize',7,'color','m'); 
            for j=1:N
                if i==1
                    text(escenario.x(j), escenario.y(j),sprintf('\nus%d',j),'fontsize',7,'color','r'); 
                end
                if escenario.dist(escenario.sln(i),j)<=escenario.R
                    plot([escenario.xs((escenario.sln(i))) escenario.x(j)],[escenario.ys((escenario.sln(i))) escenario.y(j)],'--','color',[0.6 0.6 0.6]);
                end
            end
        end
        xlabel('Coordenadas en X','FontName','Times New Roman','FontUnits','points','FontSize',11,'FontWeight','normal','FontAngle','normal');
        ylabel('Coordenadas en Y','FontName','Times New Roman','FontUnits','points','FontSize',11,'FontWeight','normal','FontAngle','normal');
xlabel('Coordenadas en X','FontName','Times New Roman','FontUnits','points','FontSize',11,'FontWeight','normal','FontAngle','normal');
    ylabel('Coordenadas en Y','FontName','Times New Roman','FontUnits','points','FontSize',11,'FontWeight','normal','FontAngle','normal');
%==========================================================================
% e = findobj('Color','b');
% v1 = [e(1)];% Variables color para leyenda
leyenda=legend([z4,z5,z6],'Estudiantes','# AP Óptimos','XX% Cobertura','Location','SO','Orientation','horizontal');
set(leyenda,'FontName','Times New Roman','FontUnits','points','FontSize',8,'FontWeight','normal','FontAngle','normal')
%==========================================================================
        hold off; 
    end
%==========================================================================
print -dpng -r700 Optimal_AP_H;
print -depsc -r500 Optimal_AP_H;
%==========================================================================