function plotOptPlan(q, p0, axis_lim)
%PLOTOPTPLAN Summary of this function goes here
%   Detailed explanation goes here

persistent i;
persistent plan_plot;
if isempty(i)
    i = 1;
end

[~,q_n] = size(q);

if i > 1
    for j = 1:q_n
        delete(plan_plot{j})
    end
end

for j = 1:q_n
    a1 = (q(:,j) - p0)';
    a2 = (q(:,j) - p0)'*q(:,j);

    m = -a1(1)/a1(2);
    b = a2/a1(2);

    %x(1) = q(1,j) + 5;
    x(1) = axis_lim(1);
    x(2) = axis_lim(2);
    y(1) = m*x(1) + b;
    y(2) = m*x(2) + b;
    
    plan_plot{j} = plot(x, y, '-k');
end

i = 2;
end

