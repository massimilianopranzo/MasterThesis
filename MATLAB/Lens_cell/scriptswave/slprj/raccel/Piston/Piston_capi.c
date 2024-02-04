#include "rtw_capi.h"
#ifdef HOST_CAPI_BUILD
#include "Piston_capi_host.h"
#define sizeof(s) ((size_t)(0xFFFF))
#undef rt_offsetof
#define rt_offsetof(s,el) ((uint16_T)(0xFFFF))
#define TARGET_CONST
#define TARGET_STRING(s) (s)
#ifndef SS_UINT64
#define SS_UINT64 17
#endif
#ifndef SS_INT64
#define SS_INT64 18
#endif
#else
#include "builtin_typeid_types.h"
#include "Piston.h"
#include "Piston_capi.h"
#include "Piston_private.h"
#ifdef LIGHT_WEIGHT_CAPI
#define TARGET_CONST
#define TARGET_STRING(s)               ((NULL))
#else
#define TARGET_CONST                   const
#define TARGET_STRING(s)               (s)
#endif
#endif
static const rtwCAPI_Signals rtBlockSignals [ ] = { { 0 , 0 , TARGET_STRING (
"Piston/End-Stop force1/is_active_c2_Piston" ) , TARGET_STRING (
"is_active_c2_Piston" ) , 0 , 0 , 0 , 0 , 0 } , { 1 , 0 , TARGET_STRING (
"Piston/Gain3" ) , TARGET_STRING ( "Acceleration" ) , 0 , 1 , 0 , 0 , 0 } , {
2 , 0 , TARGET_STRING ( "Piston/Integrator1" ) , TARGET_STRING ( "" ) , 0 , 1
, 0 , 0 , 0 } , { 3 , 0 , TARGET_STRING ( "Piston/Integrator4" ) ,
TARGET_STRING ( "Velocity" ) , 0 , 1 , 0 , 0 , 0 } , { 4 , 0 , TARGET_STRING
( "Piston/Integrator5" ) , TARGET_STRING ( "Position" ) , 0 , 1 , 0 , 0 , 0 }
, { 5 , 0 , TARGET_STRING ( "Piston/Product1" ) , TARGET_STRING ( "" ) , 0 ,
1 , 0 , 0 , 0 } , { 6 , 0 , TARGET_STRING (
"Piston/FG(z, V1, V2)1/Check velocity/is_active_c4_Piston" ) , TARGET_STRING
( "is_active_c4_Piston" ) , 0 , 0 , 0 , 0 , 0 } , { 7 , 0 , TARGET_STRING (
"Piston/FG(z, V1, V2)1/Sum1" ) , TARGET_STRING ( "" ) , 0 , 1 , 0 , 0 , 0 } ,
{ 0 , 0 , ( NULL ) , ( NULL ) , 0 , 0 , 0 , 0 , 0 } } ; static const
rtwCAPI_BlockParameters rtBlockParameters [ ] = { { 8 , TARGET_STRING (
"Piston/Integrator1" ) , TARGET_STRING ( "InitialCondition" ) , 1 , 0 , 0 } ,
{ 9 , TARGET_STRING ( "Piston/Integrator4" ) , TARGET_STRING (
"InitialCondition" ) , 1 , 0 , 0 } , { 10 , TARGET_STRING (
"Piston/Integrator5" ) , TARGET_STRING ( "InitialCondition" ) , 1 , 0 , 0 } ,
{ 11 , TARGET_STRING ( "Piston/State-Space2" ) , TARGET_STRING (
"InitialCondition" ) , 1 , 0 , 0 } , { 12 , TARGET_STRING (
"Piston/FG(z, V1, V2)1/Gain" ) , TARGET_STRING ( "Gain" ) , 1 , 0 , 0 } , {
13 , TARGET_STRING ( "Piston/FG(z, V1, V2)1/Fs1" ) , TARGET_STRING (
"maxIndex" ) , 2 , 1 , 0 } , { 14 , TARGET_STRING (
"Piston/FG(z, V1, V2)1/Fs2" ) , TARGET_STRING ( "maxIndex" ) , 2 , 1 , 0 } ,
{ 0 , ( NULL ) , ( NULL ) , 0 , 0 , 0 } } ; static int_T
rt_LoggedStateIdxList [ ] = { - 1 } ; static const rtwCAPI_Signals
rtRootInputs [ ] = { { 0 , 0 , ( NULL ) , ( NULL ) , 0 , 0 , 0 , 0 , 0 } } ;
static const rtwCAPI_Signals rtRootOutputs [ ] = { { 0 , 0 , ( NULL ) , (
NULL ) , 0 , 0 , 0 , 0 , 0 } } ; static const rtwCAPI_ModelParameters
rtModelParameters [ ] = { { 15 , TARGET_STRING ( "Ass" ) , 1 , 2 , 0 } , { 16
, TARGET_STRING ( "Bes" ) , 1 , 0 , 0 } , { 17 , TARGET_STRING ( "Bext" ) , 1
, 0 , 0 } , { 18 , TARGET_STRING ( "Bss" ) , 1 , 3 , 0 } , { 19 ,
TARGET_STRING ( "Css" ) , 1 , 4 , 0 } , { 20 , TARGET_STRING ( "Fs1data" ) ,
1 , 5 , 0 } , { 21 , TARGET_STRING ( "Fw" ) , 1 , 6 , 0 } , { 22 ,
TARGET_STRING ( "Kb" ) , 1 , 0 , 0 } , { 23 , TARGET_STRING ( "Kes" ) , 1 , 0
, 0 } , { 24 , TARGET_STRING ( "M" ) , 1 , 0 , 0 } , { 25 , TARGET_STRING (
"V1data" ) , 1 , 7 , 0 } , { 26 , TARGET_STRING ( "V1max" ) , 1 , 0 , 0 } , {
27 , TARGET_STRING ( "V2max" ) , 1 , 0 , 0 } , { 28 , TARGET_STRING ( "Vmax"
) , 1 , 0 , 0 } , { 29 , TARGET_STRING ( "alpha" ) , 1 , 0 , 0 } , { 30 ,
TARGET_STRING ( "d" ) , 1 , 0 , 0 } , { 31 , TARGET_STRING ( "t" ) , 1 , 6 ,
0 } , { 32 , TARGET_STRING ( "z1data" ) , 1 , 8 , 0 } , { 0 , ( NULL ) , 0 ,
0 , 0 } } ;
#ifndef HOST_CAPI_BUILD
static void * rtDataAddrMap [ ] = { & rtDW . c510mlrj2d , & rtB . nhwmxfcfh1
, & rtB . kebpnhv3nu , & rtB . ncxrjebmkf , & rtB . bmtrdfpnly , & rtB .
prxvsoismm , & rtDW . nfyedtg254 , & rtB . cz5qkzuy5d , & rtP .
Integrator1_IC , & rtP . Integrator4_IC , & rtP . Integrator5_IC , & rtP .
StateSpace2_InitialCondition , & rtP . Gain_Gain , & rtP . Fs1_maxIndex [ 0 ]
, & rtP . Fs2_maxIndex [ 0 ] , & rtP . Ass [ 0 ] , & rtP . Bes , & rtP . Bext
, & rtP . Bss [ 0 ] , & rtP . Css [ 0 ] , & rtP . Fs1data [ 0 ] , & rtP . Fw
[ 0 ] , & rtP . Kb , & rtP . Kes , & rtP . M , & rtP . V1data [ 0 ] , & rtP .
V1max , & rtP . V2max , & rtP . Vmax , & rtP . alpha , & rtP . d , & rtP . t
[ 0 ] , & rtP . z1data [ 0 ] , } ; static int32_T * rtVarDimsAddrMap [ ] = {
( NULL ) } ;
#endif
static TARGET_CONST rtwCAPI_DataTypeMap rtDataTypeMap [ ] = { {
"unsigned char" , "uint8_T" , 0 , 0 , sizeof ( uint8_T ) , ( uint8_T )
SS_UINT8 , 0 , 0 , 0 } , { "double" , "real_T" , 0 , 0 , sizeof ( real_T ) ,
( uint8_T ) SS_DOUBLE , 0 , 0 , 0 } , { "unsigned int" , "uint32_T" , 0 , 0 ,
sizeof ( uint32_T ) , ( uint8_T ) SS_UINT32 , 0 , 0 , 0 } } ;
#ifdef HOST_CAPI_BUILD
#undef sizeof
#endif
static TARGET_CONST rtwCAPI_ElementMap rtElementMap [ ] = { { ( NULL ) , 0 ,
0 , 0 , 0 } , } ; static const rtwCAPI_DimensionMap rtDimensionMap [ ] = { {
rtwCAPI_SCALAR , 0 , 2 , 0 } , { rtwCAPI_VECTOR , 2 , 2 , 0 } , {
rtwCAPI_MATRIX_COL_MAJOR , 4 , 2 , 0 } , { rtwCAPI_VECTOR , 6 , 2 , 0 } , {
rtwCAPI_VECTOR , 8 , 2 , 0 } , { rtwCAPI_MATRIX_COL_MAJOR , 10 , 2 , 0 } , {
rtwCAPI_VECTOR , 12 , 2 , 0 } , { rtwCAPI_VECTOR , 14 , 2 , 0 } , {
rtwCAPI_VECTOR , 16 , 2 , 0 } } ; static const uint_T rtDimensionArray [ ] =
{ 1 , 1 , 2 , 1 , 3 , 3 , 3 , 1 , 1 , 3 , 501 , 250 , 50001 , 1 , 501 , 1 ,
250 , 1 } ; static const real_T rtcapiStoredFloats [ ] = { 0.0 } ; static
const rtwCAPI_FixPtMap rtFixPtMap [ ] = { { ( NULL ) , ( NULL ) ,
rtwCAPI_FIX_RESERVED , 0 , 0 , ( boolean_T ) 0 } , } ; static const
rtwCAPI_SampleTimeMap rtSampleTimeMap [ ] = { { ( const void * ) &
rtcapiStoredFloats [ 0 ] , ( const void * ) & rtcapiStoredFloats [ 0 ] , (
int8_T ) 0 , ( uint8_T ) 0 } } ; static rtwCAPI_ModelMappingStaticInfo
mmiStatic = { { rtBlockSignals , 8 , rtRootInputs , 0 , rtRootOutputs , 0 } ,
{ rtBlockParameters , 7 , rtModelParameters , 18 } , { ( NULL ) , 0 } , {
rtDataTypeMap , rtDimensionMap , rtFixPtMap , rtElementMap , rtSampleTimeMap
, rtDimensionArray } , "float" , { 4275295741U , 1029146566U , 465299512U ,
3139364417U } , ( NULL ) , 0 , ( boolean_T ) 0 , rt_LoggedStateIdxList } ;
const rtwCAPI_ModelMappingStaticInfo * Piston_GetCAPIStaticMap ( void ) {
return & mmiStatic ; }
#ifndef HOST_CAPI_BUILD
void Piston_InitializeDataMapInfo ( void ) { rtwCAPI_SetVersion ( ( *
rt_dataMapInfoPtr ) . mmi , 1 ) ; rtwCAPI_SetStaticMap ( ( *
rt_dataMapInfoPtr ) . mmi , & mmiStatic ) ; rtwCAPI_SetLoggingStaticMap ( ( *
rt_dataMapInfoPtr ) . mmi , ( NULL ) ) ; rtwCAPI_SetDataAddressMap ( ( *
rt_dataMapInfoPtr ) . mmi , rtDataAddrMap ) ; rtwCAPI_SetVarDimsAddressMap (
( * rt_dataMapInfoPtr ) . mmi , rtVarDimsAddrMap ) ;
rtwCAPI_SetInstanceLoggingInfo ( ( * rt_dataMapInfoPtr ) . mmi , ( NULL ) ) ;
rtwCAPI_SetChildMMIArray ( ( * rt_dataMapInfoPtr ) . mmi , ( NULL ) ) ;
rtwCAPI_SetChildMMIArrayLen ( ( * rt_dataMapInfoPtr ) . mmi , 0 ) ; }
#else
#ifdef __cplusplus
extern "C" {
#endif
void Piston_host_InitializeDataMapInfo ( Piston_host_DataMapInfo_T * dataMap
, const char * path ) { rtwCAPI_SetVersion ( dataMap -> mmi , 1 ) ;
rtwCAPI_SetStaticMap ( dataMap -> mmi , & mmiStatic ) ;
rtwCAPI_SetDataAddressMap ( dataMap -> mmi , ( NULL ) ) ;
rtwCAPI_SetVarDimsAddressMap ( dataMap -> mmi , ( NULL ) ) ; rtwCAPI_SetPath
( dataMap -> mmi , path ) ; rtwCAPI_SetFullPath ( dataMap -> mmi , ( NULL ) )
; rtwCAPI_SetChildMMIArray ( dataMap -> mmi , ( NULL ) ) ;
rtwCAPI_SetChildMMIArrayLen ( dataMap -> mmi , 0 ) ; }
#ifdef __cplusplus
}
#endif
#endif
