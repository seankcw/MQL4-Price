//+------------------------------------------------------------------+
//|                                                        Price.mqh |
//|                                 Copyright 2017, Keisuke Iwabuchi |
//|                                        https://order-button.com/ |
//+------------------------------------------------------------------+
#property strict


/** muduleの2重読み込み防止用 */
#ifndef _LOAD_MODULE_PRICE
#define _LOAD_MODULE_PRICE


/** Include header files. */
#include <mql4_modules\Assert\Assert.mqh>
#include <mql4_modules\Env\Env.mqh>


/** 価格操作に関する処理 */
class Price
{
   private:
      static int mult;
      
      static void Initialize();

   public:
      static int    getMult(void);
      static bool   setMult(const int value);
      
      static int    PipsToPoint(const double pips_value);
      static double PipsToPrice(const double pips_value);
      static double PointToPips(const int point_value);
      static double PointToPrice(const int point_value);
      static double PriceToPips(const double price_value);
      static int    PriceToPoint(const double price_value);
};


/**
 * @var int mult pointとpips間の倍率
 */
int Price::mult = -1;


/**
 * 価格をpoint単位の値に変換する
 *
 * @param const double price_value 変換前の価格
 *
 * @return double 変換後の数値[point]
 */
static int Price::PriceToPoint(const double price_value)
{
   assert(price_value > 0, "invalid parameter price_value");
   
   return((int)NormalizeDouble(price_value / __Point, 0));
}


/**
 * 静的メンバ変数multの値を初期化する
 */
static void Price::Initialize(void)
{
   Price::mult = (__Digits == 3 || __Digits == 5) ? 10 : 1;
}


/**
 * メンバ変数multの値を取得する
 *
 * @return int メンバ変数multの値
 */
static int Price::getMult(void)
{
   return(Price::mult);
}

/**
 * メンバ変数multの値を変更する
 *
 * @param const int value メンバ変数multの値を変更する
 *
 * @return bool true:変更成功, false: 変更失敗
 */
static bool Price::setMult(const int value)
{
   if(value < 1) return(false);
   Price::mult = value;
   return(true);
}


/**
 * pips単位の値をpoint単位の値に変換する
 *
 * @param const double pips_value 変換前の数値[pips]
 *
 * @return double 変換後の数値[point]
 */
static int Price::PipsToPoint(const double pips_value)
{
   if(Price::mult < 0) Price::Initialize();
   #ifdef IS_DEBUG
      Price::Initialize();
   #endif
   
   return((int)NormalizeDouble(pips_value * Price::mult, 0));
}


/**
 * pips単位の値を価格に変換する
 *
 * @param const double pips_value 変換前の数値[pips]
 *
 * @return double 変換後の価格
 */
static double Price::PipsToPrice(const double pips_value)
{
   if(Price::mult < 0) Price::Initialize();
   #ifdef IS_DEBUG
      Price::Initialize();
   #endif
   
   return(pips_value * __Point * Price::mult);
}


/**
 * point単位の値をpips単位の値に変換する
 *
 * @param const double point_value 変換前の数値[point]
 *
 * @return double 変換後の数値[pips]
 */
static double Price::PointToPips(const int point_value)
{
   assert(point_value >= 0, "invalid parameter point_value");
   
   if(Price::mult < 0) Price::Initialize();
   #ifdef IS_DEBUG
      Price::Initialize();
   #endif
   
   return(point_value / Price::mult);
}


/**
 * point単位の値を価格に変換する
 *
 * @param const double point_value 変換前の数値[point]
 *
 * @return double 変換後の価格
 */
static double Price::PointToPrice(const int point_value)
{
   assert(point_value >= 0, "invalid parameter point_value");
   
   return(point_value * __Point);
}


/**
 * 価格をpips単位の値に変換する
 *
 * @param const double price_value 変換前の価格
 *
 * @return double 変換後の数値[pips]
 */
static double Price::PriceToPips(const double price_value)
{
   assert(price_value > 0, "invalid parameter price_value");
   
   if(Price::mult < 0) Price::Initialize();
   #ifdef IS_DEBUG
      Price::Initialize();
   #endif

   return(price_value / __Point / Price::mult);
}


#endif 
