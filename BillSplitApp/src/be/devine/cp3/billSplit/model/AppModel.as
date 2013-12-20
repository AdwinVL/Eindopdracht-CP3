package be.devine.cp3.billSplit.model {

import be.devine.cp3.billSplit.model.service.BillService;
import be.devine.cp3.billSplit.vo.BillVo;

import flash.events.Event;

import flash.events.EventDispatcher;

public class AppModel extends EventDispatcher
{
    private static var instance:AppModel;

    public static const PRICE_CHANGED:String = "currentPageChanged";
    public static const PAYERS_LOADED:String = "payers loaded";

    private var _destination:String = "";
    private var _previousPage:String = "";

    private var _payers:uint = 3;
    private var _maxPayers:uint = 20;
    private var _arrPayers:Array;
    private var _price:uint = 0;
    private var _maxPriceChar:uint = 4;
    private var _procent:uint;
    private var _arrBills:Array;

    public static function getInstance():AppModel
    {
        if (instance == null) {
            instance = new AppModel(new Enforcer());
        }
        return instance;
    }

    public function AppModel(e:Enforcer)
    {
        if (e == null)
        {
            throw new Error("AppModel is a singleton, use getInstance() instead");
        }

        _arrPayers = [];
    }

    [Bindable(event="destinationChanged")]
    public function get destination():String
    {
        return _destination;
    }

    public function set destination(value:String):void
    {
        if (_destination == value) return;
        _destination = value;
    }

    public function load():void
    {
        var billService:BillService = new BillService();
        billService.addEventListener(Event.COMPLETE, loadCompleteHandler);
        billService.load();
    }

    private function loadCompleteHandler(event:Event):void
    {
        var billService:BillService = event.target as BillService;
        this._arrBills = billService.bills;

        dispatchEvent(new Event(PAYERS_LOADED));
    }

    public function update(bills:BillVo):void
    {
        var billService:BillService = new BillService();
        billService.updateJson(bills);
    }

    public function get payers():uint
    {
        return _payers;
    }

    public function set payers(value:uint):void
    {
        _payers = value;
    }

    public function get price():uint
    {
        return _price;
    }

    public function set price(value:uint):void
    {
        if (_price == value) return;
        _price = value;

        dispatchEvent(new Event(PRICE_CHANGED));
    }
    public function get arrPayers():Array
    {
        return _arrPayers;
    }

    public function set arrPayers(value:Array):void
    {
        _arrPayers = value;
    }

    public function get procent():uint
    {
        return _procent;
    }

    public function set procent(value:uint):void
    {
        _procent = value;
    }

    public function get maxPayers():uint {
        return _maxPayers;
    }

    public function set maxPayers(value:uint):void {
        _maxPayers = value;
    }

    public function get maxPriceChar():uint {
        return _maxPriceChar;
    }

    public function set maxPriceChar(value:uint):void {
        _maxPriceChar = value;
    }

    public function get previousPage():String {
        return _previousPage;
    }

    public function set previousPage(value:String):void {
        _previousPage = value;
    }

    public function get arrBills():Array {
        return _arrBills;
    }

    public function set arrBills(value:Array):void {
        _arrBills = value;
    }
}
}

internal class Enforcer {}