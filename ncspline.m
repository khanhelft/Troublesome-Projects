function [b,c,d]=ncspline(x,a)
%NCSPLINE Natural Cubic Spline
%h = diff(x): calculates differences between adjacent elements of x
h=diff(x);
%There are 21 data points, so we just find S0(x) to S21(x)
n=length(x)-1;
%We try to form the linear system Ax=b, where x=c=[c0,c1,...,cn]
%Determine the matrix A
A=sparse(2:n,1:n-1,h(1:n-1),n+1,n+1) + ...
sparse(2:n,3:n+1,h(2:n),n+1,n+1) + ...
sparse(2:n,2:n,2*(h(1:n-1)+h(2:n)),n+1,n+1);
A(1,1)=1; A(n+1,n+1)=1;
%Determine the matrix b
b=[0,3./h(2:n).*(a(3:n+1)-a(2:n))-3./h(1:n-1).*(a(2:n)-a(1:n-1)),0]';
%Determine the solution c=[c0,c1,...,cn]
c=(A\b)';
%Determine the solution b=[b0,b1,...,bn]
b=(a(2:n+1)-a(1:n))./h-h./3.*(2*c(1:n)+c(2:n+1));
%Determine the solution d=[d0,d1,...,dn]
d=(c(2:n+1)-c(1:n))./(3*h);
%Determine the solution c=c[c0,c1,...,cn]
c=c(1:n);
end

