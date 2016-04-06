function [ Bch ] = FourBarCalcB(lo2a,lab,lbo4,thin,po2,po4)
%FourBarCalcB: (int int int int vector vector -> int int)
%   For given inouts of lengths of 3 (nongrounded) links and coordinates of
%   ground link, calculates the x,y coordinates of the output joint using
%   the geometric method


%variables for testing:
% lo2a=7;
% lab=6;
% lbo4=5;
% thin=55;
% po2=[0;0];
% po4=[3;0];

 o2o4=po4-po2;
 lo4o2= ((o2o4(1,1))^2+(o2o4(2,1))^2)^(1/2);
 
 Larray= [lo2a lab lbo4 lo4o2];
  
  
lmin=min(Larray);
lmax=max(Larray);

L1L2=Larray((Larray~=lmin)&(Larray~=lmax));

if (lmin+lmax)<(sum(L1L2))
    if (lmin==lo2a) | (lmin==lo4o2)
        THETA=thin;     
    elseif lmin==lab
        msgbox('Input link cannot rotate fully with given configuration.')
    elseif lmin==lbo4
         msgbox('Input link cannot rotate fully with given configuration.')
    end
elseif (lmin+lmax)==(sum(L1L2))
    msgbox('Current configuration results in indeterminate geometry.')
elseif (lmin+lmax)>(sum(L1L2))
    msgbox('Links will not be able to rotate fully.')
end


% %Prompts user for all link lengths
% Lengths=inputdlg({'Length of link O2A:','Length of link AB:','Length of link BO4:'}, 'Link Lengths');
% L= str2double(Lengths);
% lo2a= L(1,1)
% lab= L(2,1)
% lbo4= L(3,1)
%
% %prompts user for theta 2 (angle between positive horizontal and input)
% Angles=inputdlg({'Initial input angle:'}, 'Theta');
% T= str2double (Angles);
% thin= T(1,1)
%
% %prompts user for position of ground link
% Gnd= inputdlg({'X Position of O2:', 'Y Position of O2:', 'X Position of O4:', 'Y Position of O4:'}, 'Ground Position');
% po2= str2double (Gnd (1:2, 1))
% po4= str2double (Gnd (3:4, 1))

o2ax= lo2a*cos(pi*thin/180); 
o2ay= lo2a*sin(pi*thin/180);
o2a=[o2ax;o2ay];
%o2a
pa=o2a-po2;
% figure(1)
% plotv(pa)

xa=pa(1,1);
ya=pa(2,1);

theta= 0:0.01:2*pi;
x1=lab*(cos(theta)-xa);
y1=lab*sin(theta)+ya;

xo4=po4(1,1);
yo4=po4(2,1);
x2=lbo4*(cos(theta)-xo4);
y2=lbo4*sin(theta)+yo4;

% I found the intersections function online, written by Douglas Schwartz
[xout yout]=intersections(x1,y1,x2,y2);

B=[xout yout];



try
    Btry=B(1,1);
    plot(x1,y1,x2,y2)
    axis square
    axis equal
    hold on
    scatter(xout, yout)
catch
    ErrorBox=msgbox('Error: linkages cannot be assembled with current values')
    ErrorBox
end

B1x= B(1,1);
B1y= B(1,2);
B2x= B(2,1);
B2y= B(2,2);
B1=[B1x;B1y];
B2=[B2x;B2y];

hp=max(B1y,B2y);

if hp==B1y
    Bch=B1;
else
    Bch=B2;
end

end

FourBarCalcB(6,7,5,55,[0;0],[3;0])

