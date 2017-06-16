//+------------------------------------------------------------------+
//|                                                 PointToPrice.mq4 |
//|                                 Copyright 2017, Keisuke Iwabuchi |
//|                                        https://order-button.com/ |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, Keisuke Iwabuchi"
#property link      "https://order-button.com/"
#property version   "1.00"
#property strict


#include <mql4_modules\UnitTest\UnitTest.mqh>
#include <mql4_modules\Price\Price.mqh>
#include <mql4_modules\SymbolSearch\SymbolSearch.mqh>


UnitTest *test;


int OnInit()
{
   double result   = 0;
   double expected = 0;
   
   test = new UnitTest("Test Price module", "test");
   
   do {
      // point = 100
      result = Price::PointToPrice(100);
      switch(__Digits) {
         case 2: expected = 1;     break;
         case 3: expected = 0.1;   break;
         case 4: expected = 0.01;  break;
         case 5: expected = 0.001; break;
      }     
      test.TestValue(result, expected);
      
      
      // point = 0
      result = Price::PointToPrice(0);
      expected = 0;
      test.TestValue(result, expected);
   }
   while(test.loadNextEnvFile());
   
   delete(test);
   
   return(INIT_SUCCEEDED);
}


void OnTick(){}