#ifndef RTW_HEADER_Piston_h_
#define RTW_HEADER_Piston_h_
#ifndef Piston_COMMON_INCLUDES_
#define Piston_COMMON_INCLUDES_
#include <stdlib.h>
#include "sl_AsyncioQueue/AsyncioQueueCAPI.h"
#include "rtwtypes.h"
#include "sigstream_rtw.h"
#include "simtarget/slSimTgtSigstreamRTW.h"
#include "simtarget/slSimTgtSlioCoreRTW.h"
#include "simtarget/slSimTgtSlioClientsRTW.h"
#include "simtarget/slSimTgtSlioSdiRTW.h"
#include "simstruc.h"
#include "fixedpoint.h"
#include "raccel.h"
#include "slsv_diagnostic_codegen_c_api.h"
#include "rt_logging_simtarget.h"
#include "dt_info.h"
#include "ext_work.h"
#endif
#include "Piston_types.h"
#include <stddef.h>
#include "rtw_modelmap_simtarget.h"
#include "rt_defines.h"
#include <string.h>
#include "rt_nonfinite.h"
#define MODEL_NAME Piston
#define NSAMPLE_TIMES (3) 
#define NINPUTS (0)       
#define NOUTPUTS (0)     
#define NBLOCKIO (9) 
#define NUM_ZC_EVENTS (0) 
#ifndef NCSTATES
#define NCSTATES (6)   
#elif NCSTATES != 6
#error Invalid specification of NCSTATES defined in compiler command
#endif
#ifndef rtmGetDataMapInfo
#define rtmGetDataMapInfo(rtm) (*rt_dataMapInfoPtr)
#endif
#ifndef rtmSetDataMapInfo
#define rtmSetDataMapInfo(rtm, val) (rt_dataMapInfoPtr = &val)
#endif
#ifndef IN_RACCEL_MAIN
#endif
typedef struct { real_T ncxrjebmkf ; real_T bmtrdfpnly ; real_T cz5qkzuy5d ;
real_T kebpnhv3nu ; real_T prxvsoismm ; real_T nhwmxfcfh1 ; } B ; typedef
struct { struct { void * LoggedData [ 3 ] ; } pn1w25njy4 ; struct { void *
AQHandles ; } fxbogsmkbh ; struct { void * AQHandles ; } dl3cb1cmxx ; struct
{ void * AQHandles ; } g0j45fsfoh ; struct { void * AQHandles ; } oytvbckdqo
; struct { void * AQHandles ; } fl0tshby2f ; int32_T nw1wamtli2 ; int32_T
lisshlsluy ; uint8_T nfyedtg254 ; uint8_T c510mlrj2d ; boolean_T k4ggkwi0ma ;
boolean_T j1mghhqlf3 ; } DW ; typedef struct { real_T epym1iesyc ; real_T
hjdhh5ncop ; real_T gxmp3irrhw ; real_T bociztjmzk [ 3 ] ; } X ; typedef
struct { real_T epym1iesyc ; real_T hjdhh5ncop ; real_T gxmp3irrhw ; real_T
bociztjmzk [ 3 ] ; } XDot ; typedef struct { boolean_T epym1iesyc ; boolean_T
hjdhh5ncop ; boolean_T gxmp3irrhw ; boolean_T bociztjmzk [ 3 ] ; } XDis ;
typedef struct { rtwCAPI_ModelMappingInfo mmi ; } DataMapInfo ; struct P_ {
real_T Ass [ 9 ] ; real_T Bes ; real_T Bext ; real_T Bss [ 3 ] ; real_T Css [
3 ] ; real_T Fs1data [ 125250 ] ; real_T Fw [ 50001 ] ; real_T Kb ; real_T
Kes ; real_T M ; real_T V1data [ 501 ] ; real_T V1max ; real_T V2max ; real_T
Vmax ; real_T alpha ; real_T d ; real_T t [ 50001 ] ; real_T z1data [ 250 ] ;
real_T Integrator4_IC ; real_T Integrator5_IC ; real_T Gain_Gain ; real_T
Integrator1_IC ; real_T StateSpace2_InitialCondition ; uint32_T Fs1_maxIndex
[ 2 ] ; uint32_T Fs2_maxIndex [ 2 ] ; } ; extern const char_T *
RT_MEMORY_ALLOCATION_ERROR ; extern B rtB ; extern X rtX ; extern DW rtDW ;
extern P rtP ; extern mxArray * mr_Piston_GetDWork ( ) ; extern void
mr_Piston_SetDWork ( const mxArray * ssDW ) ; extern mxArray *
mr_Piston_GetSimStateDisallowedBlocks ( ) ; extern const
rtwCAPI_ModelMappingStaticInfo * Piston_GetCAPIStaticMap ( void ) ; extern
SimStruct * const rtS ; extern DataMapInfo * rt_dataMapInfoPtr ; extern
rtwCAPI_ModelMappingInfo * rt_modelMapInfoPtr ; void MdlOutputs ( int_T tid )
; void MdlOutputsParameterSampleTime ( int_T tid ) ; void MdlUpdate ( int_T
tid ) ; void MdlTerminate ( void ) ; void MdlInitializeSizes ( void ) ; void
MdlInitializeSampleTimes ( void ) ; SimStruct * raccel_register_model (
ssExecutionInfo * executionInfo ) ;
#endif
