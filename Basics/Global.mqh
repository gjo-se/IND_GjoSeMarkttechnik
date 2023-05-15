//+------------------------------------------------------------------+
//|                                                      Global.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

CTradeHedge Trade;
CPending    Pending;
CPositions  Positions;
CBars       SGL_Bar;
CBars       GWL_Bar;
CBars       M1_Bar;
CBars       M5_Bar;
CBars       H2_Bar;
CBars       H4_Bar;
CTrailing   Trail;
CTimer      Timer;
CNewBar     NewBar;

struct PointStruct {
   double   Point_1_Value;
   datetime Point_1_Datetime;
   double   Point_2_Value;
   datetime Point_2_Datetime;
   double   Point_3_Value;
   datetime Point_3_Datetime;
   double   Point_4_Value;
   datetime Point_4_Datetime;
   double   Point_5_Value;
   datetime Point_5_Datetime;
};
PointStruct pointStruct;

bool sendAlert = false;

int iCustomZigZagHandle;
double iCustomZigZagArray[];



//CiMA        GWL_MA;
//CiMA        SGL_MA_SLOW;
//CiMA        SGL_MA_MIDDLE;
//CiMA        SGL_MA_FAST;
//CiMA        M1_MA_SLOW;
//CiMA        M1_MA_MIDDLE;
//CiMA        M1_MA_FAST;
//CiBollinger SGL_Bollinger;
//CiRSI       SGL_RSI;
//CiRSI       M1_RSI;

//CDealInfo   Deal;
//TCustomCriterionArray   *criterion_Ptr;
//
//long  positionTickets[];
//long  positionGroups[][11];
//long  positionGroupsTmp[][11];
//long  dealGroups[][200];
//long  dealGroupsTmp[][200];
//long  dealGroupProfit[][2];
//long  dealGroupProfitTmp[][2];

//bool    printMessages = true;
//int      tickvolumeHandle;
//double   tickVolumeBuffer[];
//int      gwlTrendHandle;
//double   gwlTrendBuffer[];
//int      sglTrendHandle;
//double   sglTrendBuffer[];
//int      gwlTrend;
//double   gwlSessionMaxTrendStrength;
//int      sglTrend;
//double   sglSessionMaxTrendStrength;
//int      trend;
//bool     buyIsTradeable;
//bool     sellIsTradeable;
//bool     alert;
//double   lastPrice;

//int      equityDDHandle;
//double   equityDDBuffer[];
//int      equityDDDynamicHandle;
//double   equityDDDynamicBuffer[];
//int      sglDynamicHandle;
//int      gwlDynamicHandle;
//int      trendHandle;
//double   buyDynamicBuffer[];
//double   sellDynamicBuffer[];

// SGL
//double   sglDynamicFastSlowBuffer[];
//double   sglDynamicFastSlowColorBuffer[];
//double   sglDynamicFastSlowSignalBuffer[];
//double   sglDynamicFastSlowSignalColorBuffer[];
////double   sglDynamicMiddleSelfBuffer[];
//double   sglDynamicMiddleSlowBuffer[];
//double   sglDynamicSlowSelfBuffer[];

//double   trendBuffer[];
//
//// GWL
//double   gwlDynamicFastSlowBuffer[];
//double   gwlDynamicFastSlowColorBuffer[];
//double   gwlDynamicFastSlowSignalBuffer[];
//double   gwlDynamicFastSlowSignalColorBuffer[];
//
////double   gwlDynamicMiddleSelfBuffer[];
//double   gwlDynamicMiddleSlowBuffer[];
////double   gwlDynamicSlowSelfBuffer[];
//
//bool openBuyPositionsFilter;
//bool dynamicIsHigherMINDynamicBuyInSignalIsTriggert;
//int   fastCrossedSlowFromAboveIndex;
//
//// nextLevel
//double   nextBuyLevel;
//double   nextSellLevel;
//
//// Security
//double   nextEquityDD;
//double   equityDD;
//bool     securityStop;
//bool     restartAfterEquityDD_Out;
//
//datetime lastHistoryCall;
//+------------------------------------------------------------------+
