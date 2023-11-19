function val = def_data()
    eps_0 = 8.85e-12;
    val = {
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
end