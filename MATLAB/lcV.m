sol_lcV = cell(1, length(res_2dof_pstrain{end}.x_range));
int_lcV = cell(1, length(res_2dof_pstrain{end}.x_range));
V_rangeref = res_2dof_pstrain{end}.V_range(1):10:res_2dof_pstrain{end}.V_range(end);
for i = 1:length(res_2dof_pstrain{end}.x_range) % x_range length
    for j = 1:length(res_2dof_pstrain{end}.V_range)
        sol_lcV{i}(j) = res_2dof_pstrain{j}.sol_lc(i);
    end
    int_lcV{i} = interp1(res_2dof_pstrain{end}.V_range, sol_lcV{i}, V_rangeref, 'linear');
end

%%
x_rangetmp = res_2dof_pstrain{end}.x_range(res_2dof_pstrain{end}.x_range <= x_max);
myfig(1000,''); 
idx = 1;
for i = floor(linspace(1, length(x_rangetmp), 10))
    if mod(idx,2) == 0
        st = '--';
    else
        st = '-';
    end
    % plot(res_2dof_pstrain{end}.V_range, sol_lcV{i})
    plot(V_rangeref, int_lcV{i}, st, 'DisplayName', 'x = ' + string(x_rangetmp(i)))
    idx = idx + 1;
end
legend('Location', 'best')



