function [b,c,d]=ccspline(x,a,fa,fb)
%CCSPLINE Clamped Cubic Spline
h=diff(x);
n=length(x)-1;
A=sparse(2:n+1,1:n,h,n+1,n+1) + ...
sparse(1:n,2:n+1,h,n+1,n+1) + ...
sparse(2:n,2:n,2*(h(1:n-1)+h(2:n)),n+1,n+1);
A(1,1)=2*h(1); A(n+1,n+1)=2*h(n);

b=[3./h(1)*(a(2)-a(1))-3*fa,3./h(2:n).*(a(3:n+1)-a(2:n))-3./h(1:n-
1).*(a(2:n)-a(1:n-1)),3*fb-3/h(n)*(a(n+1)-a(n))]';

c=(A\b)';
b=(a(2:n+1)-a(1:n))./h-h./3.*(2*c(1:n)+c(2:n+1));
d=(c(2:n+1)-c(1:n))./(3*h);
c=c(1:n);
