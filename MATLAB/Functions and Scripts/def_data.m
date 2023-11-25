function [all_vars, all_val] = def_data()
    syms nu Y_p epsilon_p epsilon_f EBD_p EBD_f l_0 w_0 tp_0 tf_0 xi_0 
    syms d P_t Vtank f Vf_tot
    syms p_atm T_std gamma_air rhostd_air c_v c_p
    eps_0 = 8.85e-12;
    cell_vars = {nu, Y_p, epsilon_p, epsilon_f, EBD_p, EBD_f, l_0, w_0, tp_0, tf_0, xi_0};
    tank_vars = {d, P_t, Vtank, Vf_tot, f}; 
    gas_vars = {p_atm, T_std, gamma_air, rhostd_air, c_v, c_p};
   
    cell_val = { % All in SI (m, W, Pa, Hz)
                0.3         , ... nu
                2.5e9       , ... Y_p
                3.4 * eps_0 , ... epsilon_p
                2.7 * eps_0 , ... epsilon_f
                303e6       , ... EBD_p
                157.40e6    , ... EBD_f
                50e-3 / 2   , ... l_0
                10e-2       , ... w_0
                25e-6       , ... tp_0
                10e-6       , ... tf_0
                3e-3        , ... xi_0
                };
    tank_val = { % All in SI (m, W, Pa, Hz)
                5           , ... d
                50e3        , ... P_t
                1           , ... Vtank
                1           , ... Vf_tot
                0.1         , ... f               
                };
    gas_val = { % All in SI (m, W, Pa, Hz)
                101325      , ... p_atm
                15 + 273.15 , ... Tstd
                1.4         , ... gamma_air
                1.225       , ... rhostd_air at T = 15°, p = p_atm
                717.2       , ... c_v (J / (kg K)) at T = 15°, p = p_atm
                1.0042      , ... c_p (J / (kg K)) at T = 15°, p = p_atm
                };

    all_vars = horzcat(cellfun(@(x) string(x), cell_vars), cellfun(@(x) string(x), tank_vars), cellfun(@(x) string(x), gas_vars));
    all_vars = sym2cell(str2sym(all_vars));
    all_val = horzcat(cellfun(@(x) string(x), cell_val), cellfun(@(x) string(x), tank_val), cellfun(@(x) string(x), gas_val));
    all_val = sym2cell(str2sym(all_val));


end
