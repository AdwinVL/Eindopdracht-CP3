package be.devine.cp3.billSplit.model.service {

import be.devine.cp3.billSplit.factory.BillVoFactory;
import be.devine.cp3.billSplit.model.AppModel;
import be.devine.cp3.billSplit.vo.BillVo;

import flash.events.Event;

import flash.events.EventDispatcher;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

public class BillService extends EventDispatcher {

    public var bills:Array;

    public function BillService()
    {}

    public function load():void
    {
        var billFile:File = File.applicationStorageDirectory.resolvePath("bills.json");

        if(!billFile.exists)
        {
            var writeStream:FileStream = new FileStream();
            writeStream.open(billFile, FileMode.WRITE);
            writeStream.writeUTFBytes(JSON.stringify([
                {
                    "bills": [
                        { "title":"Default", "payers": [
                            {"name": "App owner", "price": "100"}
                        ]}
                    ]
                }
            ]));
            writeStream.close();
        }

        var readStream:FileStream = new FileStream();
        readStream.open(billFile, FileMode.READ);

        var str:String = readStream.readUTFBytes(readStream.bytesAvailable);
        var parsedJSON:Array = JSON.parse(str) as Array;

        readStream.close();

        var bills:Array = [];

        for each(var bill:Object in parsedJSON)
        {
            bills.push(BillVoFactory.createBillVOFromObject(bill));
        }

        this.bills = bills;

        dispatchEvent(new Event(Event.COMPLETE));
    }

    public function updateJson(bills:BillVo):void
    {
        var billFile:File = File.applicationStorageDirectory.resolvePath("bills.json");

        if(!billFile.exists) {
            var writeStream:FileStream = new FileStream();
            writeStream.open(billFile, FileMode.WRITE);
            writeStream.writeUTFBytes(JSON.stringify([
                {
                    "bills": [
                        { "title":"Default", "payers": [
                            {"name": "App owner", "price": "100"}
                        ]}
                    ]
                }
            ]));
            writeStream.close();
        }
        var fs:FileStream = new FileStream();
        fs.open(billFile, FileMode.WRITE);

        var jsonString:String = JSON.stringify(bills);
        jsonString = '{ "bills":' + jsonString + '}';

        fs.writeUTFBytes(jsonString);
        fs.close();

    }


}
}
