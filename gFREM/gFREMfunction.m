function y=gFREMfunction(x,f1,f2, int1, int2, showim, pixelversion)
% y=gFREMfunction(x,f1,f2, int1, int2, showim, pixelversion)

if ~exist('showim','var')
    showim = 0;
end
if ~exist('pixelversion','var')
    pixelversion = 0; 
end
dx=x(2)-x(1);
if pixelversion
    [fp1, xp]= pixelize1d(x,f1);
    fp2= pixelize1d(x,f2);
    gfp1=pixelize1d(x,gradient(f1,dx));
    gfp2=pixelize1d(x,gradient(f2,dx));
else 
    fp1=f1; 
    fp2=f2;
    gfp1=gradient(f1,dx);
    gfp2=gradient(f2,dx);
    xp=x;
end
p = int1*fp1+int2*fp2;

kernel = (1./p).*(int1*gfp1-int2*gfp2).^2;
if pixelversion
    y = sum(kernel);
else
    y=trapz(xp,kernel);
end

if showim
figure; 
plot(x,int1*f1, x,int2*f2,x,p,':k');
hold on
plot(x,kernel,'r--');
grid on
end



