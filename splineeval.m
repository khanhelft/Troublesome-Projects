function yy=splineeval(x,a,b,c,d,xx)
n=length(x)-1;
yy=0*xx;
for i=1:n
ix=xx>=x(i) & xx<=x(i+1);
yy(ix)=a(i)+b(i)*(xx(ix)-x(i))+c(i)*(xx(ix)-x(i)).^2+d(i)*(xx(ix)-x(i)).^3;
end