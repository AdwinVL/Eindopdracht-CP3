package be.devine.cp3.billSplit.factory {
import be.devine.cp3.billSplit.vo.BillVo;

public class BillVoFactory
{
    public static function createBillVOFromObject(bill:Object):BillVo
    {
        var billVo:BillVo = new BillVo();
        billVo.payers = [];

        for each(var payer:Object in bill.payers) {
            billVo.payers.push(PayerVoFactory.createPersonVOFromObject(payer));
        }

        billVo.name = bill.name;
        return billVo;
    }

    public static function createBillVOFromArray(bill:Array):BillVo
    {
        var billVo:BillVo = new BillVo();
        billVo.payers = [];

        for each(var payer:Object in bill) {
            billVo.payers.push(PayerVoFactory.createPersonVOFromObject(payer));
        }

        billVo.name = 'name';
        return billVo;
    }
}
}
