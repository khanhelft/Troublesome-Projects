x=0:20;
%create an 1-by-6 matrix of normally distributed random numbers
y=randn(size(x));
%Sj(x) = f(xj) = aj, for each j = 0, 1, ..., n-1
%So: aj = f(xj) = y
%So: copy all value of y to a
a=y;
%Find a natural cubic spline S(x) that passes through the 6 data poinnts
%(x0, y0), (x1, y1), ... (x5,y5) by calling the ncspline function
%input: n data point (x0,a0), (x1,a1), ...,(xn,an)
%output: b0,b1,...,bn: the coefficients of piecewise function S(x)
% c0,c1,...,cn: the coefficients of piecewise function S(x)
% d0,d1,...,dn: the coefficients of piecewise function S(x)
[b,c,d]=ncspline(x,a);
%Using the interpolant piecewise function S(x) to interpolate the value of
%S(x) between 0 and 20, stepsize = 0.01
xx=0:0.01:20;
yy=splineeval(x,a,b,c,d,xx);
%Render the graph of the spline S(x) passing through (n+1) data points
plot(xx,yy,x,y,'o')