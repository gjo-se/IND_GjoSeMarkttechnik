/*

   IND_GjoSeMarktTechnik.mq5
   Copyright 2022, Gregory Jo
   https://www.gjo-se.com

   Version History
   ===============

   1.0.0 Initial version

   ===============

//*/
#include "Basics\\Includes.mqh"

#property   copyright   "2021, GjoSe"
#property   link        "http://www.gjo-se.com"
#property   description "GjoSe MarktTechnik"
#define     VERSION "1.0.0"
#property   version VERSION
#property   strict

#property indicator_chart_window

#property indicator_buffers   0
#property indicator_plots     0

input int InpDepth    = 100; // Min Perioden zwischen 2 Hochs/Tiefs (Breite)
input int InpDeviation = 5; // Min Punkte zwischen 2 Hochs/Tiefs (Höhe)
input int InpBackstep = 50;  // Min Perioden zwischen 1 Hoch & 1 Tief
input ENUM_TIMEFRAMES     InpTimeframe = PERIOD_M5;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnInit() {

   IndicatorSetString(INDICATOR_SHORTNAME, "MarktTechnik(" + string(InpDepth) + "," + string(InpDeviation) + "," + string(InpBackstep) + ")");

   iCustomZigZagHandle = iCustom(Symbol(), PERIOD_M5, "Examples\\ZigZag", InpDepth, InpDeviation, InpBackstep);

   pointStruct.Point_1_Value = 0;
   pointStruct.Point_1_Datetime = 0;
   pointStruct.Point_2_Value = 0;
   pointStruct.Point_2_Datetime = 0;
   pointStruct.Point_3_Value = 0;
   pointStruct.Point_3_Datetime = 0;
   pointStruct.Point_4_Value = 0;
   pointStruct.Point_4_Datetime = 0;
   pointStruct.Point_5_Value = 0;
   pointStruct.Point_5_Datetime = 0;

}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnCalculate(const int pRatesTotal,
                const int pPrevCalculated,
                const datetime &pTime[],
                const double &pOpen[],
                const double &pHigh[],
                const double &pLow[],
                const double &pClose[],
                const long &pTickVolume[],
                const long &pVolume[],
                const int &pSpread[]         ) {

   int      barsTimeFrameCount;
   int      start, i;
   int      calculatedBars;

   if(NewCurrentBar() == true) {
      barsTimeFrameCount = Bars(Symbol(), InpTimeframe) - 1;
      if(barsTimeFrameCount < InpDepth || pRatesTotal < InpDepth)
         return(0);

      calculatedBars = BarsCalculated(iCustomZigZagHandle);
      if(calculatedBars < barsTimeFrameCount) {
         Print("Not all data of iCustomZigZagHandle is calculated (", calculatedBars, " bars ", barsTimeFrameCount, "). Error ", GetLastError());
         return(0);
      }

      if(pPrevCalculated == 0) {
         start = 0;
      } else {
         start = pPrevCalculated - 1;
      }

      for(i = start; i < pRatesTotal && !IsStopped(); i++) {
         if(i > 0) {
            if(CopyBuffer(iCustomZigZagHandle, 0, 0, InpDepth, iCustomZigZagArray) <= 0) {
               Print("Getting ZigZag failed! Error", GetLastError());
               return(0);
            }
         }

      }

      bool point5found = false;
      bool point4found = false;

      for(int index = ArraySize(iCustomZigZagArray) - 1; index >= 0 ; index--) {

         if(iCustomZigZagArray[index] > 0) {

            if(point5found == true && point4found == false) {
               if(pointStruct.Point_4_Value != iCustomZigZagArray[index]) {

                  pointStruct.Point_1_Value = pointStruct.Point_2_Value;
                  pointStruct.Point_1_Datetime = pointStruct.Point_2_Datetime;

                  pointStruct.Point_2_Value = pointStruct.Point_3_Value;
                  pointStruct.Point_2_Datetime = pointStruct.Point_3_Datetime;

                  pointStruct.Point_3_Value = pointStruct.Point_4_Value;
                  pointStruct.Point_3_Datetime = pointStruct.Point_4_Datetime;

                  pointStruct.Point_4_Value = iCustomZigZagArray[index];
                  pointStruct.Point_4_Datetime = iTime(Symbol(), PERIOD_CURRENT, ArraySize(iCustomZigZagArray) - index - 1);
                  point4found = true;
                  sendAlert = true;
               }
            }

            if(point5found == false) {
               pointStruct.Point_5_Value = iCustomZigZagArray[index];
               pointStruct.Point_5_Datetime = iTime(Symbol(), PERIOD_CURRENT, ArraySize(iCustomZigZagArray) - index - 1);
               point5found = true;
            }
         }
      }

      string trend = "nix";
      // UP-TREND
      if(
         pointStruct.Point_4_Value > pointStruct.Point_2_Value
         && pointStruct.Point_3_Value > pointStruct.Point_1_Value
         && pointStruct.Point_5_Value > pointStruct.Point_3_Value
         && pointStruct.Point_4_Value > pointStruct.Point_3_Value
         && pointStruct.Point_2_Value > pointStruct.Point_1_Value
      ) {
         trend = "UP";
         if(sendAlert == true) {
            string message = "UP-Trend: " + Symbol();
            Alert(message);
            if(!SendNotification(message)) Alert("Cannot Send Notification ", GetLastError());
            // https://www.mql5.com/de/docs/network/sendnotification
            sendAlert = false;
         }
      }

      // DOWN
      if(
         pointStruct.Point_4_Value < pointStruct.Point_2_Value
         && pointStruct.Point_3_Value < pointStruct.Point_1_Value
         && pointStruct.Point_5_Value < pointStruct.Point_3_Value
         && pointStruct.Point_4_Value < pointStruct.Point_3_Value
         && pointStruct.Point_2_Value < pointStruct.Point_1_Value
      ) {
         trend = "DOWN";
         if(sendAlert == true) {
            string message = "DOWN-Trend: " + Symbol();
            Alert(message);
            if(!SendNotification(message)) Alert("Cannot Send Notification ", GetLastError());
            // https://www.mql5.com/de/docs/network/sendnotification
            sendAlert = false;
         }
      }


      Comment( "Point1 : ", pointStruct.Point_1_Datetime, ": ", pointStruct.Point_1_Value, "\n"
               "Point2 : ", pointStruct.Point_2_Datetime, ": ", pointStruct.Point_2_Value, "\n"
               "Point3 : ", pointStruct.Point_3_Datetime, ": ", pointStruct.Point_3_Value, "\n"
               "Point4 : ", pointStruct.Point_4_Datetime, ": ", pointStruct.Point_4_Value, "\n"
               "Point5 : ", pointStruct.Point_5_Datetime, ": ", pointStruct.Point_5_Value, "\n"
               "Trend: ", trend

             );

   }

   return(pRatesTotal);
}