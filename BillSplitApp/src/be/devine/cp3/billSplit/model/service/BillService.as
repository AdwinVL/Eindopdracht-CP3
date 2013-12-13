package be.devine.cp3.billSplit.model.service {

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
        var songsFile:File = File.applicationStorageDirectory.resolvePath("bills.json");

        if(!songsFile.exists)
        {
            var writeStream:FileStream = new FileStream();
            writeStream.open(songsFile, FileMode.WRITE);
            writeStream.writeUTFBytes(JSON.stringify([
                {
                    file: "01.mp3",
                    title: "Little Green Bag",
                    artist: "George Baker Selection",
                    length: 195
                },
                {
                    file: "02.mp3",
                    title: "Hooked On A Feeling",
                    artist: "Blue Swede",
                    length: 173
                },
                {
                    file: "03.mp3",
                    title: "I Gotcha",
                    artist: "Joe Text",
                    length: 148
                },
                {
                    file: "04.mp3",
                    title: "Coconut",
                    artist: "Harry Nilsson",
                    length: 231
                }
            ]));
            writeStream.close();
        }

        var readStream:FileStream = new FileStream();
        readStream.open(songsFile, FileMode.READ);

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
