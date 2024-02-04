    function targMap = targDataMap(),

    ;%***********************
    ;% Create Parameter Map *
    ;%***********************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 2;
        sectIdxOffset = 0;

        ;%
        ;% Define dummy sections & preallocate arrays
        ;%
        dumSection.nData = -1;
        dumSection.data  = [];

        dumData.logicalSrcIdx = -1;
        dumData.dtTransOffset = -1;

        ;%
        ;% Init/prealloc paramMap
        ;%
        paramMap.nSections           = nTotSects;
        paramMap.sectIdxOffset       = sectIdxOffset;
            paramMap.sections(nTotSects) = dumSection; %prealloc
        paramMap.nTotData            = -1;

        ;%
        ;% Auto data (rtP)
        ;%
            section.nData     = 23;
            section.data(23)  = dumData; %prealloc

                    ;% rtP.Ass
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

                    ;% rtP.Bes
                    section.data(2).logicalSrcIdx = 1;
                    section.data(2).dtTransOffset = 9;

                    ;% rtP.Bext
                    section.data(3).logicalSrcIdx = 2;
                    section.data(3).dtTransOffset = 10;

                    ;% rtP.Bss
                    section.data(4).logicalSrcIdx = 3;
                    section.data(4).dtTransOffset = 11;

                    ;% rtP.Css
                    section.data(5).logicalSrcIdx = 4;
                    section.data(5).dtTransOffset = 14;

                    ;% rtP.Fs1data
                    section.data(6).logicalSrcIdx = 5;
                    section.data(6).dtTransOffset = 17;

                    ;% rtP.Fw
                    section.data(7).logicalSrcIdx = 6;
                    section.data(7).dtTransOffset = 125267;

                    ;% rtP.Kb
                    section.data(8).logicalSrcIdx = 7;
                    section.data(8).dtTransOffset = 175268;

                    ;% rtP.Kes
                    section.data(9).logicalSrcIdx = 8;
                    section.data(9).dtTransOffset = 175269;

                    ;% rtP.M
                    section.data(10).logicalSrcIdx = 9;
                    section.data(10).dtTransOffset = 175270;

                    ;% rtP.V1data
                    section.data(11).logicalSrcIdx = 10;
                    section.data(11).dtTransOffset = 175271;

                    ;% rtP.V1max
                    section.data(12).logicalSrcIdx = 11;
                    section.data(12).dtTransOffset = 175772;

                    ;% rtP.V2max
                    section.data(13).logicalSrcIdx = 12;
                    section.data(13).dtTransOffset = 175773;

                    ;% rtP.Vmax
                    section.data(14).logicalSrcIdx = 13;
                    section.data(14).dtTransOffset = 175774;

                    ;% rtP.alpha
                    section.data(15).logicalSrcIdx = 14;
                    section.data(15).dtTransOffset = 175775;

                    ;% rtP.d
                    section.data(16).logicalSrcIdx = 15;
                    section.data(16).dtTransOffset = 175776;

                    ;% rtP.t
                    section.data(17).logicalSrcIdx = 16;
                    section.data(17).dtTransOffset = 175777;

                    ;% rtP.z1data
                    section.data(18).logicalSrcIdx = 17;
                    section.data(18).dtTransOffset = 225778;

                    ;% rtP.Integrator4_IC
                    section.data(19).logicalSrcIdx = 18;
                    section.data(19).dtTransOffset = 226028;

                    ;% rtP.Integrator5_IC
                    section.data(20).logicalSrcIdx = 19;
                    section.data(20).dtTransOffset = 226029;

                    ;% rtP.Gain_Gain
                    section.data(21).logicalSrcIdx = 20;
                    section.data(21).dtTransOffset = 226030;

                    ;% rtP.Integrator1_IC
                    section.data(22).logicalSrcIdx = 21;
                    section.data(22).dtTransOffset = 226031;

                    ;% rtP.StateSpace2_InitialCondition
                    section.data(23).logicalSrcIdx = 22;
                    section.data(23).dtTransOffset = 226032;

            nTotData = nTotData + section.nData;
            paramMap.sections(1) = section;
            clear section

            section.nData     = 2;
            section.data(2)  = dumData; %prealloc

                    ;% rtP.Fs1_maxIndex
                    section.data(1).logicalSrcIdx = 23;
                    section.data(1).dtTransOffset = 0;

                    ;% rtP.Fs2_maxIndex
                    section.data(2).logicalSrcIdx = 24;
                    section.data(2).dtTransOffset = 2;

            nTotData = nTotData + section.nData;
            paramMap.sections(2) = section;
            clear section


            ;%
            ;% Non-auto Data (parameter)
            ;%


        ;%
        ;% Add final counts to struct.
        ;%
        paramMap.nTotData = nTotData;



    ;%**************************
    ;% Create Block Output Map *
    ;%**************************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 1;
        sectIdxOffset = 0;

        ;%
        ;% Define dummy sections & preallocate arrays
        ;%
        dumSection.nData = -1;
        dumSection.data  = [];

        dumData.logicalSrcIdx = -1;
        dumData.dtTransOffset = -1;

        ;%
        ;% Init/prealloc sigMap
        ;%
        sigMap.nSections           = nTotSects;
        sigMap.sectIdxOffset       = sectIdxOffset;
            sigMap.sections(nTotSects) = dumSection; %prealloc
        sigMap.nTotData            = -1;

        ;%
        ;% Auto data (rtB)
        ;%
            section.nData     = 6;
            section.data(6)  = dumData; %prealloc

                    ;% rtB.ncxrjebmkf
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

                    ;% rtB.bmtrdfpnly
                    section.data(2).logicalSrcIdx = 1;
                    section.data(2).dtTransOffset = 1;

                    ;% rtB.cz5qkzuy5d
                    section.data(3).logicalSrcIdx = 2;
                    section.data(3).dtTransOffset = 2;

                    ;% rtB.kebpnhv3nu
                    section.data(4).logicalSrcIdx = 3;
                    section.data(4).dtTransOffset = 3;

                    ;% rtB.prxvsoismm
                    section.data(5).logicalSrcIdx = 4;
                    section.data(5).dtTransOffset = 4;

                    ;% rtB.nhwmxfcfh1
                    section.data(6).logicalSrcIdx = 5;
                    section.data(6).dtTransOffset = 5;

            nTotData = nTotData + section.nData;
            sigMap.sections(1) = section;
            clear section


            ;%
            ;% Non-auto Data (signal)
            ;%


        ;%
        ;% Add final counts to struct.
        ;%
        sigMap.nTotData = nTotData;



    ;%*******************
    ;% Create DWork Map *
    ;%*******************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 4;
        sectIdxOffset = 1;

        ;%
        ;% Define dummy sections & preallocate arrays
        ;%
        dumSection.nData = -1;
        dumSection.data  = [];

        dumData.logicalSrcIdx = -1;
        dumData.dtTransOffset = -1;

        ;%
        ;% Init/prealloc dworkMap
        ;%
        dworkMap.nSections           = nTotSects;
        dworkMap.sectIdxOffset       = sectIdxOffset;
            dworkMap.sections(nTotSects) = dumSection; %prealloc
        dworkMap.nTotData            = -1;

        ;%
        ;% Auto data (rtDW)
        ;%
            section.nData     = 6;
            section.data(6)  = dumData; %prealloc

                    ;% rtDW.pn1w25njy4.LoggedData
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

                    ;% rtDW.fxbogsmkbh.AQHandles
                    section.data(2).logicalSrcIdx = 1;
                    section.data(2).dtTransOffset = 3;

                    ;% rtDW.dl3cb1cmxx.AQHandles
                    section.data(3).logicalSrcIdx = 2;
                    section.data(3).dtTransOffset = 4;

                    ;% rtDW.g0j45fsfoh.AQHandles
                    section.data(4).logicalSrcIdx = 3;
                    section.data(4).dtTransOffset = 5;

                    ;% rtDW.oytvbckdqo.AQHandles
                    section.data(5).logicalSrcIdx = 4;
                    section.data(5).dtTransOffset = 6;

                    ;% rtDW.fl0tshby2f.AQHandles
                    section.data(6).logicalSrcIdx = 5;
                    section.data(6).dtTransOffset = 7;

            nTotData = nTotData + section.nData;
            dworkMap.sections(1) = section;
            clear section

            section.nData     = 2;
            section.data(2)  = dumData; %prealloc

                    ;% rtDW.nw1wamtli2
                    section.data(1).logicalSrcIdx = 6;
                    section.data(1).dtTransOffset = 0;

                    ;% rtDW.lisshlsluy
                    section.data(2).logicalSrcIdx = 7;
                    section.data(2).dtTransOffset = 1;

            nTotData = nTotData + section.nData;
            dworkMap.sections(2) = section;
            clear section

            section.nData     = 2;
            section.data(2)  = dumData; %prealloc

                    ;% rtDW.nfyedtg254
                    section.data(1).logicalSrcIdx = 8;
                    section.data(1).dtTransOffset = 0;

                    ;% rtDW.c510mlrj2d
                    section.data(2).logicalSrcIdx = 9;
                    section.data(2).dtTransOffset = 1;

            nTotData = nTotData + section.nData;
            dworkMap.sections(3) = section;
            clear section

            section.nData     = 2;
            section.data(2)  = dumData; %prealloc

                    ;% rtDW.k4ggkwi0ma
                    section.data(1).logicalSrcIdx = 10;
                    section.data(1).dtTransOffset = 0;

                    ;% rtDW.j1mghhqlf3
                    section.data(2).logicalSrcIdx = 11;
                    section.data(2).dtTransOffset = 1;

            nTotData = nTotData + section.nData;
            dworkMap.sections(4) = section;
            clear section


            ;%
            ;% Non-auto Data (dwork)
            ;%


        ;%
        ;% Add final counts to struct.
        ;%
        dworkMap.nTotData = nTotData;



    ;%
    ;% Add individual maps to base struct.
    ;%

    targMap.paramMap  = paramMap;
    targMap.signalMap = sigMap;
    targMap.dworkMap  = dworkMap;

    ;%
    ;% Add checksums to base struct.
    ;%


    targMap.checksum0 = 4275295741;
    targMap.checksum1 = 1029146566;
    targMap.checksum2 = 465299512;
    targMap.checksum3 = 3139364417;

