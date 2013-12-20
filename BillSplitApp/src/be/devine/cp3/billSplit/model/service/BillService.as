package be.devine.cp3.billSplit.model.service {

import be.devine.cp3.billSplit.model.AppModel;

import flash.events.Event;

import flash.events.EventDispatcher;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

public class BillService extends EventDispatcher {

    public var bills:Array;

    public function BillService()
    {}

    public function load(arrPayers:Array):void
    {
        var billFile:File = File.applicationStorageDirectory.resolvePath("bills.json");

        if(!billFile.exists)
        {
            var writeStream:FileStream = new FileStream();
            writeStream.open(billFile, FileMode.WRITE);
            writeStream.writeUTFBytes(JSON.stringify([
                {
                    dummy: arrPayers
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
            //songs.push(SongVOFactory.createSongVOFromObject(bill));
        }

        this.bills = bills;

        dispatchEvent(new Event(Event.COMPLETE));
    }
}
}
