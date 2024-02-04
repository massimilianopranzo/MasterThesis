#include "Piston.h"
#include "rtwtypes.h"
#include "mwmathutil.h"
#include "Piston_private.h"
#include "rt_logging_mmi.h"
#include "Piston_capi.h"
#include "Piston_dt.h"
extern void * CreateDiagnosticAsVoidPtr_wrapper ( const char * id , int nargs
, ... ) ; extern ssExecutionInfo gblExecutionInfo ; RTWExtModeInfo *
gblRTWExtModeInfo = NULL ; void raccelForceExtModeShutdown ( boolean_T
extModeStartPktReceived ) { if ( ! extModeStartPktReceived ) { boolean_T
stopRequested = false ; rtExtModeWaitForStartPkt ( gblRTWExtModeInfo , 2 , &
stopRequested ) ; } rtExtModeShutdown ( 2 ) ; }
#include "slsv_diagnostic_codegen_c_api.h"
#include "slsa_sim_engine.h"
#ifdef RSIM_WITH_SOLVER_MULTITASKING
boolean_T gbl_raccel_isMultitasking = 1 ;
#else
boolean_T gbl_raccel_isMultitasking = 0 ;
#endif
boolean_T gbl_raccel_tid01eq = 1 ; int_T gbl_raccel_NumST = 3 ; const char_T
* gbl_raccel_Version = "23.2 (R2023b) 01-Aug-2023" ; void
raccel_setup_MMIStateLog ( SimStruct * S ) {
#ifdef UseMMIDataLogging
rt_FillStateSigInfoFromMMI ( ssGetRTWLogInfo ( S ) , & ssGetErrorStatus ( S )
) ;
#else
UNUSED_PARAMETER ( S ) ;
#endif
} static DataMapInfo rt_dataMapInfo ; DataMapInfo * rt_dataMapInfoPtr = &
rt_dataMapInfo ; rtwCAPI_ModelMappingInfo * rt_modelMapInfoPtr = & (
rt_dataMapInfo . mmi ) ; int_T enableFcnCallFlag [ ] = { 1 , 1 , 1 } ; const
char * raccelLoadInputsAndAperiodicHitTimes ( SimStruct * S , const char *
inportFileName , int * matFileFormat ) { return rt_RAccelReadInportsMatFile (
S , inportFileName , matFileFormat ) ; }
#include "simstruc.h"
#include "fixedpoint.h"
#include "slsa_sim_engine.h"
#include "simtarget/slSimTgtSLExecSimBridge.h"
#define ijjwmvljpc (-1)
B rtB ; X rtX ; DW rtDW ; static SimStruct model_S ; SimStruct * const rtS =
& model_S ; real_T look2_binlxpw ( real_T u0 , real_T u1 , const real_T bp0 [
] , const real_T bp1 [ ] , const real_T table [ ] , const uint32_T maxIndex [
] , uint32_T stride ) { real_T fractions [ 2 ] ; real_T frac ; real_T yL_0d0
; real_T yL_0d1 ; uint32_T bpIndices [ 2 ] ; uint32_T bpIdx ; uint32_T iLeft
; uint32_T iRght ; if ( u0 <= bp0 [ 0U ] ) { iLeft = 0U ; frac = ( u0 - bp0 [
0U ] ) / ( bp0 [ 1U ] - bp0 [ 0U ] ) ; } else if ( u0 < bp0 [ maxIndex [ 0U ]
] ) { bpIdx = maxIndex [ 0U ] >> 1U ; iLeft = 0U ; iRght = maxIndex [ 0U ] ;
while ( iRght - iLeft > 1U ) { if ( u0 < bp0 [ bpIdx ] ) { iRght = bpIdx ; }
else { iLeft = bpIdx ; } bpIdx = ( iRght + iLeft ) >> 1U ; } frac = ( u0 -
bp0 [ iLeft ] ) / ( bp0 [ iLeft + 1U ] - bp0 [ iLeft ] ) ; } else { iLeft =
maxIndex [ 0U ] - 1U ; frac = ( u0 - bp0 [ maxIndex [ 0U ] - 1U ] ) / ( bp0 [
maxIndex [ 0U ] ] - bp0 [ maxIndex [ 0U ] - 1U ] ) ; } fractions [ 0U ] =
frac ; bpIndices [ 0U ] = iLeft ; if ( u1 <= bp1 [ 0U ] ) { iLeft = 0U ; frac
= ( u1 - bp1 [ 0U ] ) / ( bp1 [ 1U ] - bp1 [ 0U ] ) ; } else if ( u1 < bp1 [
maxIndex [ 1U ] ] ) { bpIdx = maxIndex [ 1U ] >> 1U ; iLeft = 0U ; iRght =
maxIndex [ 1U ] ; while ( iRght - iLeft > 1U ) { if ( u1 < bp1 [ bpIdx ] ) {
iRght = bpIdx ; } else { iLeft = bpIdx ; } bpIdx = ( iRght + iLeft ) >> 1U ;
} frac = ( u1 - bp1 [ iLeft ] ) / ( bp1 [ iLeft + 1U ] - bp1 [ iLeft ] ) ; }
else { iLeft = maxIndex [ 1U ] - 1U ; frac = ( u1 - bp1 [ maxIndex [ 1U ] -
1U ] ) / ( bp1 [ maxIndex [ 1U ] ] - bp1 [ maxIndex [ 1U ] - 1U ] ) ; } bpIdx
= iLeft * stride + bpIndices [ 0U ] ; yL_0d0 = table [ bpIdx ] ; yL_0d0 += (
table [ bpIdx + 1U ] - yL_0d0 ) * fractions [ 0U ] ; bpIdx += stride ; yL_0d1
= table [ bpIdx ] ; return ( ( ( table [ bpIdx + 1U ] - yL_0d1 ) * fractions
[ 0U ] + yL_0d1 ) - yL_0d0 ) * frac + yL_0d0 ; } real_T look1_binlxpw (
real_T u0 , const real_T bp0 [ ] , const real_T table [ ] , uint32_T maxIndex
) { real_T frac ; real_T yL_0d0 ; uint32_T bpIdx ; uint32_T iLeft ; uint32_T
iRght ; if ( u0 <= bp0 [ 0U ] ) { iLeft = 0U ; frac = ( u0 - bp0 [ 0U ] ) / (
bp0 [ 1U ] - bp0 [ 0U ] ) ; } else if ( u0 < bp0 [ maxIndex ] ) { bpIdx =
maxIndex >> 1U ; iLeft = 0U ; iRght = maxIndex ; while ( iRght - iLeft > 1U )
{ if ( u0 < bp0 [ bpIdx ] ) { iRght = bpIdx ; } else { iLeft = bpIdx ; }
bpIdx = ( iRght + iLeft ) >> 1U ; } frac = ( u0 - bp0 [ iLeft ] ) / ( bp0 [
iLeft + 1U ] - bp0 [ iLeft ] ) ; } else { iLeft = maxIndex - 1U ; frac = ( u0
- bp0 [ maxIndex - 1U ] ) / ( bp0 [ maxIndex ] - bp0 [ maxIndex - 1U ] ) ; }
yL_0d0 = table [ iLeft ] ; return ( table [ iLeft + 1U ] - yL_0d0 ) * frac +
yL_0d0 ; } void MdlInitialize ( void ) { rtX . epym1iesyc = rtP .
Integrator4_IC ; rtX . hjdhh5ncop = rtP . Integrator5_IC ; rtX . gxmp3irrhw =
rtP . Integrator1_IC ; rtX . bociztjmzk [ 0 ] = rtP .
StateSpace2_InitialCondition ; rtX . bociztjmzk [ 1 ] = rtP .
StateSpace2_InitialCondition ; rtX . bociztjmzk [ 2 ] = rtP .
StateSpace2_InitialCondition ; rtDW . k4ggkwi0ma = false ; rtDW . nw1wamtli2
= ijjwmvljpc ; rtDW . j1mghhqlf3 = false ; rtDW . lisshlsluy = ijjwmvljpc ; }
void MdlStart ( void ) { { bool externalInputIsInDatasetFormat = false ; void
* pISigstreamManager = rt_GetISigstreamManager ( rtS ) ;
rtwISigstreamManagerGetInputIsInDatasetFormat ( pISigstreamManager , &
externalInputIsInDatasetFormat ) ; if ( externalInputIsInDatasetFormat ) { }
} { { { bool isStreamoutAlreadyRegistered = false ; { sdiSignalSourceInfoU
srcInfo ; sdiLabelU loggedName = sdiGetLabelFromChars ( "Integrator1" ) ;
sdiLabelU origSigName = sdiGetLabelFromChars ( "" ) ; sdiLabelU propName =
sdiGetLabelFromChars ( "Integrator1" ) ; sdiLabelU blockPath =
sdiGetLabelFromChars ( "Piston/To Workspace10" ) ; sdiLabelU blockSID =
sdiGetLabelFromChars ( "" ) ; sdiLabelU subPath = sdiGetLabelFromChars ( "" )
; sdiDims sigDims ; sdiLabelU sigName = sdiGetLabelFromChars ( "Integrator1"
) ; sdiAsyncRepoDataTypeHandle hDT = sdiAsyncRepoGetBuiltInDataTypeHandle (
DATA_TYPE_DOUBLE ) ; { sdiComplexity sigComplexity = REAL ;
sdiSampleTimeContinuity stCont = SAMPLE_TIME_CONTINUOUS ; int_T sigDimsArray
[ 1 ] = { 1 } ; sigDims . nDims = 1 ; sigDims . dimensions = sigDimsArray ;
srcInfo . numBlockPathElems = 1 ; srcInfo . fullBlockPath = ( sdiFullBlkPathU
) & blockPath ; srcInfo . SID = ( sdiSignalIDU ) & blockSID ; srcInfo .
subPath = subPath ; srcInfo . portIndex = 0 + 1 ; srcInfo . signalName =
sigName ; srcInfo . sigSourceUUID = 0 ; rtDW . fxbogsmkbh . AQHandles =
sdiStartAsyncioQueueCreation ( hDT , & srcInfo , rt_dataMapInfo . mmi .
InstanceMap . fullPath , "aa6bfaa3-3ead-4846-a8f3-cb92916d2917" ,
sigComplexity , & sigDims , DIMENSIONS_MODE_FIXED , stCont , "" ) ;
sdiCompleteAsyncioQueueCreation ( rtDW . fxbogsmkbh . AQHandles , hDT , &
srcInfo ) ; if ( rtDW . fxbogsmkbh . AQHandles ) {
sdiSetSignalSampleTimeString ( rtDW . fxbogsmkbh . AQHandles , "0.001" ,
0.001 , ssGetTFinal ( rtS ) ) ; sdiSetSignalRefRate ( rtDW . fxbogsmkbh .
AQHandles , 0.0 ) ; sdiSetRunStartTime ( rtDW . fxbogsmkbh . AQHandles ,
ssGetTaskTime ( rtS , 1 ) ) ; sdiAsyncRepoSetSignalExportSettings ( rtDW .
fxbogsmkbh . AQHandles , 1 , 0 ) ; sdiAsyncRepoSetSignalExportName ( rtDW .
fxbogsmkbh . AQHandles , loggedName , origSigName , propName ) ;
sdiAsyncRepoSetBlockPathDomain ( rtDW . fxbogsmkbh . AQHandles ) ; }
sdiFreeLabel ( sigName ) ; sdiFreeLabel ( loggedName ) ; sdiFreeLabel (
origSigName ) ; sdiFreeLabel ( propName ) ; sdiFreeLabel ( blockPath ) ;
sdiFreeLabel ( blockSID ) ; sdiFreeLabel ( subPath ) ; } } if ( !
isStreamoutAlreadyRegistered ) { { sdiLabelU varName = sdiGetLabelFromChars (
"UG" ) ; sdiRegisterWksVariable ( rtDW . fxbogsmkbh . AQHandles , varName ,
"timeseries" ) ; sdiFreeLabel ( varName ) ; } } } } } { { { bool
isStreamoutAlreadyRegistered = false ; { sdiSignalSourceInfoU srcInfo ;
sdiLabelU loggedName = sdiGetLabelFromChars ( "FG(z, V1, V2)1" ) ; sdiLabelU
origSigName = sdiGetLabelFromChars ( "" ) ; sdiLabelU propName =
sdiGetLabelFromChars ( "FG(z, V1, V2)1" ) ; sdiLabelU blockPath =
sdiGetLabelFromChars ( "Piston/To Workspace5" ) ; sdiLabelU blockSID =
sdiGetLabelFromChars ( "" ) ; sdiLabelU subPath = sdiGetLabelFromChars ( "" )
; sdiDims sigDims ; sdiLabelU sigName = sdiGetLabelFromChars (
"FG(z, V1, V2)1" ) ; sdiAsyncRepoDataTypeHandle hDT =
sdiAsyncRepoGetBuiltInDataTypeHandle ( DATA_TYPE_DOUBLE ) ; { sdiComplexity
sigComplexity = REAL ; sdiSampleTimeContinuity stCont =
SAMPLE_TIME_CONTINUOUS ; int_T sigDimsArray [ 1 ] = { 1 } ; sigDims . nDims =
1 ; sigDims . dimensions = sigDimsArray ; srcInfo . numBlockPathElems = 1 ;
srcInfo . fullBlockPath = ( sdiFullBlkPathU ) & blockPath ; srcInfo . SID = (
sdiSignalIDU ) & blockSID ; srcInfo . subPath = subPath ; srcInfo . portIndex
= 0 + 1 ; srcInfo . signalName = sigName ; srcInfo . sigSourceUUID = 0 ; rtDW
. dl3cb1cmxx . AQHandles = sdiStartAsyncioQueueCreation ( hDT , & srcInfo ,
rt_dataMapInfo . mmi . InstanceMap . fullPath ,
"42658c00-30e4-4494-b655-cb3d0d5a64f3" , sigComplexity , & sigDims ,
DIMENSIONS_MODE_FIXED , stCont , "" ) ; sdiCompleteAsyncioQueueCreation (
rtDW . dl3cb1cmxx . AQHandles , hDT , & srcInfo ) ; if ( rtDW . dl3cb1cmxx .
AQHandles ) { sdiSetSignalSampleTimeString ( rtDW . dl3cb1cmxx . AQHandles ,
"0.001" , 0.001 , ssGetTFinal ( rtS ) ) ; sdiSetSignalRefRate ( rtDW .
dl3cb1cmxx . AQHandles , 0.0 ) ; sdiSetRunStartTime ( rtDW . dl3cb1cmxx .
AQHandles , ssGetTaskTime ( rtS , 1 ) ) ; sdiAsyncRepoSetSignalExportSettings
( rtDW . dl3cb1cmxx . AQHandles , 1 , 0 ) ; sdiAsyncRepoSetSignalExportName (
rtDW . dl3cb1cmxx . AQHandles , loggedName , origSigName , propName ) ;
sdiAsyncRepoSetBlockPathDomain ( rtDW . dl3cb1cmxx . AQHandles ) ; }
sdiFreeLabel ( sigName ) ; sdiFreeLabel ( loggedName ) ; sdiFreeLabel (
origSigName ) ; sdiFreeLabel ( propName ) ; sdiFreeLabel ( blockPath ) ;
sdiFreeLabel ( blockSID ) ; sdiFreeLabel ( subPath ) ; } } if ( !
isStreamoutAlreadyRegistered ) { { sdiLabelU varName = sdiGetLabelFromChars (
"FG" ) ; sdiRegisterWksVariable ( rtDW . dl3cb1cmxx . AQHandles , varName ,
"timeseries" ) ; sdiFreeLabel ( varName ) ; } } } } } { { { bool
isStreamoutAlreadyRegistered = false ; { sdiSignalSourceInfoU srcInfo ;
sdiLabelU loggedName = sdiGetLabelFromChars ( "Position" ) ; sdiLabelU
origSigName = sdiGetLabelFromChars ( "Position" ) ; sdiLabelU propName =
sdiGetLabelFromChars ( "Position" ) ; sdiLabelU blockPath =
sdiGetLabelFromChars ( "Piston/To Workspace7" ) ; sdiLabelU blockSID =
sdiGetLabelFromChars ( "" ) ; sdiLabelU subPath = sdiGetLabelFromChars ( "" )
; sdiDims sigDims ; sdiLabelU sigName = sdiGetLabelFromChars ( "Position" ) ;
sdiAsyncRepoDataTypeHandle hDT = sdiAsyncRepoGetBuiltInDataTypeHandle (
DATA_TYPE_DOUBLE ) ; { sdiComplexity sigComplexity = REAL ;
sdiSampleTimeContinuity stCont = SAMPLE_TIME_CONTINUOUS ; int_T sigDimsArray
[ 1 ] = { 1 } ; sigDims . nDims = 1 ; sigDims . dimensions = sigDimsArray ;
srcInfo . numBlockPathElems = 1 ; srcInfo . fullBlockPath = ( sdiFullBlkPathU
) & blockPath ; srcInfo . SID = ( sdiSignalIDU ) & blockSID ; srcInfo .
subPath = subPath ; srcInfo . portIndex = 0 + 1 ; srcInfo . signalName =
sigName ; srcInfo . sigSourceUUID = 0 ; rtDW . g0j45fsfoh . AQHandles =
sdiStartAsyncioQueueCreation ( hDT , & srcInfo , rt_dataMapInfo . mmi .
InstanceMap . fullPath , "32ea95b0-03ba-4697-9d09-18b9a8c4b38f" ,
sigComplexity , & sigDims , DIMENSIONS_MODE_FIXED , stCont , "" ) ;
sdiCompleteAsyncioQueueCreation ( rtDW . g0j45fsfoh . AQHandles , hDT , &
srcInfo ) ; if ( rtDW . g0j45fsfoh . AQHandles ) {
sdiSetSignalSampleTimeString ( rtDW . g0j45fsfoh . AQHandles , "0.001" ,
0.001 , ssGetTFinal ( rtS ) ) ; sdiSetSignalRefRate ( rtDW . g0j45fsfoh .
AQHandles , 0.0 ) ; sdiSetRunStartTime ( rtDW . g0j45fsfoh . AQHandles ,
ssGetTaskTime ( rtS , 1 ) ) ; sdiAsyncRepoSetSignalExportSettings ( rtDW .
g0j45fsfoh . AQHandles , 1 , 0 ) ; sdiAsyncRepoSetSignalExportName ( rtDW .
g0j45fsfoh . AQHandles , loggedName , origSigName , propName ) ;
sdiAsyncRepoSetBlockPathDomain ( rtDW . g0j45fsfoh . AQHandles ) ; }
sdiFreeLabel ( sigName ) ; sdiFreeLabel ( loggedName ) ; sdiFreeLabel (
origSigName ) ; sdiFreeLabel ( propName ) ; sdiFreeLabel ( blockPath ) ;
sdiFreeLabel ( blockSID ) ; sdiFreeLabel ( subPath ) ; } } if ( !
isStreamoutAlreadyRegistered ) { { sdiLabelU varName = sdiGetLabelFromChars (
"Pos" ) ; sdiRegisterWksVariable ( rtDW . g0j45fsfoh . AQHandles , varName ,
"timeseries" ) ; sdiFreeLabel ( varName ) ; } } } } } { { { bool
isStreamoutAlreadyRegistered = false ; { sdiSignalSourceInfoU srcInfo ;
sdiLabelU loggedName = sdiGetLabelFromChars ( "Velocity" ) ; sdiLabelU
origSigName = sdiGetLabelFromChars ( "Velocity" ) ; sdiLabelU propName =
sdiGetLabelFromChars ( "Velocity" ) ; sdiLabelU blockPath =
sdiGetLabelFromChars ( "Piston/To Workspace8" ) ; sdiLabelU blockSID =
sdiGetLabelFromChars ( "" ) ; sdiLabelU subPath = sdiGetLabelFromChars ( "" )
; sdiDims sigDims ; sdiLabelU sigName = sdiGetLabelFromChars ( "Velocity" ) ;
sdiAsyncRepoDataTypeHandle hDT = sdiAsyncRepoGetBuiltInDataTypeHandle (
DATA_TYPE_DOUBLE ) ; { sdiComplexity sigComplexity = REAL ;
sdiSampleTimeContinuity stCont = SAMPLE_TIME_CONTINUOUS ; int_T sigDimsArray
[ 1 ] = { 1 } ; sigDims . nDims = 1 ; sigDims . dimensions = sigDimsArray ;
srcInfo . numBlockPathElems = 1 ; srcInfo . fullBlockPath = ( sdiFullBlkPathU
) & blockPath ; srcInfo . SID = ( sdiSignalIDU ) & blockSID ; srcInfo .
subPath = subPath ; srcInfo . portIndex = 0 + 1 ; srcInfo . signalName =
sigName ; srcInfo . sigSourceUUID = 0 ; rtDW . oytvbckdqo . AQHandles =
sdiStartAsyncioQueueCreation ( hDT , & srcInfo , rt_dataMapInfo . mmi .
InstanceMap . fullPath , "340bd683-9e20-4bc5-a394-a8828ee4895c" ,
sigComplexity , & sigDims , DIMENSIONS_MODE_FIXED , stCont , "" ) ;
sdiCompleteAsyncioQueueCreation ( rtDW . oytvbckdqo . AQHandles , hDT , &
srcInfo ) ; if ( rtDW . oytvbckdqo . AQHandles ) {
sdiSetSignalSampleTimeString ( rtDW . oytvbckdqo . AQHandles , "0.001" ,
0.001 , ssGetTFinal ( rtS ) ) ; sdiSetSignalRefRate ( rtDW . oytvbckdqo .
AQHandles , 0.0 ) ; sdiSetRunStartTime ( rtDW . oytvbckdqo . AQHandles ,
ssGetTaskTime ( rtS , 1 ) ) ; sdiAsyncRepoSetSignalExportSettings ( rtDW .
oytvbckdqo . AQHandles , 1 , 0 ) ; sdiAsyncRepoSetSignalExportName ( rtDW .
oytvbckdqo . AQHandles , loggedName , origSigName , propName ) ;
sdiAsyncRepoSetBlockPathDomain ( rtDW . oytvbckdqo . AQHandles ) ; }
sdiFreeLabel ( sigName ) ; sdiFreeLabel ( loggedName ) ; sdiFreeLabel (
origSigName ) ; sdiFreeLabel ( propName ) ; sdiFreeLabel ( blockPath ) ;
sdiFreeLabel ( blockSID ) ; sdiFreeLabel ( subPath ) ; } } if ( !
isStreamoutAlreadyRegistered ) { { sdiLabelU varName = sdiGetLabelFromChars (
"Vel" ) ; sdiRegisterWksVariable ( rtDW . oytvbckdqo . AQHandles , varName ,
"timeseries" ) ; sdiFreeLabel ( varName ) ; } } } } } { { { bool
isStreamoutAlreadyRegistered = false ; { sdiSignalSourceInfoU srcInfo ;
sdiLabelU loggedName = sdiGetLabelFromChars ( "Product1" ) ; sdiLabelU
origSigName = sdiGetLabelFromChars ( "" ) ; sdiLabelU propName =
sdiGetLabelFromChars ( "Product1" ) ; sdiLabelU blockPath =
sdiGetLabelFromChars ( "Piston/To Workspace9" ) ; sdiLabelU blockSID =
sdiGetLabelFromChars ( "" ) ; sdiLabelU subPath = sdiGetLabelFromChars ( "" )
; sdiDims sigDims ; sdiLabelU sigName = sdiGetLabelFromChars ( "Product1" ) ;
sdiAsyncRepoDataTypeHandle hDT = sdiAsyncRepoGetBuiltInDataTypeHandle (
DATA_TYPE_DOUBLE ) ; { sdiComplexity sigComplexity = REAL ;
sdiSampleTimeContinuity stCont = SAMPLE_TIME_CONTINUOUS ; int_T sigDimsArray
[ 1 ] = { 1 } ; sigDims . nDims = 1 ; sigDims . dimensions = sigDimsArray ;
srcInfo . numBlockPathElems = 1 ; srcInfo . fullBlockPath = ( sdiFullBlkPathU
) & blockPath ; srcInfo . SID = ( sdiSignalIDU ) & blockSID ; srcInfo .
subPath = subPath ; srcInfo . portIndex = 0 + 1 ; srcInfo . signalName =
sigName ; srcInfo . sigSourceUUID = 0 ; rtDW . fl0tshby2f . AQHandles =
sdiStartAsyncioQueueCreation ( hDT , & srcInfo , rt_dataMapInfo . mmi .
InstanceMap . fullPath , "d2058a9f-f0ab-4e39-a8dc-71f4a515de9c" ,
sigComplexity , & sigDims , DIMENSIONS_MODE_FIXED , stCont , "" ) ;
sdiCompleteAsyncioQueueCreation ( rtDW . fl0tshby2f . AQHandles , hDT , &
srcInfo ) ; if ( rtDW . fl0tshby2f . AQHandles ) {
sdiSetSignalSampleTimeString ( rtDW . fl0tshby2f . AQHandles , "0.001" ,
0.001 , ssGetTFinal ( rtS ) ) ; sdiSetSignalRefRate ( rtDW . fl0tshby2f .
AQHandles , 0.0 ) ; sdiSetRunStartTime ( rtDW . fl0tshby2f . AQHandles ,
ssGetTaskTime ( rtS , 1 ) ) ; sdiAsyncRepoSetSignalExportSettings ( rtDW .
fl0tshby2f . AQHandles , 1 , 0 ) ; sdiAsyncRepoSetSignalExportName ( rtDW .
fl0tshby2f . AQHandles , loggedName , origSigName , propName ) ;
sdiAsyncRepoSetBlockPathDomain ( rtDW . fl0tshby2f . AQHandles ) ; }
sdiFreeLabel ( sigName ) ; sdiFreeLabel ( loggedName ) ; sdiFreeLabel (
origSigName ) ; sdiFreeLabel ( propName ) ; sdiFreeLabel ( blockPath ) ;
sdiFreeLabel ( blockSID ) ; sdiFreeLabel ( subPath ) ; } } if ( !
isStreamoutAlreadyRegistered ) { { sdiLabelU varName = sdiGetLabelFromChars (
"PG" ) ; sdiRegisterWksVariable ( rtDW . fl0tshby2f . AQHandles , varName ,
"timeseries" ) ; sdiFreeLabel ( varName ) ; } } } } } MdlInitialize ( ) ; }
void MdlOutputs ( int_T tid ) { real_T fr10qhmrcc ; real_T pltcjqwgta ; rtB .
ncxrjebmkf = rtX . epym1iesyc ; rtDW . nw1wamtli2 = ijjwmvljpc ; if ( rtB .
ncxrjebmkf >= 0.001 ) { pltcjqwgta = 0.0 ; fr10qhmrcc = rtP . alpha * rtP .
V2max ; } else if ( rtB . ncxrjebmkf < - 0.001 ) { fr10qhmrcc = 0.0 ;
pltcjqwgta = rtP . alpha * rtP . V1max ; } else { pltcjqwgta = 0.0 ;
fr10qhmrcc = 0.0 ; } rtB . bmtrdfpnly = rtX . hjdhh5ncop ; rtB . cz5qkzuy5d =
look2_binlxpw ( pltcjqwgta , rtB . bmtrdfpnly , rtP . V1data , rtP . z1data ,
rtP . Fs1data , rtP . Fs1_maxIndex , 501U ) - look2_binlxpw ( fr10qhmrcc ,
rtP . Gain_Gain * rtB . bmtrdfpnly , rtP . V1data , rtP . z1data , rtP .
Fs1data , rtP . Fs2_maxIndex , 501U ) ; if ( ssIsSampleHit ( rtS , 1 , 0 ) )
{ } rtB . kebpnhv3nu = rtX . gxmp3irrhw ; if ( ssIsSampleHit ( rtS , 1 , 0 )
) { { if ( rtDW . fxbogsmkbh . AQHandles && ssGetLogOutput ( rtS ) ) {
sdiWriteSignal ( rtDW . fxbogsmkbh . AQHandles , ssGetTaskTime ( rtS , 1 ) ,
( char * ) & rtB . kebpnhv3nu + 0 ) ; } } { if ( rtDW . dl3cb1cmxx .
AQHandles && ssGetLogOutput ( rtS ) ) { sdiWriteSignal ( rtDW . dl3cb1cmxx .
AQHandles , ssGetTaskTime ( rtS , 1 ) , ( char * ) & rtB . cz5qkzuy5d + 0 ) ;
} } { if ( rtDW . g0j45fsfoh . AQHandles && ssGetLogOutput ( rtS ) ) {
sdiWriteSignal ( rtDW . g0j45fsfoh . AQHandles , ssGetTaskTime ( rtS , 1 ) ,
( char * ) & rtB . bmtrdfpnly + 0 ) ; } } { if ( rtDW . oytvbckdqo .
AQHandles && ssGetLogOutput ( rtS ) ) { sdiWriteSignal ( rtDW . oytvbckdqo .
AQHandles , ssGetTaskTime ( rtS , 1 ) , ( char * ) & rtB . ncxrjebmkf + 0 ) ;
} } } rtB . prxvsoismm = rtB . cz5qkzuy5d * rtB . ncxrjebmkf ; if (
ssIsSampleHit ( rtS , 1 , 0 ) ) { { if ( rtDW . fl0tshby2f . AQHandles &&
ssGetLogOutput ( rtS ) ) { sdiWriteSignal ( rtDW . fl0tshby2f . AQHandles ,
ssGetTaskTime ( rtS , 1 ) , ( char * ) & rtB . prxvsoismm + 0 ) ; } } } rtDW
. lisshlsluy = ijjwmvljpc ; if ( muDoubleScalarAbs ( rtB . bmtrdfpnly ) < rtP
. d ) { pltcjqwgta = 0.0 ; } else if ( rtB . bmtrdfpnly > rtP . d ) {
pltcjqwgta = ( rtB . bmtrdfpnly - rtP . d ) * - rtP . Kes - rtP . Bes * rtB .
ncxrjebmkf ; } else { pltcjqwgta = ( rtB . bmtrdfpnly + rtP . d ) * - rtP .
Kes - rtP . Bes * rtB . ncxrjebmkf ; } if ( muDoubleScalarAbs ( rtB .
ncxrjebmkf ) > rtP . Vmax ) { pltcjqwgta -= rtP . Bes * rtB . ncxrjebmkf ; }
rtB . nhwmxfcfh1 = ( ( ( ( ( look1_binlxpw ( ssGetT ( rtS ) , rtP . t , rtP .
Fw , 50000U ) + rtB . cz5qkzuy5d ) + pltcjqwgta ) - ( ( rtP . Css [ 0 ] * rtX
. bociztjmzk [ 0 ] + rtP . Css [ 1 ] * rtX . bociztjmzk [ 1 ] ) + rtP . Css [
2 ] * rtX . bociztjmzk [ 2 ] ) ) - rtP . Bext * rtB . ncxrjebmkf ) - rtP . Kb
* rtB . bmtrdfpnly ) * ( 1.0 / rtP . M ) ; UNUSED_PARAMETER ( tid ) ; } void
MdlOutputsTID2 ( int_T tid ) { UNUSED_PARAMETER ( tid ) ; } void MdlUpdate (
int_T tid ) { UNUSED_PARAMETER ( tid ) ; } void MdlUpdateTID2 ( int_T tid ) {
UNUSED_PARAMETER ( tid ) ; } void MdlDerivatives ( void ) { XDot * _rtXdot ;
real_T bociztjmzk ; real_T bociztjmzk_e ; real_T bociztjmzk_p ; int_T is ;
_rtXdot = ( ( XDot * ) ssGetdX ( rtS ) ) ; _rtXdot -> epym1iesyc = rtB .
nhwmxfcfh1 ; _rtXdot -> hjdhh5ncop = rtB . ncxrjebmkf ; _rtXdot -> gxmp3irrhw
= rtB . prxvsoismm ; bociztjmzk = rtX . bociztjmzk [ 1 ] ; bociztjmzk_p = rtX
. bociztjmzk [ 0 ] ; bociztjmzk_e = rtX . bociztjmzk [ 2 ] ; for ( is = 0 ;
is < 3 ; is ++ ) { _rtXdot -> bociztjmzk [ is ] = ( ( rtP . Ass [ is + 3 ] *
bociztjmzk + rtP . Ass [ is ] * bociztjmzk_p ) + rtP . Ass [ is + 6 ] *
bociztjmzk_e ) + rtP . Bss [ is ] * rtB . ncxrjebmkf ; } } void MdlProjection
( void ) { } void MdlTerminate ( void ) { { if ( rtDW . fxbogsmkbh .
AQHandles ) { sdiTerminateStreaming ( & rtDW . fxbogsmkbh . AQHandles ) ; } }
{ if ( rtDW . dl3cb1cmxx . AQHandles ) { sdiTerminateStreaming ( & rtDW .
dl3cb1cmxx . AQHandles ) ; } } { if ( rtDW . g0j45fsfoh . AQHandles ) {
sdiTerminateStreaming ( & rtDW . g0j45fsfoh . AQHandles ) ; } } { if ( rtDW .
oytvbckdqo . AQHandles ) { sdiTerminateStreaming ( & rtDW . oytvbckdqo .
AQHandles ) ; } } { if ( rtDW . fl0tshby2f . AQHandles ) {
sdiTerminateStreaming ( & rtDW . fl0tshby2f . AQHandles ) ; } } } static void
mr_Piston_cacheDataAsMxArray ( mxArray * destArray , mwIndex i , int j ,
const void * srcData , size_t numBytes ) ; static void
mr_Piston_cacheDataAsMxArray ( mxArray * destArray , mwIndex i , int j ,
const void * srcData , size_t numBytes ) { mxArray * newArray =
mxCreateUninitNumericMatrix ( ( size_t ) 1 , numBytes , mxUINT8_CLASS ,
mxREAL ) ; memcpy ( ( uint8_T * ) mxGetData ( newArray ) , ( const uint8_T *
) srcData , numBytes ) ; mxSetFieldByNumber ( destArray , i , j , newArray )
; } static void mr_Piston_restoreDataFromMxArray ( void * destData , const
mxArray * srcArray , mwIndex i , int j , size_t numBytes ) ; static void
mr_Piston_restoreDataFromMxArray ( void * destData , const mxArray * srcArray
, mwIndex i , int j , size_t numBytes ) { memcpy ( ( uint8_T * ) destData , (
const uint8_T * ) mxGetData ( mxGetFieldByNumber ( srcArray , i , j ) ) ,
numBytes ) ; } static void mr_Piston_cacheBitFieldToMxArray ( mxArray *
destArray , mwIndex i , int j , uint_T bitVal ) ; static void
mr_Piston_cacheBitFieldToMxArray ( mxArray * destArray , mwIndex i , int j ,
uint_T bitVal ) { mxSetFieldByNumber ( destArray , i , j ,
mxCreateDoubleScalar ( ( real_T ) bitVal ) ) ; } static uint_T
mr_Piston_extractBitFieldFromMxArray ( const mxArray * srcArray , mwIndex i ,
int j , uint_T numBits ) ; static uint_T mr_Piston_extractBitFieldFromMxArray
( const mxArray * srcArray , mwIndex i , int j , uint_T numBits ) { const
uint_T varVal = ( uint_T ) mxGetScalar ( mxGetFieldByNumber ( srcArray , i ,
j ) ) ; return varVal & ( ( 1u << numBits ) - 1u ) ; } static void
mr_Piston_cacheDataToMxArrayWithOffset ( mxArray * destArray , mwIndex i ,
int j , mwIndex offset , const void * srcData , size_t numBytes ) ; static
void mr_Piston_cacheDataToMxArrayWithOffset ( mxArray * destArray , mwIndex i
, int j , mwIndex offset , const void * srcData , size_t numBytes ) { uint8_T
* varData = ( uint8_T * ) mxGetData ( mxGetFieldByNumber ( destArray , i , j
) ) ; memcpy ( ( uint8_T * ) & varData [ offset * numBytes ] , ( const
uint8_T * ) srcData , numBytes ) ; } static void
mr_Piston_restoreDataFromMxArrayWithOffset ( void * destData , const mxArray
* srcArray , mwIndex i , int j , mwIndex offset , size_t numBytes ) ; static
void mr_Piston_restoreDataFromMxArrayWithOffset ( void * destData , const
mxArray * srcArray , mwIndex i , int j , mwIndex offset , size_t numBytes ) {
const uint8_T * varData = ( const uint8_T * ) mxGetData ( mxGetFieldByNumber
( srcArray , i , j ) ) ; memcpy ( ( uint8_T * ) destData , ( const uint8_T *
) & varData [ offset * numBytes ] , numBytes ) ; } static void
mr_Piston_cacheBitFieldToCellArrayWithOffset ( mxArray * destArray , mwIndex
i , int j , mwIndex offset , uint_T fieldVal ) ; static void
mr_Piston_cacheBitFieldToCellArrayWithOffset ( mxArray * destArray , mwIndex
i , int j , mwIndex offset , uint_T fieldVal ) { mxSetCell (
mxGetFieldByNumber ( destArray , i , j ) , offset , mxCreateDoubleScalar ( (
real_T ) fieldVal ) ) ; } static uint_T
mr_Piston_extractBitFieldFromCellArrayWithOffset ( const mxArray * srcArray ,
mwIndex i , int j , mwIndex offset , uint_T numBits ) ; static uint_T
mr_Piston_extractBitFieldFromCellArrayWithOffset ( const mxArray * srcArray ,
mwIndex i , int j , mwIndex offset , uint_T numBits ) { const uint_T fieldVal
= ( uint_T ) mxGetScalar ( mxGetCell ( mxGetFieldByNumber ( srcArray , i , j
) , offset ) ) ; return fieldVal & ( ( 1u << numBits ) - 1u ) ; } mxArray *
mr_Piston_GetDWork ( ) { static const char_T * ssDWFieldNames [ 3 ] = { "rtB"
, "rtDW" , "NULL_PrevZCX" , } ; mxArray * ssDW = mxCreateStructMatrix ( 1 , 1
, 3 , ssDWFieldNames ) ; mr_Piston_cacheDataAsMxArray ( ssDW , 0 , 0 , (
const void * ) & ( rtB ) , sizeof ( rtB ) ) ; { static const char_T *
rtdwDataFieldNames [ 6 ] = { "rtDW.nw1wamtli2" , "rtDW.lisshlsluy" ,
"rtDW.nfyedtg254" , "rtDW.c510mlrj2d" , "rtDW.k4ggkwi0ma" , "rtDW.j1mghhqlf3"
, } ; mxArray * rtdwData = mxCreateStructMatrix ( 1 , 1 , 6 ,
rtdwDataFieldNames ) ; mr_Piston_cacheDataAsMxArray ( rtdwData , 0 , 0 , (
const void * ) & ( rtDW . nw1wamtli2 ) , sizeof ( rtDW . nw1wamtli2 ) ) ;
mr_Piston_cacheDataAsMxArray ( rtdwData , 0 , 1 , ( const void * ) & ( rtDW .
lisshlsluy ) , sizeof ( rtDW . lisshlsluy ) ) ; mr_Piston_cacheDataAsMxArray
( rtdwData , 0 , 2 , ( const void * ) & ( rtDW . nfyedtg254 ) , sizeof ( rtDW
. nfyedtg254 ) ) ; mr_Piston_cacheDataAsMxArray ( rtdwData , 0 , 3 , ( const
void * ) & ( rtDW . c510mlrj2d ) , sizeof ( rtDW . c510mlrj2d ) ) ;
mr_Piston_cacheDataAsMxArray ( rtdwData , 0 , 4 , ( const void * ) & ( rtDW .
k4ggkwi0ma ) , sizeof ( rtDW . k4ggkwi0ma ) ) ; mr_Piston_cacheDataAsMxArray
( rtdwData , 0 , 5 , ( const void * ) & ( rtDW . j1mghhqlf3 ) , sizeof ( rtDW
. j1mghhqlf3 ) ) ; mxSetFieldByNumber ( ssDW , 0 , 1 , rtdwData ) ; } return
ssDW ; } void mr_Piston_SetDWork ( const mxArray * ssDW ) { ( void ) ssDW ;
mr_Piston_restoreDataFromMxArray ( ( void * ) & ( rtB ) , ssDW , 0 , 0 ,
sizeof ( rtB ) ) ; { const mxArray * rtdwData = mxGetFieldByNumber ( ssDW , 0
, 1 ) ; mr_Piston_restoreDataFromMxArray ( ( void * ) & ( rtDW . nw1wamtli2 )
, rtdwData , 0 , 0 , sizeof ( rtDW . nw1wamtli2 ) ) ;
mr_Piston_restoreDataFromMxArray ( ( void * ) & ( rtDW . lisshlsluy ) ,
rtdwData , 0 , 1 , sizeof ( rtDW . lisshlsluy ) ) ;
mr_Piston_restoreDataFromMxArray ( ( void * ) & ( rtDW . nfyedtg254 ) ,
rtdwData , 0 , 2 , sizeof ( rtDW . nfyedtg254 ) ) ;
mr_Piston_restoreDataFromMxArray ( ( void * ) & ( rtDW . c510mlrj2d ) ,
rtdwData , 0 , 3 , sizeof ( rtDW . c510mlrj2d ) ) ;
mr_Piston_restoreDataFromMxArray ( ( void * ) & ( rtDW . k4ggkwi0ma ) ,
rtdwData , 0 , 4 , sizeof ( rtDW . k4ggkwi0ma ) ) ;
mr_Piston_restoreDataFromMxArray ( ( void * ) & ( rtDW . j1mghhqlf3 ) ,
rtdwData , 0 , 5 , sizeof ( rtDW . j1mghhqlf3 ) ) ; } } mxArray *
mr_Piston_GetSimStateDisallowedBlocks ( ) { mxArray * data =
mxCreateCellMatrix ( 1 , 3 ) ; mwIndex subs [ 2 ] , offset ; { static const
char_T * blockType [ 1 ] = { "Scope" , } ; static const char_T * blockPath [
1 ] = { "Piston/FG - Position - Velocity1" , } ; static const int reason [ 1
] = { 0 , } ; for ( subs [ 0 ] = 0 ; subs [ 0 ] < 1 ; ++ ( subs [ 0 ] ) ) {
subs [ 1 ] = 0 ; offset = mxCalcSingleSubscript ( data , 2 , subs ) ;
mxSetCell ( data , offset , mxCreateString ( blockType [ subs [ 0 ] ] ) ) ;
subs [ 1 ] = 1 ; offset = mxCalcSingleSubscript ( data , 2 , subs ) ;
mxSetCell ( data , offset , mxCreateString ( blockPath [ subs [ 0 ] ] ) ) ;
subs [ 1 ] = 2 ; offset = mxCalcSingleSubscript ( data , 2 , subs ) ;
mxSetCell ( data , offset , mxCreateDoubleScalar ( ( real_T ) reason [ subs [
0 ] ] ) ) ; } } return data ; } void MdlInitializeSizes ( void ) {
ssSetNumContStates ( rtS , 6 ) ; ssSetNumPeriodicContStates ( rtS , 0 ) ;
ssSetNumY ( rtS , 0 ) ; ssSetNumU ( rtS , 0 ) ; ssSetDirectFeedThrough ( rtS
, 0 ) ; ssSetNumSampleTimes ( rtS , 2 ) ; ssSetNumBlocks ( rtS , 26 ) ;
ssSetNumBlockIO ( rtS , 9 ) ; ssSetNumBlockParams ( rtS , 226037 ) ; } void
MdlInitializeSampleTimes ( void ) { ssSetSampleTime ( rtS , 0 , 0.0 ) ;
ssSetSampleTime ( rtS , 1 , 0.001 ) ; ssSetOffsetTime ( rtS , 0 , 0.0 ) ;
ssSetOffsetTime ( rtS , 1 , 0.0 ) ; } void raccel_set_checksum ( ) {
ssSetChecksumVal ( rtS , 0 , 4275295741U ) ; ssSetChecksumVal ( rtS , 1 ,
1029146566U ) ; ssSetChecksumVal ( rtS , 2 , 465299512U ) ; ssSetChecksumVal
( rtS , 3 , 3139364417U ) ; }
#if defined(_MSC_VER)
#pragma optimize( "", off )
#endif
SimStruct * raccel_register_model ( ssExecutionInfo * executionInfo ) {
static struct _ssMdlInfo mdlInfo ; static struct _ssBlkInfo2 blkInfo2 ;
static struct _ssBlkInfoSLSize blkInfoSLSize ; rt_modelMapInfoPtr = & (
rt_dataMapInfo . mmi ) ; executionInfo -> gblObjects_ . numToFiles = 0 ;
executionInfo -> gblObjects_ . numFrFiles = 0 ; executionInfo -> gblObjects_
. numFrWksBlocks = 0 ; executionInfo -> gblObjects_ . numModelInputs = 0 ;
executionInfo -> gblObjects_ . numRootInportBlks = 0 ; executionInfo ->
gblObjects_ . inportDataTypeIdx = NULL ; executionInfo -> gblObjects_ .
inportDims = NULL ; executionInfo -> gblObjects_ . inportComplex = NULL ;
executionInfo -> gblObjects_ . inportInterpoFlag = NULL ; executionInfo ->
gblObjects_ . inportContinuous = NULL ; ( void ) memset ( ( char_T * ) rtS ,
0 , sizeof ( SimStruct ) ) ; ( void ) memset ( ( char_T * ) & mdlInfo , 0 ,
sizeof ( struct _ssMdlInfo ) ) ; ( void ) memset ( ( char_T * ) & blkInfo2 ,
0 , sizeof ( struct _ssBlkInfo2 ) ) ; ( void ) memset ( ( char_T * ) &
blkInfoSLSize , 0 , sizeof ( struct _ssBlkInfoSLSize ) ) ; ssSetBlkInfo2Ptr (
rtS , & blkInfo2 ) ; ssSetBlkInfoSLSizePtr ( rtS , & blkInfoSLSize ) ;
ssSetMdlInfoPtr ( rtS , & mdlInfo ) ; ssSetExecutionInfo ( rtS ,
executionInfo ) ; slsaAllocOPModelData ( rtS ) ; { static time_T mdlPeriod [
NSAMPLE_TIMES ] ; static time_T mdlOffset [ NSAMPLE_TIMES ] ; static time_T
mdlTaskTimes [ NSAMPLE_TIMES ] ; static int_T mdlTsMap [ NSAMPLE_TIMES ] ;
static int_T mdlSampleHits [ NSAMPLE_TIMES ] ; static boolean_T
mdlTNextWasAdjustedPtr [ NSAMPLE_TIMES ] ; static int_T mdlPerTaskSampleHits
[ NSAMPLE_TIMES * NSAMPLE_TIMES ] ; static time_T mdlTimeOfNextSampleHit [
NSAMPLE_TIMES ] ; { int_T i ; for ( i = 0 ; i < NSAMPLE_TIMES ; i ++ ) {
mdlPeriod [ i ] = 0.0 ; mdlOffset [ i ] = 0.0 ; mdlTaskTimes [ i ] = 0.0 ;
mdlTsMap [ i ] = i ; mdlSampleHits [ i ] = 1 ; } } ssSetSampleTimePtr ( rtS ,
& mdlPeriod [ 0 ] ) ; ssSetOffsetTimePtr ( rtS , & mdlOffset [ 0 ] ) ;
ssSetSampleTimeTaskIDPtr ( rtS , & mdlTsMap [ 0 ] ) ; ssSetTPtr ( rtS , &
mdlTaskTimes [ 0 ] ) ; ssSetSampleHitPtr ( rtS , & mdlSampleHits [ 0 ] ) ;
ssSetTNextWasAdjustedPtr ( rtS , & mdlTNextWasAdjustedPtr [ 0 ] ) ;
ssSetPerTaskSampleHitsPtr ( rtS , & mdlPerTaskSampleHits [ 0 ] ) ;
ssSetTimeOfNextSampleHitPtr ( rtS , & mdlTimeOfNextSampleHit [ 0 ] ) ; }
ssSetSolverMode ( rtS , SOLVER_MODE_SINGLETASKING ) ; { ssSetBlockIO ( rtS ,
( ( void * ) & rtB ) ) ; ( void ) memset ( ( ( void * ) & rtB ) , 0 , sizeof
( B ) ) ; } { real_T * x = ( real_T * ) & rtX ; ssSetContStates ( rtS , x ) ;
( void ) memset ( ( void * ) x , 0 , sizeof ( X ) ) ; } { void * dwork = (
void * ) & rtDW ; ssSetRootDWork ( rtS , dwork ) ; ( void ) memset ( dwork ,
0 , sizeof ( DW ) ) ; } { static DataTypeTransInfo dtInfo ; ( void ) memset (
( char_T * ) & dtInfo , 0 , sizeof ( dtInfo ) ) ; ssSetModelMappingInfo ( rtS
, & dtInfo ) ; dtInfo . numDataTypes = 23 ; dtInfo . dataTypeSizes = &
rtDataTypeSizes [ 0 ] ; dtInfo . dataTypeNames = & rtDataTypeNames [ 0 ] ;
dtInfo . BTransTable = & rtBTransTable ; dtInfo . PTransTable = &
rtPTransTable ; dtInfo . dataTypeInfoTable = rtDataTypeInfoTable ; }
Piston_InitializeDataMapInfo ( ) ; ssSetIsRapidAcceleratorActive ( rtS , true
) ; ssSetRootSS ( rtS , rtS ) ; ssSetVersion ( rtS , SIMSTRUCT_VERSION_LEVEL2
) ; ssSetModelName ( rtS , "Piston" ) ; ssSetPath ( rtS , "Piston" ) ;
ssSetTStart ( rtS , 0.0 ) ; ssSetTFinal ( rtS , 75.0 ) ; ssSetStepSize ( rtS
, 0.001 ) ; ssSetFixedStepSize ( rtS , 0.001 ) ; { static RTWLogInfo
rt_DataLoggingInfo ; rt_DataLoggingInfo . loggingInterval = ( NULL ) ;
ssSetRTWLogInfo ( rtS , & rt_DataLoggingInfo ) ; } { { static int_T
rt_LoggedStateWidths [ ] = { 1 , 1 , 1 , 3 } ; static int_T
rt_LoggedStateNumDimensions [ ] = { 1 , 1 , 1 , 1 } ; static int_T
rt_LoggedStateDimensions [ ] = { 1 , 1 , 1 , 3 } ; static boolean_T
rt_LoggedStateIsVarDims [ ] = { 0 , 0 , 0 , 0 } ; static BuiltInDTypeId
rt_LoggedStateDataTypeIds [ ] = { SS_DOUBLE , SS_DOUBLE , SS_DOUBLE ,
SS_DOUBLE } ; static int_T rt_LoggedStateComplexSignals [ ] = { 0 , 0 , 0 , 0
} ; static RTWPreprocessingFcnPtr rt_LoggingStatePreprocessingFcnPtrs [ ] = {
( NULL ) , ( NULL ) , ( NULL ) , ( NULL ) } ; static const char_T *
rt_LoggedStateLabels [ ] = { "CSTATE" , "CSTATE" , "CSTATE" , "CSTATE" } ;
static const char_T * rt_LoggedStateBlockNames [ ] = { "Piston/Integrator4" ,
"Piston/Integrator5" , "Piston/Integrator1" , "Piston/State-Space2" } ;
static const char_T * rt_LoggedStateNames [ ] = { "" , "" , "" , "" } ;
static boolean_T rt_LoggedStateCrossMdlRef [ ] = { 0 , 0 , 0 , 0 } ; static
RTWLogDataTypeConvert rt_RTWLogDataTypeConvert [ ] = { { 0 , SS_DOUBLE ,
SS_DOUBLE , 0 , 0 , 0 , 1.0 , 0 , 0.0 } , { 0 , SS_DOUBLE , SS_DOUBLE , 0 , 0
, 0 , 1.0 , 0 , 0.0 } , { 0 , SS_DOUBLE , SS_DOUBLE , 0 , 0 , 0 , 1.0 , 0 ,
0.0 } , { 0 , SS_DOUBLE , SS_DOUBLE , 0 , 0 , 0 , 1.0 , 0 , 0.0 } } ; static
int_T rt_LoggedStateIdxList [ ] = { 0 , 1 , 2 , 3 } ; static RTWLogSignalInfo
rt_LoggedStateSignalInfo = { 4 , rt_LoggedStateWidths ,
rt_LoggedStateNumDimensions , rt_LoggedStateDimensions ,
rt_LoggedStateIsVarDims , ( NULL ) , ( NULL ) , rt_LoggedStateDataTypeIds ,
rt_LoggedStateComplexSignals , ( NULL ) , rt_LoggingStatePreprocessingFcnPtrs
, { rt_LoggedStateLabels } , ( NULL ) , ( NULL ) , ( NULL ) , {
rt_LoggedStateBlockNames } , { rt_LoggedStateNames } ,
rt_LoggedStateCrossMdlRef , rt_RTWLogDataTypeConvert , rt_LoggedStateIdxList
} ; static void * rt_LoggedStateSignalPtrs [ 4 ] ; rtliSetLogXSignalPtrs (
ssGetRTWLogInfo ( rtS ) , ( LogSignalPtrsType ) rt_LoggedStateSignalPtrs ) ;
rtliSetLogXSignalInfo ( ssGetRTWLogInfo ( rtS ) , & rt_LoggedStateSignalInfo
) ; rt_LoggedStateSignalPtrs [ 0 ] = ( void * ) & rtX . epym1iesyc ;
rt_LoggedStateSignalPtrs [ 1 ] = ( void * ) & rtX . hjdhh5ncop ;
rt_LoggedStateSignalPtrs [ 2 ] = ( void * ) & rtX . gxmp3irrhw ;
rt_LoggedStateSignalPtrs [ 3 ] = ( void * ) & rtX . bociztjmzk [ 0 ] ; }
rtliSetLogT ( ssGetRTWLogInfo ( rtS ) , "tout" ) ; rtliSetLogX (
ssGetRTWLogInfo ( rtS ) , "" ) ; rtliSetLogXFinal ( ssGetRTWLogInfo ( rtS ) ,
"xFinal" ) ; rtliSetLogVarNameModifier ( ssGetRTWLogInfo ( rtS ) , "none" ) ;
rtliSetLogFormat ( ssGetRTWLogInfo ( rtS ) , 4 ) ; rtliSetLogMaxRows (
ssGetRTWLogInfo ( rtS ) , 0 ) ; rtliSetLogDecimation ( ssGetRTWLogInfo ( rtS
) , 1 ) ; rtliSetLogY ( ssGetRTWLogInfo ( rtS ) , "" ) ;
rtliSetLogYSignalInfo ( ssGetRTWLogInfo ( rtS ) , ( NULL ) ) ;
rtliSetLogYSignalPtrs ( ssGetRTWLogInfo ( rtS ) , ( NULL ) ) ; } { static
struct _ssStatesInfo2 statesInfo2 ; ssSetStatesInfo2 ( rtS , & statesInfo2 )
; } { static ssPeriodicStatesInfo periodicStatesInfo ;
ssSetPeriodicStatesInfo ( rtS , & periodicStatesInfo ) ; } { static
ssJacobianPerturbationBounds jacobianPerturbationBounds ;
ssSetJacobianPerturbationBounds ( rtS , & jacobianPerturbationBounds ) ; } {
static ssSolverInfo slvrInfo ; static boolean_T contStatesDisabled [ 6 ] ;
ssSetNumNonContDerivSigInfos ( rtS , 0 ) ; ssSetNonContDerivSigInfos ( rtS ,
( NULL ) ) ; ssSetSolverInfo ( rtS , & slvrInfo ) ; ssSetSolverName ( rtS ,
"ode3" ) ; ssSetVariableStepSolver ( rtS , 0 ) ;
ssSetSolverConsistencyChecking ( rtS , 0 ) ; ssSetSolverAdaptiveZcDetection (
rtS , 0 ) ; ssSetSolverRobustResetMethod ( rtS , 0 ) ;
ssSetSolverStateProjection ( rtS , 0 ) ; ssSetSolverMassMatrixType ( rtS , (
ssMatrixType ) 0 ) ; ssSetSolverMassMatrixNzMax ( rtS , 0 ) ;
ssSetModelOutputs ( rtS , MdlOutputs ) ; ssSetModelUpdate ( rtS , MdlUpdate )
; ssSetModelDerivatives ( rtS , MdlDerivatives ) ; ssSetTNextTid ( rtS ,
INT_MIN ) ; ssSetTNext ( rtS , rtMinusInf ) ; ssSetSolverNeedsReset ( rtS ) ;
ssSetNumNonsampledZCs ( rtS , 0 ) ; ssSetContStateDisabled ( rtS ,
contStatesDisabled ) ; } ssSetChecksumVal ( rtS , 0 , 4275295741U ) ;
ssSetChecksumVal ( rtS , 1 , 1029146566U ) ; ssSetChecksumVal ( rtS , 2 ,
465299512U ) ; ssSetChecksumVal ( rtS , 3 , 3139364417U ) ; { static const
sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE ; static RTWExtModeInfo
rt_ExtModeInfo ; static const sysRanDType * systemRan [ 3 ] ;
gblRTWExtModeInfo = & rt_ExtModeInfo ; ssSetRTWExtModeInfo ( rtS , &
rt_ExtModeInfo ) ; rteiSetSubSystemActiveVectorAddresses ( & rt_ExtModeInfo ,
systemRan ) ; systemRan [ 0 ] = & rtAlwaysEnabled ; systemRan [ 1 ] = &
rtAlwaysEnabled ; systemRan [ 2 ] = & rtAlwaysEnabled ;
rteiSetModelMappingInfoPtr ( ssGetRTWExtModeInfo ( rtS ) , &
ssGetModelMappingInfo ( rtS ) ) ; rteiSetChecksumsPtr ( ssGetRTWExtModeInfo (
rtS ) , ssGetChecksums ( rtS ) ) ; rteiSetTPtr ( ssGetRTWExtModeInfo ( rtS )
, ssGetTPtr ( rtS ) ) ; } slsaDisallowedBlocksForSimTargetOP ( rtS ,
mr_Piston_GetSimStateDisallowedBlocks ) ; slsaGetWorkFcnForSimTargetOP ( rtS
, mr_Piston_GetDWork ) ; slsaSetWorkFcnForSimTargetOP ( rtS ,
mr_Piston_SetDWork ) ; rt_RapidReadMatFileAndUpdateParams ( rtS ) ; if (
ssGetErrorStatus ( rtS ) ) { return rtS ; } return rtS ; }
#if defined(_MSC_VER)
#pragma optimize( "", on )
#endif
void MdlOutputsParameterSampleTime ( int_T tid ) { MdlOutputsTID2 ( tid ) ; }
